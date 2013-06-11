#import <Foundation/Foundation.h>

@protocol LQEnumerable;

typedef id (^LQProjection)(id item);

typedef BOOL (^LQPredicate)(id item);

typedef id (^LQAggregator)(id seed, id item);

typedef id<LQEnumerable> (^LQSelectMany)(id item);

typedef id<LQEnumerable> (^LQSelectBlock)(LQProjection selector);

typedef id<LQEnumerable> (^LQWhereBlock)(LQPredicate filter);

typedef id<LQEnumerable> (^LQSelectManyBlock)(LQSelectMany selector);

typedef id<LQEnumerable> (^LQDistinctBlock)();

typedef id<LQEnumerable> (^LQSkipBlock)(NSUInteger count);

typedef id<LQEnumerable> (^LQSkipWithPredicateBlock)(LQPredicate predicate);

typedef id<LQEnumerable> (^LQSTakeBlock)(NSUInteger count);

typedef id<LQEnumerable> (^LQSTakeWithPredicateBlock)(LQPredicate predicate);

typedef BOOL (^LQAllBlock)(LQPredicate predicate);

typedef BOOL (^LQAnyBlock)(LQPredicate predicate);

typedef id (^LQAggregateWithSeed)(id seed, LQAggregator aggregator);
typedef id (^LQAggregate)(LQAggregator aggregator);

typedef id (^ResultBlock)(void);
typedef id (^ResultWithPredicateBlock)(LQPredicate predicate);

typedef NSUInteger (^LQCountBlock)();
typedef NSUInteger (^LQCountWithPredicateBlock)(LQPredicate predicate);

@protocol LQEnumerable <NSFastEnumeration>

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


@property (readonly, nonatomic) NSArray* toArray;

@end

