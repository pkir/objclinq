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
- (NSArray*) toArray {
    return self;
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

@end

CATEGORY_LINK_FIX_IMPL(NSArray_Linq)