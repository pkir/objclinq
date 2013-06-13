# Linq To Objective-C

Bringing a Linq-style fluent query API to Objective-C.

This project contains a collection of methods that allow you to execute query using a fluent syntax, inspired by Linq.

### aggregate

Applies an accumulator function over a sequence.

`@property (readonly, nonatomic) LQAggregate aggregate`

#### Parameters

_seed_
    

  * The initial accumulator value.

_aggregator_
    

  * An accumulator function to be invoked on each element.

#### Return Value

The final accumulator value.

#### Declared In

`LQEnumerable.h`  


### aggregateWithSeed

Applies an accumulator function over a sequence. The specified seed value is used as the initial accumulator value.

`@property (readonly, nonatomic) LQAggregateWithSeed aggregateWithSeed`

#### Parameters

_aggregator_
    

  * An accumulator function to be invoked on each element.

#### Return Value

The final accumulator value.

#### Declared In

`LQEnumerable.h`  


### all

Determines whether all elements of a sequence satisfy a condition.

`@property (readonly, nonatomic) LQAllBlock all`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

YES if every element of the source sequence passes the test in the specified predicate, or if the sequence is empty; otherwise, NO.

#### Declared In

`LQEnumerable.h`  


### any

Determines whether any element of a sequence satisfies a condition.

`@property (readonly, nonatomic) LQAnyBlock any`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

YES if at least one element of the source sequence passes the test in the specified predicate; otherwise, NO.

#### Declared In

`LQEnumerable.h`  


### concat

Concatenates two sequences.

`@property (readonly, nonatomic) LQConcatBlock concat`

#### Parameters

_second_
    

  * The sequence to concatenate to the [first][14] sequence.

   [14]: ../Protocols/LQEnumerable.html#//api/name/first

#### Return Value

An id that [contains][15] the concatenated elements of the two input sequences.

   [15]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### contains

Determines whether a sequence contains a specified element by using isEqual method to compare values.

`@property (readonly, nonatomic) LQPredicate contains`

#### Parameters

_value_
    

  * The value to locate in the sequence.

#### Return Value

YES if the source sequence contains an element that has the specified value; otherwise, NO.

#### Declared In

`LQEnumerable.h`  


### distinct

Returns distinct elements from a sequence by using isEqual method to compare items

`@property (readonly, nonatomic) LQDistinctBlock distinct`

#### Return Value

An id that [contains][16] distinct elements from the source sequence.

   [16]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### except

Produces the set difference of two sequences by using isEqual method to compare values.

`@property (readonly, nonatomic) LQConcatBlock except`

#### Parameters

_An_
    

id whose elements that also occur in the [first][17] sequence will cause those elements to be removed from the returned sequence.

   [17]: ../Protocols/LQEnumerable.html#//api/name/first

#### Return Value

A sequence that [contains][18] the set difference of the elements of two sequences.

   [18]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### first

Returns the first element of a sequence.

`@property (readonly, nonatomic) ResultBlock first`

#### Return Value

The first element in the specified sequence.

#### Exceptions

_InvalidOperationException_
    

The source sequence is empty.

#### Declared In

`LQEnumerable.h`  


### firstOrNil

Returns the [first][19] element of a sequence, or a default value if the sequence [contains][20] no elements.

   [19]: ../Protocols/LQEnumerable.html#//api/name/first
   [20]: ../Protocols/LQEnumerable.html#//api/name/contains

`@property (readonly, nonatomic) ResultBlock firstOrNil`

#### Return Value

nil if source is empty; otherwise, the [first][21] element in source.

   [21]: ../Protocols/LQEnumerable.html#//api/name/first

#### Declared In

`LQEnumerable.h`  


### firstOrNilWithPredicate

Returns the [first][22] element of the sequence that satisfies a condition or a default value if no such element is found.

   [22]: ../Protocols/LQEnumerable.html#//api/name/first

`@property (readonly, nonatomic) ResultWithPredicateBlock firstOrNilWithPredicate`

#### Parameters

_predicate_
    

  * A function to test each element for a condition

#### Return Value

nil if source is empty or if no element passes the test specified by predicate; otherwise, the [first][23] element in source that passes the test specified by predicate.

   [23]: ../Protocols/LQEnumerable.html#//api/name/first

