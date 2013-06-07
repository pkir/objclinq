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
    
    result = @[@"A", @"B", @"C"].aggregate(^(id seed, id item) { return [seed stringByAppendingString:item]; });
    STAssertEqualObjects(@"C B A", result, nil);
}

- (void)testSelectMany
{
    NSArray* actual = @[@"1", @"2", @"3"].selectMany(^(id item) {
        return @[item, item];
    }).toArray;
    
    NSArray* expected = @[@"1", @"1", @"2", @"2", @"3", @"3"];
    STAssertEqualObjects(expected, actual, nil);
}

@end
