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
    return [self linqEnumerator].toArray;
}


@dynamic toSet;
- (LQSetBlock) toSet {
    return [self linqEnumerator].toSet;
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
    WeakRefAttribute NSDictionary* weakSelf = self;
    LQPredicate block = ^BOOL(id item){
        return [weakSelf objectForKey:item] != nil;
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

CATEGORY_LINK_FIX_IMPL(NSDictionary_Linq)