#### Declared In

`LQEnumerable.h`  


### firstWithPredicate

Returns the [first][24] element in a sequence that satisfies a specified condition.

   [24]: ../Protocols/LQEnumerable.html#//api/name/first

`@property (readonly, nonatomic) ResultWithPredicateBlock firstWithPredicate`

#### Parameters

_predicate_
    

  * A function to test each element for a condition. The [first][25] element in the sequence that passes the test in the specified predicate function.

   [25]: ../Protocols/LQEnumerable.html#//api/name/first

#### Exceptions

_InvalidOperationException_
    

No element satisfies the condition in predicate or The source sequence is empty.

#### Declared In

`LQEnumerable.h`  


### forEach

Enumerates the sequence and invokes the given action for each value in the sequence.

`@property (readonly, nonatomic) LQForEachBlock forEach`

#### Parameters

_actino_
    

  * Action to invoke for each element.

#### Declared In

`LQEnumerable.h`  


### intersect

Produces the set intersection of two sequences by using isEqual method to compare values.

`@property (readonly, nonatomic) LQConcatBlock intersect`

#### Parameters

_second_
    

  * An id whose [distinct][26] elements that also appear in the [first][27] sequence will be returned.

   [26]: ../Protocols/LQEnumerable.html#//api/name/distinct
   [27]: ../Protocols/LQEnumerable.html#//api/name/first

#### Return Value

A sequence that [contains][28] the elements that form the set intersection of two sequences.

   [28]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### last

Returns the last element of a sequence.

`@property (readonly, nonatomic) ResultBlock last`

#### Return Value

The value at the last position in the source sequence.

#### Exceptions

_InvalidOperationException_
    

The source sequence is empty.

#### Declared In

`LQEnumerable.h`  


### lastOrNil

Returns the [last][29] element of a sequence, or a default value if the sequence [contains][30] no elements.

   [29]: ../Protocols/LQEnumerable.html#//api/name/last
   [30]: ../Protocols/LQEnumerable.html#//api/name/contains

`@property (readonly, nonatomic) ResultBlock lastOrNil`

#### Return Value

nil if the source sequence is empty; otherwise, the [last][31] element in the id.

   [31]: ../Protocols/LQEnumerable.html#//api/name/last

#### Declared In

`LQEnumerable.h`  


### lastOrNilWithPredicate

Returns the [last][32] element of a sequence that satisfies a condition or a default value if no such element is found.

   [32]: ../Protocols/LQEnumerable.html#//api/name/last

`@property (readonly, nonatomic) ResultWithPredicateBlock lastOrNilWithPredicate`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

nil if the sequence is empty or if no elements pass the test in the predicate function; otherwise, the [last][33] element that passes the test in the predicate function.

   [33]: ../Protocols/LQEnumerable.html#//api/name/last

#### Declared In

`LQEnumerable.h`  


### lastWithPredicate

Returns the [last][34] element of a sequence that satisfies a specified condition. @params predicate - A function to test each element for a condition.

   [34]: ../Protocols/LQEnumerable.html#//api/name/last

`@property (readonly, nonatomic) ResultWithPredicateBlock lastWithPredicate`

#### Return Value

The [last][35] element in the sequence that passes the test in the specified predicate function.

   [35]: ../Protocols/LQEnumerable.html#//api/name/last

#### Exceptions

_InvalidOperationException_
    

No element satisfies the condition in predicate or The source sequence is empty.

#### Declared In

`LQEnumerable.h`  


### length

Returns the number of elements in a sequence.

`@property (readonly, nonatomic) LQCountBlock length`

#### Return Value

The number of elements in the input sequence.

#### Declared In

`LQEnumerable.h`  


### lengthWithPredicate

Returns a number that represents how m[any][36] elements in the specified sequence satisfy a condition.

   [36]: ../Protocols/LQEnumerable.html#//api/name/any

`@property (readonly, nonatomic) LQCountWithPredicateBlock lengthWithPredicate`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

A number that represents how m[any][37] elements in the sequence satisfy the condition in the predicate function.

   [37]: ../Protocols/LQEnumerable.html#//api/name/any

#### Declared In

`LQEnumerable.h`  


### max

