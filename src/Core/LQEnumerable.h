#import <Foundation/Foundation.h>

@protocol LQEnumerable;

typedef id (^LQProjection)(id item);

typedef void (^LQAction)(id item);

typedef BOOL (^LQPredicate)(id item);

typedef id (^LQAggregator)(id seed, id item);

typedef id (^LQZipper)(id first, id second);

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

typedef id<LQEnumerable> (^LQOrderByBlock)(LQProjection keySelector, NSComparator comparator);

typedef void (^LQForEachBlock)(LQAction action);

typedef id (^LQMinMaxBlock)(NSComparator comparer);

typedef NSArray* (^LQMinMaxByBlock)(LQProjection keySelector, NSComparator comparer);

typedef id<LQEnumerable> (^LQZipBlock)(id<LQEnumerable> second, LQZipper returnSelector);

typedef NSArray* (^LQArrayBlock)(void);

typedef NSDictionary* (^LQDictionaryBlock)(LQProjection keySelector, LQProjection valueSelector);

typedef NSSet* (^LQSetBlock)(void);

/**
 Common interface for all collections that can be enumerated. It is a heart of the library.
 This analog IEnumerable in .NET and represents LINQ to Objects part of .NET. In basicas LINQ to Objects
 is a different approach to work with collections. In the old way you had to write forin loops in order to retrive data.
 In the LINQ you write declarative code that describes what you want to retrive from the collection. 
 
 In addition, LINQ queries offer three main advantages over traditional foreach loops:
 
    1. They are more concise and readable, especially when filtering multiple conditions.
 
    2. They provide powerful filtering, ordering, and grouping capabilities with a minimum of application code.
 
    3. They can be ported to other data sources (XML, SQL, JSON) with little or no modification.
 */
@protocol LQEnumerable <NSFastEnumeration>

/**
 Projects each element of a sequence into a new form.
 @param selector - A transform function to apply to each element.
 @return - an id<LQEnumerable> whose elements are the result of invoking the transform function on each element of source.
 */
@property (readonly, nonatomic) LQSelectBlock select;

/**
 Filters a sequence of values based on a predicate.
 @param predicate - A function to test each element for a condition.
 @return an id<LQEnumerable> that contains elements from the input sequence that satisfy the condition.
 */
@property (readonly, nonatomic) LQWhereBlock where;

/**
 Projects each element of a sequence to an id<LQEnumerable> and flattens the resulting sequences into one sequence.
 @param selector:  - A transform function to apply to each element.
 @return An id<LQEnumerable> whose elements are the result of invoking the one-to-many transform function on each element of the input sequence.
 */
@property (readonly, nonatomic) LQSelectManyBlock selectMany;

/**
 Returns distinct elements from a sequence by using isEqual method to compare items
 @return An id<LQEnumerable> that contains distinct elements from the source sequence.
 */
@property (readonly, nonatomic) LQDistinctBlock distinct;

/**
 Bypasses a specified number of elements in a sequence and then returns the remaining elements.
 @param count - The number of elements to skip before returning the remaining elements.
 @return An id<LQEnumerable> that contains the elements that occur after the specified index in the input sequence.
 */
@property (readonly, nonatomic) LQSkipBlock skip;

/**
 Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements.
 @param predicate - A function to test each element for a condition.
 @return An id<LQEnumerable> that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.
 */
@property (readonly, nonatomic) LQSkipWithPredicateBlock skipWhile;

/**
 Returns a specified number of contiguous elements from the start of a sequence.
 @param count - The number of elements to return.
 @return An id<LQEnumerable> that contains the specified number of elements from the start of the input sequence.
 */
@property (readonly, nonatomic) LQSTakeBlock take;

/**
 Returns elements from a sequence as long as a specified condition is true.
 @param predicate - A function to test each element for a condition.
 @return An id<LQEnumerable> that contains the elements from the input sequence that occur before the element at which the test no longer passes.
 */
@property (readonly, nonatomic) LQSTakeWithPredicateBlock takeWhile;

/**
 Determines whether all elements of a sequence satisfy a condition.
 @param predicate - A function to test each element for a condition.
 @return YES if every element of the source sequence passes the test in the specified predicate, or if the sequence is empty; otherwise, NO.
 */
@property (readonly, nonatomic) LQAllBlock all;

/**
 Determines whether any element of a sequence satisfies a condition.
 @param predicate - A function to test each element for a condition.
 @return YES if at least one element of the source sequence passes the test in the specified predicate; otherwise, NO.
 */
@property (readonly, nonatomic) LQAnyBlock any;

