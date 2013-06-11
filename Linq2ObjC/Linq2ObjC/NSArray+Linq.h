#import <Foundation/Foundation.h>
#import "Macros.h"
#import "LQEnumerable.h"

@interface NSArray (Linq) <LQEnumerable>

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

@property (readonly, nonatomic) NSArray* toArray;
@end


CATEGORY_LINK_FIX(NSArray_Linq)