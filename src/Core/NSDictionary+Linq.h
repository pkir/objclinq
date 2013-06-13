#import <Foundation/Foundation.h>
#import "Macros.h"
#import "LQEnumerable.h"

/**
 Represents key and value that is stored in NSDictionary
 */
@interface LQKeyValuePair : NSObject

// Key
@property (nonatomic, retain) id key;

// Value
@property (nonatomic, retain) id value;

/**
 Creates new instance and intializes it with key and value
 @param key - key
 @param value - value
 */
- (id) initWithKey:(id)key andValue:(id)value;

/**
 Factory method @see [LQKeyValuePair initWithKey:andValue:]
 @param key - key
 @param value - value
 */
+ (LQKeyValuePair*) makeWithKey:(id)key andValue:(id)value;

@end


/**
 Enumerator that returns LQKeyValuePair from dictionary at each iteration.
 Dictionary that was used to create enumerator should be alive as long as enumerator is alive
 */
@interface LQKeyValueEnumerator : NSEnumerator

/**
 Creates new instances and initializes it with NSDictionary
 @param dict - dictionary to iterate over
 */
- (id)initWithDictionary:(NSDictionary*)dict;

@end

@interface NSDictionary (Linq) <LQEnumerable>

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
@property (readonly, nonatomic) LQOrderByBlock orderByDescending;

@property (readonly, nonatomic) LQMinMaxBlock min;
@property (readonly, nonatomic) LQMinMaxBlock max;

@property (readonly, nonatomic) LQMinMaxByBlock minBy;
@property (readonly, nonatomic) LQMinMaxByBlock maxBy;

@property (readonly, nonatomic) LQZipBlock zip;

@property (readonly, nonatomic) LQArrayBlock toArray;
@property (readonly, nonatomic) LQSetBlock toSet;
@property (readonly, nonatomic) LQDictionaryBlock toDictionary;
@end


CATEGORY_LINK_FIX(NSDictionary_Linq)