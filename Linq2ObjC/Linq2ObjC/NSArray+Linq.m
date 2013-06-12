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

@dynamic toDictionary;
- (LQDictionaryBlock) toDictionary {
    return [self objectEnumerator].toDictionary;
}

@dynamic disctinct;
- (LQDistinctBlock) disctinct {
    return [self objectEnumerator].disctinct;
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

@end

CATEGORY_LINK_FIX_IMPL(NSArray_Linq)