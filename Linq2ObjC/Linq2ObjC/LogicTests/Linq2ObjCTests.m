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

- (void)testSelectMany
{
    NSArray* actual = @[@"1", @"2", @"3"].selectMany(^(id item) {
        return @[item, item];
    }).toArray;
    
    NSArray* expected = @[@"1", @"1", @"2", @"2", @"3", @"3"];
    STAssertEqualObjects(expected, actual, nil);
}

@end
