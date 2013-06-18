#import "LQEnumerator.h"
#import "NSArray+Linq.h"
#import "Macros.h"

LQProjection kLQIdentity = ^id(id item) {
    return item;
};

NSComparator kLQDefaultComparator = ^(id a, id b) {
    return [a compare:b];
};

LQPredicate kLQYesPredicate = ^(id item) {
    return YES;
};

LQPredicate kLQNoPredicate = ^(id item) {
    return NO;
};

@implementation LQEnumerator

- (id)initWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject {
    if (self = [super init]) {
        _src = src;
        _nextObject = [Block_copy(nextObject) autorelease];
    }
    
    return self;
}

- (id)nextObject {
    return _nextObject(_src);
}

+ (LQEnumerator*)enumeratorWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject {
    return [[self alloc] initWithFunction:src nextObjectBlock:nextObject];
}
@end

@interface LQEnumerableEnumerator : NSEnumerator {
    id(^nextObject_)();
}

- (id) initWithEnumerable:(id<LQEnumerable>)collection;
+ (LQEnumerableEnumerator*) enumeratorWithEnumerable:(id<LQEnumerable>)collection;

@property (nonatomic, retain) id<LQEnumerable> collection;
@end

@implementation LQEnumerableEnumerator

- (id) initWithEnumerable:(id<LQEnumerable>)collection {
    self = [super init];
    if (self) {
        // declare all the local state needed
        __block NSFastEnumerationState state = { 0 };
        __block id stackbuf[16];
        __block BOOL firstLoop = YES;
        __block long mutationsPtrValue;
        __block id* stackbufPtr = stackbuf;
        __block NSUInteger index = -1;
        __block NSUInteger lastCount = -1;
        
        id(^block)() = ^{
            if (index != -1 && lastCount != -1 && index < lastCount) {
                id obj = state.itemsPtr[index];
                index++;
                
                return obj;
            }
            
            NSUInteger count = [collection countByEnumeratingWithState:&state objects:stackbufPtr count: 16];
            if (!count) {
                return (id)nil;
            }
            
            lastCount = count;
            index = 0;
            
            id obj = state.itemsPtr[index];
            index++;
            
            return obj;
        };
        
        nextObject_ = Block_copy(block);
    }
    
    return self;
}

+ (LQEnumerableEnumerator*) enumeratorWithEnumerable:(id<LQEnumerable>)collection {
    return [[[self alloc] initWithEnumerable:collection] autorelease];
}

- (id) nextObject {
    return nextObject_();
}


- (void) dealloc {
    Block_release(nextObject_);
    [super dealloc];
}

@end


@implementation NSEnumerator(Linq)

