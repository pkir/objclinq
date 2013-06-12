#import <Foundation/Foundation.h>

@protocol LQEnumerable;

typedef id (^LQProjection)(id item);

typedef void (^LQAction)(id item);

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

typedef id<LQEnumerable> (^LQOfClassBlock)(Class classType);

typedef id<LQEnumerable> (^LQConcatBlock)(id<LQEnumerable> collection);

typedef NSUInteger (^LQCountBlock)();
typedef NSUInteger (^LQCountWithPredicateBlock)(LQPredicate predicate);

typedef id<LQEnumerable> (^LQOrderByBlock)(NSComparator comparator);

typedef void (^LQForEachBlock)(LQAction action);

typedef id (^LQMinMaxBlock)(NSComparator comparer);
typedef NSArray* (^LQMinMaxByBlock)(LQProjection keySelector, NSComparator comparer);

typedef NSArray* (^LQArrayBlock)(void);
typedef NSDictionary* (^LQDictionaryBlock)(LQProjection keySelector, LQProjection valueSelector);
typedef NSSet* (^LQSetBlock)(void);

@protocol LQEnumerable <NSFastEnumeration>

@property (readonly, nonatomic) LQSelectBlock select;

@property (readonly, nonatomic) LQWhereBlock where;

@property (readonly, nonatomic) LQSelectManyBlock selectMany;

@property (readonly, nonatomic) LQDistinctBlock distinct;

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

@property (readonly, nonatomic) LQForEachBlock forEach;

@property (readonly, nonatomic) LQConcatBlock concat;

@property (readonly, nonatomic) LQConcatBlock unions;

@property (readonly, nonatomic) LQConcatBlock except;

@property (readonly, nonatomic) LQConcatBlock intersect;

@property (readonly, nonatomic) LQOrderByBlock orderBy;

@property (readonly, nonatomic) LQMinMaxBlock min;
@property (readonly, nonatomic) LQMinMaxBlock max;

@property (readonly, nonatomic) LQMinMaxByBlock minBy;
@property (readonly, nonatomic) LQMinMaxByBlock maxBy;

@property (readonly, nonatomic) LQArrayBlock toArray;
@property (readonly, nonatomic) LQDictionaryBlock toDictionary;
@property (readonly, nonatomic) LQSetBlock toSet;

@end