/**
 Applies an accumulator function over a sequence.
 @param seed - The initial accumulator value.
 @param aggregator - An accumulator function to be invoked on each element.
 @return The final accumulator value.
 */
@property (readonly, nonatomic) LQAggregate aggregate;

/**
 Applies an accumulator function over a sequence. The specified seed value is used as the initial accumulator value.
 @param aggregator - An accumulator function to be invoked on each element.
 @return The final accumulator value.
 */
@property (readonly, nonatomic) LQAggregateWithSeed aggregateWithSeed;

/**
 Returns the only element of a sequence, and throws an exception if there is not exactly one element in the sequence.
 @return The single element of the input sequence.
 @exception InvalidOperationException The input sequence contains more than one element or the input sequence is empty.
 */
@property (readonly, nonatomic) ResultBlock single;

/**
 Returns the only element of a sequence that satisfies a specified condition, and throws an exception if more than one such element exists.
 @param predicate - A function to test an element for a condition.
 @return The single element of the input sequence that satisfies a condition.
 @exception InvalidOperationException No element satisfies the condition in predicate or more than one element satisfies the condition in predicate. or the source sequence is empty.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock singleWithPredicate;

/**
 Returns the only element of a sequence, or a default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.
 @return The single element of the input sequence, or nil if the sequence contains no elements.
 @exeption InvalidOperationException The input sequence contains more than one element.
 */
@property (readonly, nonatomic) ResultBlock singleOrNil;

/**
 Returns the only element of a sequence that satisfies a specified condition or a default value if no such element exists; this method throws an exception if more than one element satisfies the condition.
 @param predicate - A function to test an element for a condition.
 @return The single element of the input sequence that satisfies the condition, or nil if no such element is found.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock singleOrNilWithPredicate;

/**
 Returns the first element of a sequence.
 @return The first element in the specified sequence.
 @exception InvalidOperationException The source sequence is empty.
 */
@property (readonly, nonatomic) ResultBlock first;

/**
 Returns the first element in a sequence that satisfies a specified condition.
 @param predicate - A function to test each element for a condition.
 The first element in the sequence that passes the test in the specified predicate function.
 @exception InvalidOperationException No element satisfies the condition in predicate or The source sequence is empty.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock firstWithPredicate;

/**
 Returns the first element of a sequence, or a default value if the sequence contains no elements.
 @return nil if source is empty; otherwise, the first element in source.
 */
@property (readonly, nonatomic) ResultBlock firstOrNil;

/**
 Returns the first element of the sequence that satisfies a condition or a default value if no such element is found.
 @param predicate - A function to test each element for a condition
 @return nil if source is empty or if no element passes the test specified by predicate; otherwise, the first element in source that passes the test specified by predicate.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock firstOrNilWithPredicate;

/**
 Returns the last element of a sequence.
 @return The value at the last position in the source sequence.
 @exception InvalidOperationException The source sequence is empty.
 */
@property (readonly, nonatomic) ResultBlock last;

/**
 Returns the last element of a sequence that satisfies a specified condition.
 @params predicate - A function to test each element for a condition.
 @return The last element in the sequence that passes the test in the specified predicate function.
 @exception InvalidOperationException No element satisfies the condition in predicate or The source sequence is empty.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock lastWithPredicate;

/**
 Returns the last element of a sequence, or a default value if the sequence contains no elements.
 @return nil if the source sequence is empty; otherwise, the last element in the id<LQEnumerable>.
 */
@property (readonly, nonatomic) ResultBlock lastOrNil;

/**
 Returns the last element of a sequence that satisfies a condition or a default value if no such element is found.
 @param predicate - A function to test each element for a condition.
 @return nil if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the last element that passes the test in the predicate function.
 */
@property (readonly, nonatomic) ResultWithPredicateBlock lastOrNilWithPredicate;

/**
 Returns the number of elements in a sequence.
 @return The number of elements in the input sequence.
 */
@property (readonly, nonatomic) LQCountBlock length;

/**
 Returns a number that represents how many elements in the specified sequence satisfy a condition.
 @param predicate - A function to test each element for a condition.
 @return A number that represents how many elements in the sequence satisfy the condition in the predicate function.
 */
@property (readonly, nonatomic) LQCountWithPredicateBlock lengthWithPredicate;

/**
 Filters the elements of an id<LQEnumerable> based on a specified class.
 @return An id<LQEnumerable> that contains elements from the input sequence of given class.
 */
@property (readonly, nonatomic) LQOfClassBlock ofClass;

