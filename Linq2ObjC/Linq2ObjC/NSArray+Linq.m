#import "NSArray+Linq.h"
#import "LQEnumerator.h"

@implementation NSArray (Linq)

@dynamic select;
- (LQSelectBlock) select {
    return [self objectEnumerator].select;
}

@dynamic where;
- (LQWhereBlock) where {
    return [self objectEnumerator].where;
}

@dynamic selectMany;
- (LQSelectManyBlock) selectMany {
    return [self objectEnumerator].selectMany;
}

@dynamic toArray;
- (LQArrayBlock) toArray {
    WeakRefAttribute NSArray* weakSelf = self;
    LQArrayBlock block = ^NSArray*(void) {
        return [[weakSelf retain] autorelease];
    };
    
    return LQ_AUTORELEASE(Block_copy(block));
}


@dynamic toSet;
- (LQSetBlock) toSet {
    WeakRefAttribute NSArray* weakSelf = self;
    LQSetBlock block = ^(void) {
        return [NSSet setWithArray:weakSelf];
    };
    
    return LQ_AUTORELEASE(Block_copy(block));
}

@dynamic orderBy;
- (LQOrderByBlock) orderBy {
    WeakRefAttribute NSArray* weakSelf = self;
    LQOrderByBlock block = ^(NSComparator comparator) {
        return [weakSelf sortedArrayUsingComparator:comparator];
    };
    
    return LQ_AUTORELEASE(Block_copy(block));
}

@dynamic toDictionary;
- (LQDictionaryBlock) toDictionary {
    return [self objectEnumerator].toDictionary;
}

@dynamic distinct;
- (LQDistinctBlock) distinct {
    return [self objectEnumerator].distinct;
}

@dynamic skip;
- (LQSkipBlock) skip {
    return [self objectEnumerator].skip;
}

@dynamic skipWhile;
- (LQSkipWithPredicateBlock) skipWhile {
    return [self objectEnumerator].skipWhile;
}

@dynamic take;
- (LQSTakeBlock) take {
    return [self objectEnumerator].take;
}

@dynamic takeWhile;
- (LQSTakeWithPredicateBlock) takeWhile {
    return [self objectEnumerator].takeWhile;
    
}

@dynamic all;
- (LQAllBlock) all {
    return [self objectEnumerator].all;
}

@dynamic any;
- (LQAnyBlock) any {
    return [self objectEnumerator].any;
    
}

@dynamic aggregateWithSeed;
- (LQAggregateWithSeed) aggregateWithSeed {
    return [self objectEnumerator].aggregateWithSeed;
}

@dynamic aggregate;
- (LQAggregate) aggregate {
    return [self objectEnumerator].aggregate;
}

@dynamic single;
- (ResultBlock) single {
    return [self objectEnumerator].single;
}

@dynamic singleWithPredicate;
- (ResultWithPredicateBlock) singleWithPredicate {
    return [self objectEnumerator].singleWithPredicate;
}

@dynamic singleOrNil;
- (ResultBlock) singleOrNil {
    return [self objectEnumerator].singleOrNil;
}

@dynamic singleOrNilWithPredicate;
- (ResultWithPredicateBlock) singleOrNilWithPredicate {
    return [self objectEnumerator].singleOrNilWithPredicate;
}


@dynamic first;
- (ResultBlock) first {
    return [self objectEnumerator].first;
}

@dynamic firstWithPredicate;
- (ResultWithPredicateBlock) firstWithPredicate {
    return [self objectEnumerator].firstWithPredicate;
}

@dynamic firstOrNil;
- (ResultBlock) firstOrNil {
    return [self objectEnumerator].firstOrNil;
}

@dynamic firstOrNilWithPredicate;
- (ResultWithPredicateBlock) firstOrNilWithPredicate {
    return [self objectEnumerator].firstOrNilWithPredicate;
}

@dynamic last;
- (ResultBlock) last {
    return [self objectEnumerator].last;
}

@dynamic lastWithPredicate;
- (ResultWithPredicateBlock) lastWithPredicate {
    return [self objectEnumerator].lastWithPredicate;
}

@dynamic lastOrNil;
- (ResultBlock) lastOrNil {
    return [self objectEnumerator].lastOrNil;
}

@dynamic lastOrNilWithPredicate;
- (ResultWithPredicateBlock) lastOrNilWithPredicate {
    return [self objectEnumerator].lastOrNilWithPredicate;
}

@dynamic length;
- (LQCountBlock) length {
    return [self objectEnumerator].length;
}

@dynamic lengthWithPredicate;
- (LQCountWithPredicateBlock) lengthWithPredicate {
    return [self objectEnumerator].lengthWithPredicate;
}

@dynamic ofClass;
- (LQOfClassBlock) ofClass {
    return [self objectEnumerator].ofClass;
}

@dynamic contains;
- (LQPredicate) contains {
    WeakRefAttribute NSArray* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        return [weakSelf containsObject:item];
    };
    
    return LQ_AUTORELEASE(Block_copy(block));
}

@dynamic forEach;
- (LQForEachBlock) forEach {
    return [self objectEnumerator].forEach;
}

@dynamic concat;
- (LQConcatBlock) concat {
    return [self objectEnumerator].concat;
}

@dynamic unions;
- (LQConcatBlock) unions {
    return [self objectEnumerator].unions;
}

@dynamic except;
- (LQConcatBlock) except {
    return [self objectEnumerator].except;
}

@dynamic intersect;
- (LQConcatBlock) intersect {
    return [self objectEnumerator].intersect;
}

@dynamic min;
- (LQMinMaxBlock) min {
    return [self objectEnumerator].min;
}

@dynamic max;
- (LQMinMaxBlock) max {
    return [self objectEnumerator].max;
}

@dynamic minBy;
- (LQMinMaxByBlock) minBy {
    return [self objectEnumerator].minBy;
}

@dynamic maxBy;
- (LQMinMaxByBlock) maxBy {
    return [self objectEnumerator].maxBy;
}

@end

CATEGORY_LINK_FIX_IMPL(NSArray_Linq)