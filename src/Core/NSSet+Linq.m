#import "NSSet+Linq.h"
#import "LQEnumerator.h"

@implementation NSSet (Linq)

- (NSEnumerator*) linqEnumerator {
    return [self objectEnumerator];
}

- (LQSelectBlock) select {
    return [self linqEnumerator].select;
}

- (LQWhereBlock) where {
    return [self linqEnumerator].where;
}

- (LQSelectManyBlock) selectMany {
    return [self linqEnumerator].selectMany;
}

- (LQArrayBlock) toArray {
    WeakRefAttribute NSSet* weakSelf = self;
    LQArrayBlock block = ^NSArray*(void) {
        return [weakSelf allObjects];
    };
    
    return [Block_copy(block) autorelease];
}

- (LQSetBlock) toSet {
    WeakRefAttribute NSSet* weakSelf = self;
    LQSetBlock block = ^(void) {
        return [[weakSelf retain] autorelease];
    };
    
    return [Block_copy(block) autorelease];
}

- (LQOrderByBlock) orderBy {
    return self.linqEnumerator.orderBy;
}

- (LQOrderByBlock) orderByDescending {
    return self.linqEnumerator.orderByDescending;
}

- (LQDictionaryBlock) toDictionary {
    return [self linqEnumerator].toDictionary;
}

- (LQDistinctBlock) distinct {
    return [self linqEnumerator].distinct;
}

- (LQSkipBlock) skip {
    return [self linqEnumerator].skip;
}

- (LQSkipWithPredicateBlock) skipWhile {
    return [self linqEnumerator].skipWhile;
}

- (LQSTakeBlock) take {
    return [self linqEnumerator].take;
}

- (LQSTakeWithPredicateBlock) takeWhile {
    return [self linqEnumerator].takeWhile;
    
}

- (LQAllBlock) all {
    return [self linqEnumerator].all;
}

- (LQAnyBlock) any {
    return [self linqEnumerator].any;
    
}

- (LQAggregateWithSeed) aggregateWithSeed {
    return [self linqEnumerator].aggregateWithSeed;
}

- (LQAggregate) aggregate {
    return [self linqEnumerator].aggregate;
}

- (ResultBlock) single {
    return [self linqEnumerator].single;
}

- (ResultWithPredicateBlock) singleWithPredicate {
    return [self linqEnumerator].singleWithPredicate;
}

- (ResultBlock) singleOrNil {
    return [self linqEnumerator].singleOrNil;
}

- (ResultWithPredicateBlock) singleOrNilWithPredicate {
    return [self linqEnumerator].singleOrNilWithPredicate;
}

- (ResultBlock) first {
    return [self linqEnumerator].first;
}

- (ResultWithPredicateBlock) firstWithPredicate {
    return [self linqEnumerator].firstWithPredicate;
}

- (ResultBlock) firstOrNil {
    return [self linqEnumerator].firstOrNil;
}

- (ResultWithPredicateBlock) firstOrNilWithPredicate {
    return [self linqEnumerator].firstOrNilWithPredicate;
}

- (ResultBlock) last {
    return [self linqEnumerator].last;
}

- (ResultWithPredicateBlock) lastWithPredicate {
    return [self linqEnumerator].lastWithPredicate;
}

- (ResultBlock) lastOrNil {
    return [self linqEnumerator].lastOrNil;
}

- (ResultWithPredicateBlock) lastOrNilWithPredicate {
    return [self linqEnumerator].lastOrNilWithPredicate;
}

- (LQCountBlock) length {
    return [self linqEnumerator].length;
}

- (LQCountWithPredicateBlock) lengthWithPredicate {
    return [self linqEnumerator].lengthWithPredicate;
}

- (LQOfClassBlock) ofClass {
    return [self linqEnumerator].ofClass;
}

- (LQPredicate) contains {
    WeakRefAttribute NSSet* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        return [weakSelf containsObject:item];
    };
    
    return [Block_copy(block) autorelease];
}

- (LQForEachBlock) forEach {
    return [self linqEnumerator].forEach;
}

- (LQConcatBlock) concat {
    return [self linqEnumerator].concat;
}

- (LQConcatBlock) unions {
    return [self linqEnumerator].unions;
}

- (LQConcatBlock) except {
    return [self linqEnumerator].except;
}

- (LQConcatBlock) intersect {
    return [self linqEnumerator].intersect;
}

- (LQMinMaxBlock) min {
    return [self linqEnumerator].min;
}

- (LQMinMaxBlock) max {
    return [self linqEnumerator].max;
}

- (LQMinMaxByBlock) minBy {
    return [self linqEnumerator].minBy;
}

- (LQMinMaxByBlock) maxBy {
    return [self linqEnumerator].maxBy;
}

- (LQZipBlock) zip {
    return self.linqEnumerator.zip;
}

@end

CATEGORY_LINK_FIX_IMPL(NSSet_Linq)