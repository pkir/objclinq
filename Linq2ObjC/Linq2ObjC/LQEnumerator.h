#import <Foundation/Foundation.h>
#import "LQEnumerable.h"

extern LQProjection kLQIdentity;

@interface LQEnumerator : NSEnumerator {
    NSEnumerator* _src;
    id (^_nextObject)(NSEnumerator*);
}

+ (LQEnumerator*)enumeratorWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject;
- (id)initWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject;
- (id)nextObject;
@end

@interface NSEnumerator(Linq)<LQEnumerable>

@property (readonly, nonatomic) LQSelectBlock select;

@property (readonly, nonatomic) LQWhereBlock where;

@property (readonly, nonatomic) LQSelectManyBlock selectMany;

@property (readonly, nonatomic) LQDistinctBlock disctinct;

@property (readonly, nonatomic) LQSkipBlock skip;

@property (readonly, nonatomic) LQSkipWithPredicateBlock skipWhile;

@property (readonly, nonatomic) LQSTakeBlock take;

@property (readonly, nonatomic) LQSTakeWithPredicateBlock takeWhile;

@property (readonly, nonatomic) LQAllBlock all;

@property (readonly, nonatomic) LQAnyBlock any;

@property (readonly, nonatomic) LQAggregateWithSeed aggregateWithSeed;

@property (readonly, nonatomic) LQAggregate aggregate;

@property (readonly, nonatomic) ResultBlock single;
@property (readonly, nonatomic) ResultWithPredicateBlock singleWithPredicate;
@property (readonly, nonatomic) ResultBlock singleOrNil;
@property (readonly, nonatomic) ResultWithPredicateBlock singleOrNilWithPredicate;

@property (readonly, nonatomic) ResultBlock first;
@property (readonly, nonatomic) ResultWithPredicateBlock firstWithPredicate;
@property (readonly, nonatomic) ResultBlock firstOrNil;
@property (readonly, nonatomic) ResultWithPredicateBlock firstOrNilWithPredicate;

@property (readonly, nonatomic) ResultBlock last;
@property (readonly, nonatomic) ResultWithPredicateBlock lastWithPredicate;
@property (readonly, nonatomic) ResultBlock lastOrNil;
@property (readonly, nonatomic) ResultWithPredicateBlock lastOrNilWithPredicate;

@property (readonly, nonatomic) LQCountBlock length;
@property (readonly, nonatomic) LQCountWithPredicateBlock lengthWithPredicate;

@property (readonly, nonatomic) LQOfClassBlock ofClass;

@property (readonly, nonatomic) LQPredicate contains;

@property (readonly, nonatomic) LQArrayBlock toArray;
@property (readonly, nonatomic) LQDictionaryBlock toDictionary;

@end