@dynamic select;
- (LQSelectBlock) select {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSelectBlock block = ^id<LQEnumerable>(LQProjection fn) {
        LQProjection sel = [Block_copy(fn) autorelease];
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            id item = nil;
            while((item = [src nextObject])) {
                return sel(item);
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic where;
- (LQWhereBlock) where {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQWhereBlock block = ^id<LQEnumerable>(LQPredicate fn) {
        LQPredicate filter = [Block_copy(fn) autorelease];
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            id item = nil;
            while((item = [src nextObject])) {
                if (filter(item)) {
                    return item;
                }
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic selectMany;
// Functional "bind", let's assume there is "yield" operator in ObjC, the
// result of calling a.SelectMany(LQSelectMany collectionSelector);
// where a is LQEnumerable would be:
// for(id item in a) {
//      for (id subitem in collectionSelector(item)) {
//          yield return subitem;
//      }
// }
- (LQSelectManyBlock) selectMany {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSelectManyBlock block = ^id<LQEnumerable>(LQSelectMany fn) {
        LQSelectMany collectionSelector = [Block_copy(fn) autorelease];
        __block NSEnumerator* it = nil;
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            while (true) {
                if (!it) {
                    id item = [src nextObject];
                    if (!item) {
                        return nil;
                    }
                    
                    id<LQEnumerable> collection = collectionSelector(item);
                    if (![collection respondsToSelector:@selector(objectEnumerator)]) {
                        it = [LQEnumerableEnumerator enumeratorWithEnumerable:collection];
                    } else {
                        it = [collection objectEnumerator];
                    }
                }
                
                id next = [it nextObject];
                if (next) {
                    return next;
                }
                
                it = nil;
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic distinct;
- (LQDistinctBlock) distinct {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQDistinctBlock block = ^{
        __block NSMutableSet* returnedItems = [NSMutableSet set];
        
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            id item = nil;
            while((item = [src nextObject])) {
                if (![returnedItems containsObject:item]) {
                    [returnedItems addObject:item];
                    return item;
                }
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic skip;
- (LQSkipBlock) skip {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSkipBlock block = ^(NSUInteger count){
        __block NSUInteger i = 0;
        
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            while (i++ < count) {
                id item = [src nextObject];
                if (!item) {
                    return nil;
                }
            }
            
            return [src nextObject];
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic skipWhile;
- (LQSkipWithPredicateBlock) skipWhile {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSkipWithPredicateBlock block = ^(LQPredicate fn){
        LQPredicate predicate = [Block_copy(fn) autorelease];
        __block BOOL skip = YES;
        
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            id item = nil;
            while ((item = [src nextObject])) {
                if (skip && !predicate(item)) {
                    skip = NO;
                }
                
                if (!skip) {
                    return item;
                }
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic take;
- (LQSTakeBlock) take {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSTakeBlock block = ^(NSUInteger count){
        __block NSUInteger i = 0;
        
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            while (i++ < count) {
                return [src nextObject];
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic takeWhile;
- (LQSTakeWithPredicateBlock) takeWhile {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSTakeWithPredicateBlock block = ^(LQPredicate fn){
        LQPredicate predicate = [Block_copy(fn) autorelease];
        
        return [LQEnumerator enumeratorWithFunction:weakSelf nextObjectBlock:^id(NSEnumerator* src) {
            id item = nil;
            while ((item = [src nextObject])) {
                if (!predicate(item)) {
                    return nil;
                }
                
                return item;
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];

}

@dynamic all;
- (LQAllBlock) all {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQAllBlock block = ^(LQPredicate fn){
        LQPredicate predicate = [Block_copy(fn) autorelease];
        
        for (id item in weakSelf) {
            if (!predicate(item)) {
                return NO;
            }
        }
        
        return YES;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic any;
- (LQAnyBlock) any {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQAllBlock block = ^(LQPredicate fn){
        LQPredicate predicate = [Block_copy(fn) autorelease];
        
        for (id item in weakSelf) {
            if (predicate(item)) {
                return YES;
            }
        }
        
        return NO;
    };
    
    return [Block_copy(block) autorelease];

}

@dynamic aggregateWithSeed;
- (LQAggregateWithSeed) aggregateWithSeed {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQAggregateWithSeed block = ^(id seed, LQAggregator aggregator) {
        for (id item in weakSelf) {
            seed = aggregator(seed, item);
        }
        
        return seed;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic aggregate;
- (LQAggregate) aggregate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQAggregate block = ^(LQAggregator fn) {
        return weakSelf.aggregateWithSeed(nil, fn);
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic single;
- (ResultBlock) single {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        id obj = [weakSelf nextObject];
        if (obj && [weakSelf nextObject] == nil) {
            return obj;
        }
        
        @throw [NSException exceptionWithName:@"InvalidOperationException" reason:nil userInfo:nil];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic singleWithPredicate;
- (ResultWithPredicateBlock) singleWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).single();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic singleOrNil;
- (ResultBlock) singleOrNil {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        id obj = [weakSelf nextObject];
        if ([weakSelf nextObject] == nil) {
            return obj;
        }
        
        @throw [NSException exceptionWithName:@"InvalidOperationException" reason:nil userInfo:nil];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic singleOrNilWithPredicate;
- (ResultWithPredicateBlock) singleOrNilWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).singleOrNil();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic first;
- (ResultBlock) first {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        id obj = weakSelf.firstOrNil();
        if (obj) {
            return obj;
        }
        
        @throw [NSException exceptionWithName:@"InvalidOperationException" reason:nil userInfo:nil];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic firstWithPredicate;
- (ResultWithPredicateBlock) firstWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).first();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic firstOrNil;
- (ResultBlock) firstOrNil {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        id obj = [weakSelf nextObject];
        return obj;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic firstOrNilWithPredicate;
- (ResultWithPredicateBlock) firstOrNilWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).firstOrNil();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic last;
- (ResultBlock) last {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        id obj = [weakSelf.toArray() lastObject];
        if (obj) {
            return obj;
        }
        
        @throw [NSException exceptionWithName:@"InvalidOperationException" reason:nil userInfo:nil];
    };
    
    return [Block_copy(block) autorelease];

}

@dynamic lastWithPredicate;
- (ResultWithPredicateBlock) lastWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).last();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic lastOrNil;
- (ResultBlock) lastOrNil {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultBlock block = ^{
        NSArray* arr = weakSelf.toArray();
        return [arr lastObject];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic lastOrNilWithPredicate;
- (ResultWithPredicateBlock) lastOrNilWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    ResultWithPredicateBlock block = ^(LQPredicate predicate) {
        return weakSelf.where(predicate).lastOrNil();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic length;
- (LQCountBlock) length {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQCountBlock block = ^{
        return self.toArray().count;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic lengthWithPredicate;
- (LQCountWithPredicateBlock) lengthWithPredicate {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQCountWithPredicateBlock block = ^NSUInteger(LQPredicate predicate){
        return weakSelf.where(predicate).length();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic ofClass;
- (LQOfClassBlock) ofClass {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQOfClassBlock block = ^(Class classType) {
        return weakSelf.where(^(id item) { return [item isKindOfClass:classType]; });
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic contains;
- (LQPredicate) contains {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        for (id itItem in weakSelf) {
            if ([item isEqual:itItem]) {
                return YES;
            }
        }
        
        return NO;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic forEach;
- (LQForEachBlock) forEach {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQForEachBlock block = ^(LQAction action){
        for (id item in weakSelf) {
            action(item);
        }
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic concat;
- (LQConcatBlock) concat {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQConcatBlock block = ^(id<LQEnumerable> collection) {
        return [LQEnumerator enumeratorWithFunction:[LQEnumerableEnumerator enumeratorWithEnumerable:collection]
                                    nextObjectBlock:^id(NSEnumerator* src)
        {
            id item = nil;
            while ((item = [weakSelf nextObject])) {
                return item;
            }
            
            while ((item = [src nextObject])) {
                return item;
            }
            
            return nil;
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic unions;
- (LQConcatBlock) unions {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQConcatBlock block = ^(id<LQEnumerable> collection) {
        return weakSelf.concat(collection).distinct();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic except;
- (LQConcatBlock) except {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQConcatBlock block = ^(id<LQEnumerable> collection) {
        NSSet* dst = collection.toSet();
        return weakSelf.where(^BOOL(id item) { return ![dst containsObject:item]; });
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic intersect;
- (LQConcatBlock) intersect {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQConcatBlock block = ^(id<LQEnumerable> collection) {
        NSSet* dst = collection.toSet();
        return weakSelf.where(^BOOL(id item) { return [dst containsObject:item]; });
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic orderBy;
- (LQOrderByBlock) orderBy {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQOrderByBlock block = ^(LQProjection keySelector, NSComparator comparator) {
        NSComparator cmp = ^(id x, id y) {
            return comparator(keySelector(x), keySelector(y));
        };
        
        return (id<LQEnumerable>)[weakSelf.toArray() sortedArrayUsingComparator:cmp];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic orderByDescending;
- (LQOrderByBlock) orderByDescending {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQOrderByBlock block = ^(LQProjection keySelector, NSComparator comparator) {
        NSComparator cmp = ^(id x, id y) {
            return -comparator(keySelector(x), keySelector(y));
        };
        
        return (id<LQEnumerable>)[weakSelf.toArray() sortedArrayUsingComparator:cmp];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic min;
- (LQMinMaxBlock) min {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQMinMaxBlock block = ^(NSComparator comparator) {
        return weakSelf.minBy(kLQIdentity, comparator).first();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic max;
- (LQMinMaxBlock) max {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQMinMaxBlock block = ^(NSComparator comparator) {
        return weakSelf.maxBy(kLQIdentity, comparator).first();
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic minBy;
- (LQMinMaxByBlock) minBy {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQMinMaxByBlock block = ^(LQProjection keySelector, NSComparator comparator) {
        return [weakSelf extremeBy:keySelector comparator:^NSComparisonResult(id obj1, id obj2) {
            return -comparator(obj1, obj2);
        }];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic maxBy;
- (LQMinMaxByBlock) maxBy {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQMinMaxByBlock block = ^(LQProjection keySelector, NSComparator comparator) {
        return [weakSelf extremeBy:keySelector comparator:comparator];
    };
    
    return [Block_copy(block) autorelease];
}

- (NSArray*) extremeBy:(LQProjection)keySelector comparator:(NSComparator)comparator {
    NSMutableArray* result = [NSMutableArray array];
    
    id current = [self nextObject];
    if (!current) {
        @throw [NSException exceptionWithName:@"InvalidOperationException" reason:nil userInfo:nil];
    }
    
    id resKey = keySelector(current);
    [result addObject:current];
    
    id cur = nil;
    while ((cur = [self nextObject])) {
        id key = keySelector(cur);
        
        NSComparisonResult cmp = comparator(key, resKey);
        if (cmp == 0) {
            [result addObject:cur];
        } else if (cmp > 0) {
            [result removeAllObjects];
            [result addObject:cur];
            resKey = key;
        }
    }
    
    return result;
}

@dynamic zip;
- (LQZipBlock) zip {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQZipBlock block = ^(id<LQEnumerable> second, LQZipper returnSelector) {
        return [LQEnumerator enumeratorWithFunction:[LQEnumerableEnumerator enumeratorWithEnumerable:second]
                                    nextObjectBlock:^id(NSEnumerator* src)
        {
            id itemFirst = nil;
            id itemSecond = nil;
            while ((itemFirst = [weakSelf nextObject]) != nil && (itemSecond = [src nextObject]) != nil) {
                id res = returnSelector(itemFirst, itemSecond);
                return res;
            }
            
            return nil;
        }];

    };
    
    return [Block_copy(block) autorelease];
}

@dynamic toArray;
- (LQArrayBlock) toArray {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQArrayBlock block = ^{
        return weakSelf.allObjects;
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic toSet;
- (LQSetBlock) toSet {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQSetBlock block = ^(void) {
        return [NSSet setWithArray:weakSelf.allObjects];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic toDictionary;
- (LQDictionaryBlock) toDictionary {
    WeakRefAttribute NSEnumerator* weakSelf = self;
    LQDictionaryBlock block = ^(LQProjection keySelector, LQProjection valueSelector) {
        NSMutableDictionary* result = [NSMutableDictionary dictionary];
        for (id item in weakSelf) {
            id key = keySelector(item);
            id value = valueSelector(item);
            
            [result setObject:value forKey:key];
        }
        
        return (NSDictionary*)result;
    };
    
    return [Block_copy(block) autorelease];
}

@end