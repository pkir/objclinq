#import "Linq2ObjCTests.h"
#import "Linq2ObjC.h"
#import "NSArray+Linq.h"

@implementation Linq2ObjCTests

- (void)testSelect
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test.select(^id(id item) {
        return item;
    }).toArray;
    
    STAssertEqualObjects(test, actual, nil);
    
    actual = test.select(^(id item) {
        return [(NSString*)item stringByAppendingString:@"_TEST"];
    }).toArray;
    
    NSArray* expected = @[ @"1_TEST", @"2_TEST", @"3_TEST"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testWhere
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test.where(^(id item) {
        return YES;
    }).toArray;
    
    STAssertEqualObjects(test, actual, nil);
    
    actual = test.where(^(id item) {
        return [item isEqual:@"2"];
    }).toArray;
    
    NSArray* expected = @[ @"2"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testDistinct
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test
        .disctinct()
        .toArray;
    
    STAssertEqualObjects(test, actual, @"original array was distinct already");
    
    actual = @[@"2", @"2"]
        .disctinct()
        .toArray;   
    
    NSArray* expected = @[ @"2"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testAll
{
    NSArray* test = @[ @"1", @"2", @"3"];
    BOOL result = test.all(^BOOL(id item) { return [item length] == 1;});
    STAssertEquals(YES, result, nil);
    
    result = test.all(^BOOL(id item) { return [item isEqualToString:@"1"];});
    STAssertEquals(NO, result, nil);
}

- (void)testAny
{
    NSArray* test = @[ @"1", @"22", @"3"];
    BOOL result = test.any(^BOOL(id item) { return [item length] > 1;});
    STAssertEquals(YES, result, nil);
    
    result = test.any(^BOOL(id item) { return [item isEqualToString:@"2"];});
    STAssertEquals(NO, result, nil);
}

- (void)testSkip
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.skip(2).toArray;
    STAssertEqualObjects(@[@"3"], result, nil);
    
    result = test.skip(0).toArray;
    STAssertEqualObjects(test, result, nil);
    
    result = test.skip(3).toArray;
    STAssertEqualObjects(@[], result, nil);
}

- (void)testSkipWhile
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.skipWhile(^BOOL(id item) { return [item length] == 1; }).toArray;
    
    NSArray* expected = @[@"22", @"3"];
    STAssertEqualObjects(expected, result, nil);
    
    result = test.skipWhile(^(id item) { return NO; }).toArray;
    STAssertEqualObjects(test, result, nil);
    
    result = test.skipWhile(^(id item) { return YES; }).toArray;
    STAssertEqualObjects(@[], result, nil);
}

- (void)testTake
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.take(2).toArray;
    STAssertEqualObjects((@[@"1", @"22"]), result, nil);
    
    result = test.take(3).toArray;
    STAssertEqualObjects(test, result, nil);
    
    result = test.take(5).toArray;
    STAssertEqualObjects(test, result, nil);
    
    result = test.take(0).toArray;
    STAssertEqualObjects(@[], result, nil);
}

- (void)testTakeWhile
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.takeWhile(^BOOL(id item) { return [item length] == 1; }).toArray;
    
    STAssertEqualObjects(@[@"1"], result, nil);
    
    result = test.takeWhile(^(id item) { return YES; }).toArray;
    STAssertEqualObjects(test, result, nil);
    
    result = test.takeWhile(^(id item) { return NO; }).toArray;
    STAssertEqualObjects(@[], result, nil);
    
    result = test.takeWhile(^BOOL(id item) { return [item length] == 2; }).toArray;
    STAssertEqualObjects(@[], result, nil);
}

- (void)testAggregate
{
    NSArray* test = @[ @1, @2, @3];
    id result = test.aggregate(^(id seed, id item) { return @([seed integerValue] + [item integerValue]); });
    
    STAssertEqualObjects(@6, result, nil);
    
    result = @[@"A", @"B", @"C"].aggregate(^(id seed, id item) { return [item stringByAppendingString:seed == nil ? @"" : seed]; });
    STAssertEqualObjects(@"CBA", result, nil);
}

- (void)testSelectMany
{
    NSArray* actual = @[@"1", @"2", @"3"].selectMany(^(id item) {
        return @[item, [(NSString*)item stringByAppendingString:@"_ADD"]];
    }).toArray;
    
    NSArray* expected = @[@"1", @"1_ADD", @"2", @"2_ADD", @"3", @"3_ADD"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testFirstLast
{
    NSArray* test = @[ @1, @2, @3];
    
    STAssertEqualObjects(@1, test.first(), nil);
    STAssertEqualObjects(@1, test.firstOrNil(), nil);
    STAssertEqualObjects(@2, test.firstWithPredicate(^BOOL(id item) { return [item intValue] > 1; }), nil);
    STAssertEqualObjects(@2, test.firstOrNilWithPredicate(^BOOL(id item) { return [item intValue] > 1; }), nil);
    
    STAssertEqualObjects(@3, test.last(), nil);
    STAssertEqualObjects(@3, test.lastOrNil(), nil);
    STAssertEqualObjects(@2, test.lastWithPredicate(^BOOL(id item) { return [item intValue] < 3; }), nil);
    STAssertEqualObjects(@2, test.lastOrNilWithPredicate(^BOOL(id item) { return [item intValue] < 3; }), nil);
    
    STAssertThrows(@[].first(), nil);
    STAssertThrows(@[].last(), nil);
    STAssertThrows(@[].firstWithPredicate(^(id item){return YES;}), nil);
    STAssertThrows(@[].lastWithPredicate(^(id item){return YES;}), nil);
    
    STAssertThrows(test.firstWithPredicate(^BOOL(id item){return [item intValue] > 3;}), nil);
    STAssertThrows(test.lastWithPredicate(^BOOL(id item){return [item intValue] < 1;}), nil);
}

- (void)testCount
{
    NSArray* test = @[ @1, @2, @3];
    
    STAssertEquals((NSUInteger)3, test.length(), nil);
    STAssertEquals((NSUInteger)1, test.lengthWithPredicate(^BOOL(id item) { return [item intValue] > 2;}), nil);
    
    STAssertEquals((NSUInteger)0, test.lengthWithPredicate(^BOOL(id item) { return [item intValue] > 3;}), nil);
    STAssertEquals((NSUInteger)0, @[].length(), nil);
    STAssertEquals((NSUInteger)0, @[].lengthWithPredicate(^BOOL(id item) { return YES; }), nil);
}

@end
