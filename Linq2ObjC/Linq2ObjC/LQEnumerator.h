#import <Foundation/Foundation.h>
#import "LQEnumerable.h"

@interface LQEnumerator : NSEnumerator {
    NSEnumerator* _src;
    id (^_nextObject)(NSEnumerator*);
}

- (id)initWithFunction:(NSEnumerator *)src nextObjectBlock:(id(^)(NSEnumerator *))nextObject;
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

@property (readonly, nonatomic) NSArray* toArray;

@end