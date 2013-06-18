#import "NSSet+Linq.h"
#import "LQEnumerator.h"

@implementation NSSet (Linq)

- (NSEnumerator*) linqEnumerator {
    return [self objectEnumerator];
}

@dynamic select;
- (LQSelectBlock) select {
    return [self linqEnumerator].select;
}

@dynamic where;
- (LQWhereBlock) where {
    return [self linqEnumerator].where;
}

@dynamic selectMany;
- (LQSelectManyBlock) selectMany {
    return [self linqEnumerator].selectMany;
}

@dynamic toArray;
- (LQArrayBlock) toArray {
    WeakRefAttribute NSSet* weakSelf = self;
    LQArrayBlock block = ^NSArray*(void) {
        return [weakSelf allObjects];
    };
    
    return [Block_copy(block) autorelease];
}


@dynamic toSet;
- (LQSetBlock) toSet {
    WeakRefAttribute NSSet* weakSelf = self;
    LQSetBlock block = ^(void) {
        return [[weakSelf retain] autorelease];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic orderBy;
- (LQOrderByBlock) orderBy {
    return self.linqEnumerator.orderBy;
}

@dynamic orderByDescending;
- (LQOrderByBlock) orderByDescending {
    return self.linqEnumerator.orderByDescending;
}

@dynamic toDictionary;
- (LQDictionaryBlock) toDictionary {
    return [self linqEnumerator].toDictionary;
}

@dynamic distinct;
- (LQDistinctBlock) distinct {
    return [self linqEnumerator].distinct;
}

@dynamic skip;
- (LQSkipBlock) skip {
    return [self linqEnumerator].skip;
}

@dynamic skipWhile;
- (LQSkipWithPredicateBlock) skipWhile {
    return [self linqEnumerator].skipWhile;
}

@dynamic take;
- (LQSTakeBlock) take {
    return [self linqEnumerator].take;
}

@dynamic takeWhile;
- (LQSTakeWithPredicateBlock) takeWhile {
    return [self linqEnumerator].takeWhile;
    
}

@dynamic all;
- (LQAllBlock) all {
    return [self linqEnumerator].all;
}

@dynamic any;
- (LQAnyBlock) any {
    return [self linqEnumerator].any;
    
}

@dynamic aggregateWithSeed;
- (LQAggregateWithSeed) aggregateWithSeed {
    return [self linqEnumerator].aggregateWithSeed;
}

@dynamic aggregate;
- (LQAggregate) aggregate {
    return [self linqEnumerator].aggregate;
}

@dynamic single;
- (ResultBlock) single {
    return [self linqEnumerator].single;
}

@dynamic singleWithPredicate;
- (ResultWithPredicateBlock) singleWithPredicate {
    return [self linqEnumerator].singleWithPredicate;
}

@dynamic singleOrNil;
- (ResultBlock) singleOrNil {
    return [self linqEnumerator].singleOrNil;
}

@dynamic singleOrNilWithPredicate;
- (ResultWithPredicateBlock) singleOrNilWithPredicate {
    return [self linqEnumerator].singleOrNilWithPredicate;
}


@dynamic first;
- (ResultBlock) first {
    return [self linqEnumerator].first;
}

@dynamic firstWithPredicate;
- (ResultWithPredicateBlock) firstWithPredicate {
    return [self linqEnumerator].firstWithPredicate;
}

@dynamic firstOrNil;
- (ResultBlock) firstOrNil {
    return [self linqEnumerator].firstOrNil;
}

@dynamic firstOrNilWithPredicate;
- (ResultWithPredicateBlock) firstOrNilWithPredicate {
    return [self linqEnumerator].firstOrNilWithPredicate;
}

@dynamic last;
- (ResultBlock) last {
    return [self linqEnumerator].last;
}

@dynamic lastWithPredicate;
- (ResultWithPredicateBlock) lastWithPredicate {
    return [self linqEnumerator].lastWithPredicate;
}

@dynamic lastOrNil;
- (ResultBlock) lastOrNil {
    return [self linqEnumerator].lastOrNil;
}

@dynamic lastOrNilWithPredicate;
- (ResultWithPredicateBlock) lastOrNilWithPredicate {
    return [self linqEnumerator].lastOrNilWithPredicate;
}

@dynamic length;
- (LQCountBlock) length {
    return [self linqEnumerator].length;
}

@dynamic lengthWithPredicate;
- (LQCountWithPredicateBlock) lengthWithPredicate {
    return [self linqEnumerator].lengthWithPredicate;
}

@dynamic ofClass;
- (LQOfClassBlock) ofClass {
    return [self linqEnumerator].ofClass;
}

@dynamic contains;
- (LQPredicate) contains {
    WeakRefAttribute NSSet* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        return [weakSelf containsObject:item];
    };
    
    return [Block_copy(block) autorelease];
}

@dynamic forEach;
- (LQForEachBlock) forEach {
    return [self linqEnumerator].forEach;
}

@dynamic concat;
- (LQConcatBlock) concat {
    return [self linqEnumerator].concat;
}

@dynamic unions;
- (LQConcatBlock) unions {
    return [self linqEnumerator].unions;
}

@dynamic except;
- (LQConcatBlock) except {
    return [self linqEnumerator].except;
}

@dynamic intersect;
- (LQConcatBlock) intersect {
    return [self linqEnumerator].intersect;
}

@dynamic min;
- (LQMinMaxBlock) min {
    return [self linqEnumerator].min;
}

@dynamic max;
- (LQMinMaxBlock) max {
    return [self linqEnumerator].max;
}

@dynamic minBy;
- (LQMinMaxByBlock) minBy {
    return [self linqEnumerator].minBy;
}

@dynamic maxBy;
- (LQMinMaxByBlock) maxBy {
    return [self linqEnumerator].maxBy;
}

@dynamic zip;
- (LQZipBlock) zip {
    return self.linqEnumerator.zip;
}

@end

CATEGORY_LINK_FIX_IMPL(NSSet_Linq)