Returns the maxmimum value in the enumerable sequence by using the specified comparer to compare values.

`@property (readonly, nonatomic) LQMinMaxBlock max`

#### Parameters

_comparer_
    

  * Comparer used to determine the maxmimum value

#### Return Value

MAximum value in the sequence.

#### Declared In

`LQEnumerable.h`  


### maxBy

Returns the elements with the maxmimum key value by using the default comparer to compare key values.

`@property (readonly, nonatomic) LQMinMaxByBlock maxBy`

#### Parameters

_keySelector_
    

  * Key selector used to extract the key for each element in the sequence.

_comparer_
    

  * Comparer used to determine the maxmimum key value.

#### Return Value

List with the elements that share the same maxmimum key value.

#### Declared In

`LQEnumerable.h`  


### min

Returns the minimum value in the enumerable sequence by using the specified comparer to compare values.

`@property (readonly, nonatomic) LQMinMaxBlock min`

#### Parameters

_comparer_
    

  * Comparer used to determine the minimum value

#### Return Value

Minimum value in the sequence.

#### Declared In

`LQEnumerable.h`  


### minBy

Returns the elements with the minimum key value by using the default comparer to compare key values.

`@property (readonly, nonatomic) LQMinMaxByBlock minBy`

#### Parameters

_keySelector_
    

  * Key selector used to extract the key for each element in the sequence.

_comparer_
    

  * Comparer used to determine the minimum key value.

#### Return Value

List with the elements that share the same minimum key value.

#### Declared In

`LQEnumerable.h`  


### ofClass

Filters the elements of an id based on a specified class.

`@property (readonly, nonatomic) LQOfClassBlock ofClass`

#### Return Value

An id that [contains][38] elements from the input sequence of given class.

   [38]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### orderBy

Sorts the elements of a sequence in ascending order by using a specified comparer.

`@property (readonly, nonatomic) LQOrderByBlock orderBy`

#### Parameters

_keySelector_
    

  * A function to extract a key from an element.

_comparer_
    

  * A function to compare two values

#### Return Value

An id whose elements are sorted according to a key.

#### Declared In

`LQEnumerable.h`  


### orderByDescending

Sorts the elements of a sequence in descending order by using a specified comparer.

`@property (readonly, nonatomic) LQOrderByBlock orderByDescending`

#### Parameters

_keySelector_
    

  * A function to extract a key from an element.

_comparer_
    

  * A function to compare two values

#### Return Value

An id whose elements are sorted in descending order according to a key.

#### Declared In

`LQEnumerable.h`  


### select

Projects each element of a sequence into a new form.

`@property (readonly, nonatomic) LQSelectBlock select`

#### Parameters

_selector_
    

  * A transform function to apply to each element.

#### Return Value

  * an id whose elements are the result of invoking the transform function on each element of source.

#### Declared In

`LQEnumerable.h`  


### selectMany

Projects each element of a sequence to an id and flattens the resulting sequences into one sequence.

`@property (readonly, nonatomic) LQSelectManyBlock selectMany`

#### Parameters

_selector:_
    

  * A transform function to apply to each element.

#### Return Value

An id whose elements are the result of invoking the one-to-m[any][39] transform function on each element of the input sequence.

   [39]: ../Protocols/LQEnumerable.html#//api/name/any

#### Declared In

`LQEnumerable.h`  


### single

Returns the only element of a sequence, and throws an exception if there is not exactly one element in the sequence.

`@property (readonly, nonatomic) ResultBlock single`

#### Return Value

The single element of the input sequence.

#### Exceptions

_InvalidOperationException_
    

The input sequence [contains][40] more than one element or the input sequence is empty.

   [40]: ../Protocols/LQEnumerable.html#//api/name/contains

#### Declared In

`LQEnumerable.h`  


### singleOrNil

Returns the only element of a sequence, or a default value if the sequence is empty; this method throws an exception if there is more than one element in the sequence.

`@property (readonly, nonatomic) ResultBlock singleOrNil`

#### Return Value

The single element of the input sequence, or nil if the sequence contains no elements. @exeption InvalidOperationException The input sequence contains more than one element.

#### Declared In

`LQEnumerable.h`  


### singleOrNilWithPredicate