/**
 Determines whether a sequence contains a specified element by using isEqual method to compare values.
 @param value - The value to locate in the sequence.
 @return YES if the source sequence contains an element that has the specified value; otherwise, NO.
 */
@property (readonly, nonatomic) LQPredicate contains;

/**
 Enumerates the sequence and invokes the given action for each value in the sequence.
 @param actino - Action to invoke for each element.
 */
@property (readonly, nonatomic) LQForEachBlock forEach;

/**
 Concatenates two sequences.
 @param second - The sequence to concatenate to the first sequence.
 @return An id<LQEnumerable> that contains the concatenated elements of the two input sequences.
 */
@property (readonly, nonatomic) LQConcatBlock concat;

/**
 Produces the set union of two sequences by using isEqual method as comparer
 @param second An id<LQEnumerable> whose distinct elements form the second set for the union.
 @return An id<LQEnumerable> that contains the elements from both input sequences, excluding duplicates.
 */
@property (readonly, nonatomic) LQConcatBlock unions;

/**
 Produces the set difference of two sequences by using isEqual method to compare values.
 @param An id<LQEnumerable> whose elements that also occur in the first sequence will cause those elements to be removed from the returned sequence.
 @return A sequence that contains the set difference of the elements of two sequences.
 */
@property (readonly, nonatomic) LQConcatBlock except;

/**
 Produces the set intersection of two sequences by using isEqual method to compare values.
 @param second - An id<LQEnumerable> whose distinct elements that also appear in the first sequence will be returned.
 @return A sequence that contains the elements that form the set intersection of two sequences.
 */
@property (readonly, nonatomic) LQConcatBlock intersect;

/**
 Sorts the elements of a sequence in ascending order by using a specified comparer.
 @param keySelector - A function to extract a key from an element.
 @param comparer - A function to compare two values
 @return An id<LQEnumerable> whose elements are sorted according to a key.
 */
@property (readonly, nonatomic) LQOrderByBlock orderBy;

/**
 Sorts the elements of a sequence in descending order by using a specified comparer.
 @param keySelector - A function to extract a key from an element.
 @param comparer - A function to compare two values
 @return An id<LQEnumerable> whose elements are sorted in descending order according to a key.
 */
@property (readonly, nonatomic) LQOrderByBlock orderByDescending;

/**
 Returns the minimum value in the enumerable sequence by using the specified comparer to compare values.
 @param comparer - Comparer used to determine the minimum value
 @return Minimum value in the sequence.
 */
@property (readonly, nonatomic) LQMinMaxBlock min;

/**
 Returns the maxmimum value in the enumerable sequence by using the specified comparer to compare values.
 @param comparer - Comparer used to determine the maxmimum value
 @return MAximum value in the sequence.
 */
@property (readonly, nonatomic) LQMinMaxBlock max;

/**
 Returns the elements with the minimum key value by using the default comparer to compare key values.
 @param keySelector - Key selector used to extract the key for each element in the sequence.
 @param comparer - Comparer used to determine the minimum key value.
 @return List with the elements that share the same minimum key value.
 */
@property (readonly, nonatomic) LQMinMaxByBlock minBy;

/**
 Returns the elements with the maxmimum key value by using the default comparer to compare key values.
 @param keySelector - Key selector used to extract the key for each element in the sequence.
 @param comparer - Comparer used to determine the maxmimum key value.
 @return List with the elements that share the same maxmimum key value.
 */
@property (readonly, nonatomic) LQMinMaxByBlock maxBy;

/**
 Applies a specified function to the corresponding elements of two sequences, which produces a sequence of the results.
 @param second - The second sequence to merge.
 @param resultSelector A function that specifies how to merge the elements from the two sequences.
 @return An id<LQEnumerable> that contains merged elements of two input sequences.
 */
@property (readonly, nonatomic) LQZipBlock zip;

/**
 Creates a NSArray from a id<LQEnumerable>.
 @return An array that contains the elements from the input sequence.
 */
@property (readonly, nonatomic) LQArrayBlock toArray;

/**
 Creates a NSDictionary from an id<LQEnumerable> according to specified key selector and element selector functions.
 @param keySelector - A function to extract a key from each element.
 @param valueSelector - A transform function to produce a result element value from each element.
 @return A NSDictionary that contains values selected from the input sequence.
 */
@property (readonly, nonatomic) LQDictionaryBlock toDictionary;

/**
 Creates a NSSet from a id<LQEnumerable>.
 @return A set that contains the elements from the input sequence.
 */
@property (readonly, nonatomic) LQSetBlock toSet;

@end

