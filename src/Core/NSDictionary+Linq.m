#import "NSDictionary+Linq.h"
#import "LQEnumerator.h"

@implementation LQKeyValuePair

- (id) initWithKey:(id)key andValue:(id)value {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    
    return self;
}

+ (LQKeyValuePair*) makeWithKey:(id)key andValue:(id)value {
    return [[[self alloc] initWithKey:key andValue:value] autorelease];
}

- (void) dealloc {
    self.key = nil;
    self.value = nil;
    [super dealloc];
}

@end

@interface LQKeyValueEnumerator() {
    NSEnumerator* keyEnumerator_;
    NSDictionary* dict_;
}

@end

@implementation LQKeyValueEnumerator

- (id)initWithDictionary:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        keyEnumerator_ = [[dict keyEnumerator] retain];
        dict_ = dict;
    }
    
    return self;
}

- (id) nextObject {
    id key = keyEnumerator_.nextObject;
    if (key) {
        return [LQKeyValuePair makeWithKey:key andValue:dict_[key]];
    }
    
    return nil;
}

- (void) dealloc {
    [keyEnumerator_ release];
    dict_ = nil;
    [super dealloc];
}

@end

@implementation NSDictionary (Linq)

- (NSEnumerator*) linqEnumerator {
    return [[[LQKeyValueEnumerator alloc] initWithDictionary:self] autorelease];
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
    return [self linqEnumerator].toArray;
}

- (LQSetBlock) toSet {
    return [self linqEnumerator].toSet;
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
    WeakRefAttribute NSDictionary* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        return [weakSelf objectForKey:item] != nil;
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

CATEGORY_LINK_FIX_IMPL(NSDictionary_Linq)