Returns the only element of a sequence that satisfies a specified condition or a default value if no such element exists; this method throws an exception if more than one element satisfies the condition.

`@property (readonly, nonatomic) ResultWithPredicateBlock singleOrNilWithPredicate`

#### Parameters

_predicate_
    

  * A function to test an element for a condition.

#### Return Value

The single element of the input sequence that satisfies the condition, or nil if no such element is found.

#### Declared In

`LQEnumerable.h`  


### singleWithPredicate

Returns the only element of a sequence that satisfies a specified condition, and throws an exception if more than one such element exists.

`@property (readonly, nonatomic) ResultWithPredicateBlock singleWithPredicate`

#### Parameters

_predicate_
    

  * A function to test an element for a condition.

#### Return Value

The single element of the input sequence that satisfies a condition.

#### Exceptions

_InvalidOperationException_
    

No element satisfies the condition in predicate or more than one element satisfies the condition in predicate. or the source sequence is empty.

#### Declared In

`LQEnumerable.h`  


### skip

Bypasses a specified number of elements in a sequence and then returns the remaining elements.

`@property (readonly, nonatomic) LQSkipBlock skip`

#### Parameters

_count_
    

  * The number of elements to skip before returning the remaining elements.

#### Return Value

An id that contains the elements that occur after the specified index in the input sequence.

#### Declared In

`LQEnumerable.h`  


### skipWhile

Bypasses elements in a sequence as long as a specified condition is true and then returns the remaining elements.

`@property (readonly, nonatomic) LQSkipWithPredicateBlock skipWhile`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

An id that contains the elements from the input sequence starting at the first element in the linear series that does not pass the test specified by predicate.

#### Declared In

`LQEnumerable.h`  


### take

Returns a specified number of contiguous elements from the start of a sequence.

`@property (readonly, nonatomic) LQSTakeBlock take`

#### Parameters

_count_
    

  * The number of elements to return.

#### Return Value

An id that contains the specified number of elements from the start of the input sequence.

#### Declared In

`LQEnumerable.h`  


### takeWhile

Returns elements from a sequence as long as a specified condition is true.

`@property (readonly, nonatomic) LQSTakeWithPredicateBlock takeWhile`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

An id that contains the elements from the input sequence that occur before the element at which the test no longer passes.

#### Declared In

`LQEnumerable.h`  


### toArray

Creates a NSArray from a id.

`@property (readonly, nonatomic) LQArrayBlock toArray`

#### Return Value

An array that contains the elements from the input sequence.

#### Declared In

`LQEnumerable.h`  


### toDictionary

Creates a NSDictionary from an id according to specified key selector and element selector functions.

`@property (readonly, nonatomic) LQDictionaryBlock toDictionary`

#### Parameters

_keySelector_
    

  * A function to extract a key from each element.

_valueSelector_
    

  * A transform function to produce a result element value from each element.

#### Return Value

A NSDictionary that contains values selected from the input sequence.

#### Declared In

`LQEnumerable.h`  


### toSet

Creates a NSSet from a id.

`@property (readonly, nonatomic) LQSetBlock toSet`

#### Return Value

A set that contains the elements from the input sequence.

#### Declared In

`LQEnumerable.h`  


### unions

Produces the set union of two sequences by using isEqual method as comparer

`@property (readonly, nonatomic) LQConcatBlock unions`

#### Parameters

_second_
    

An id whose distinct elements form the second set for the union.

#### Return Value

An id that contains the elements from both input sequences, excluding duplicates.

#### Declared In

`LQEnumerable.h`  


### where

Filters a sequence of values based on a predicate.

`@property (readonly, nonatomic) LQWhereBlock where`

#### Parameters

_predicate_
    

  * A function to test each element for a condition.

#### Return Value

an id that contains elements from the input sequence that satisfy the condition.

#### Declared In

`LQEnumerable.h`  


### zip

Applies a specified function to the corresponding elements of two sequences, which produces a sequence of the results.

`@property (readonly, nonatomic) LQZipBlock zip`

#### Parameters

_second_
    

  * The second sequence to merge.

_resultSelector_
    

A function that specifies how to merge the elements from the two sequences.

#### Return Value

An id that contains merged elements of two input sequences.

#Licence
The code within project is made available under the standard MIT licence, see the included licence file.