#import "Linq2ObjCTests.h"
#import "objclinq.h"

@interface Person : NSObject
@property (retain, nonatomic) NSString* name;
+(id)makeWithName:(NSString*)name;
@end

@interface Pet : NSObject
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) Person* owner;
+(id)makeWithName:(NSString*)name andOwner:(Person*)owner;
@end

@implementation Person
+(id)makeWithName:(NSString*)name {
    Person* ret = [[Person alloc] init];
    ret.name = name;
    
    return ret;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"<%@>: %@", self.class.description, self.name];
}

- (void) dealloc {
    self.name = nil;
    [super dealloc];
}

@end

@implementation Pet
+(id)makeWithName:(NSString*)name andOwner:(Person*)owner {
    Pet* ret = [[Pet alloc] init];
    ret.name = name;
    ret.owner = owner;
    
    return ret;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"<%@>: name = %@, owner = %@", self.class.description, self.name, self.owner];
}

- (void) dealloc {
    self.name = nil;
    self.owner = nil;
    [super dealloc];
}
@end

@implementation Linq2ObjCTests

- (void)testToArray
{
    NSArray* test = @[ @"1", @"2", @"3"];
    
    STAssertEqualObjects(test, test.toArray(), nil);
    STAssertEqualObjects(@[], @[].toArray(), nil);
}

- (void)testToDictionary
{
    NSArray* test = @[ @"1", @"2", @"3"];
    
    STAssertEqualObjects((@{@1: @"1", @2: @"2", @3: @"3"}), test.toDictionary(^(id item){return @([item intValue]);}, kLQIdentity), nil);
    STAssertEqualObjects(@{}, @[].toDictionary(kLQIdentity, kLQIdentity), nil);
}

- (void)testToSet
{
    NSArray* test = @[ @"1", @"2", @"3"];
    
    STAssertEqualObjects([NSSet setWithArray:test], test.toSet(), nil);
    STAssertEquals((NSUInteger)3, (@[@1, @2, @3, @1, @3]).toSet().count, nil);
    STAssertEqualObjects([NSSet setWithArray:(@[@1, @2, @3])], (@[@1, @2, @3, @1, @3]).toSet(), nil);
    STAssertEqualObjects([NSSet set], (@[]).toSet(), nil);
}

- (void)testSelect
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test.select(^id(id item) {
        return item;
    }).toArray();
    
    STAssertEqualObjects(test, actual, nil);
    
    actual = test.select(^(id item) {
        return [(NSString*)item stringByAppendingString:@"_TEST"];
    }).toArray();
    
    NSArray* expected = @[ @"1_TEST", @"2_TEST", @"3_TEST"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testWhere
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test.where(^(id item) {
        return YES;
    }).toArray();
    
    STAssertEqualObjects(test, actual, nil);
    
    actual = test.where(^(id item) {
        return [item isEqual:@"2"];
    }).toArray();
    
    NSArray* expected = @[ @"2"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testDistinct
{
    NSArray* test = @[ @"1", @"2", @"3"];
    NSArray* actual = test
        .distinct()
        .toArray();
    
    STAssertEqualObjects(test, actual, @"original array was distinct already");
    
    actual = @[@"2", @"2"]
        .distinct()
        .toArray();
    
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
    
    STAssertEquals(YES, @[].all(kLQNoPredicate), nil);
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
    NSArray* result = test.skip(2).toArray();
    STAssertEqualObjects(@[@"3"], result, nil);
    
    result = test.skip(0).toArray();
    STAssertEqualObjects(test, result, nil);
    
    result = test.skip(3).toArray();
    STAssertEqualObjects(@[], result, nil);
}

- (void)testSkipWhile
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.skipWhile(^BOOL(id item) { return [item length] == 1; }).toArray();
    
    NSArray* expected = @[@"22", @"3"];
    STAssertEqualObjects(expected, result, nil);
    
    result = test.skipWhile(^(id item) { return NO; }).toArray();
    STAssertEqualObjects(test, result, nil);
    
    result = test.skipWhile(^(id item) { return YES; }).toArray();
    STAssertEqualObjects(@[], result, nil);
}

- (void)testTake
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.take(2).toArray();
    STAssertEqualObjects((@[@"1", @"22"]), result, nil);
    
    result = test.take(3).toArray();
    STAssertEqualObjects(test, result, nil);
    
    result = test.take(5).toArray();
    STAssertEqualObjects(test, result, nil);
    
    result = test.take(0).toArray();
    STAssertEqualObjects(@[], result, nil);
}

- (void)testTakeWhile
{
    NSArray* test = @[ @"1", @"22", @"3"];
    NSArray* result = test.takeWhile(^BOOL(id item) { return [item length] == 1; }).toArray();
    
    STAssertEqualObjects(@[@"1"], result, nil);
    
    result = test.takeWhile(^(id item) { return YES; }).toArray();
    STAssertEqualObjects(test, result, nil);
    
    result = test.takeWhile(^(id item) { return NO; }).toArray();
    STAssertEqualObjects(@[], result, nil);
    
    result = test.takeWhile(^BOOL(id item) { return [item length] == 2; }).toArray();
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
    }).toArray();
    
    NSArray* expected = @[@"1", @"1_ADD", @"2", @"2_ADD", @"3", @"3_ADD"];
    STAssertEqualObjects(expected, actual, nil);
}

- (void)testFirst
{
    NSArray* test = @[ @1, @2, @3];
    
    STAssertEqualObjects(@1, test.first(), nil);
    STAssertEqualObjects(@1, test.firstOrNil(), nil);
    STAssertEqualObjects((id)nil, @[].firstOrNil(), nil);
    STAssertEqualObjects(@2, test.firstWithPredicate(^BOOL(id item) { return [item intValue] > 1; }), nil);
    STAssertEqualObjects(@2, test.firstOrNilWithPredicate(^BOOL(id item) { return [item intValue] > 1; }), nil);
    
    STAssertThrows(@[].first(), nil);
    STAssertThrows(@[].firstWithPredicate(^(id item){return YES;}), nil);
    STAssertThrows(test.firstWithPredicate(^BOOL(id item){return [item intValue] > 3;}), nil);
}

- (void)testLast
{
    NSArray* test = @[ @1, @2, @3];
    
    STAssertEqualObjects(@3, test.last(), nil);
    STAssertEqualObjects(@3, test.lastOrNil(), nil);
    STAssertEqualObjects((id)nil, @[].lastOrNil(), nil);
    STAssertEqualObjects(@2, test.lastWithPredicate(^BOOL(id item) { return [item intValue] < 3; }), nil);
    STAssertEqualObjects(@2, test.lastOrNilWithPredicate(^BOOL(id item) { return [item intValue] < 3; }), nil);
    
    STAssertThrows(@[].last(), nil);
    STAssertThrows(@[].lastWithPredicate(^(id item){return YES;}), nil);
    STAssertThrows(test.lastWithPredicate(^BOOL(id item){return [item intValue] < 1;}), nil);
}

- (void)testSingle
{
    NSArray* test = @[ @1, @2, @3];
    
    STAssertEqualObjects(@3, @[@3].single(), nil);
    STAssertEqualObjects(@3, @[@3].singleOrNil(), nil);
    STAssertEqualObjects((id)nil, @[].singleOrNil(), nil);
    STAssertEqualObjects(@2, test.singleWithPredicate(^BOOL(id item) { return [item intValue] == 2; }), nil);
    STAssertEqualObjects(@2, test.singleOrNilWithPredicate(^BOOL(id item) { return [item intValue] == 2; }), nil);
    STAssertEqualObjects((id)nil, test.singleOrNilWithPredicate(^BOOL(id item) { return [item intValue] > 3; }), nil);
    
    STAssertThrows(@[].single(), nil);
    STAssertThrows((@[ @1, @2 ]).single(), nil);
    STAssertThrows(@[].singleWithPredicate(^(id item){return YES;}), nil);
    STAssertThrows((@[ @1, @2 ]).singleWithPredicate(^(id item){return YES;}), nil);
    STAssertThrows(test.singleWithPredicate(^BOOL(id item){return [item intValue] < 1;}), nil);
    STAssertThrows(test.singleOrNilWithPredicate(^BOOL(id item){return [item intValue] < 3;}), nil);
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

- (void)testOfClass
{
    NSArray* test = @[ @1, @2, @"2", @[@1]];
    
    STAssertEqualObjects((@[ @1, @2]), test.ofClass([NSNumber class]).toArray(), nil);
    STAssertEqualObjects((@[@[@1]]), test.ofClass([NSArray class]).toArray(), nil);
    STAssertEqualObjects((@[]), test.ofClass([NSSet class]).toArray(), nil);
}

- (void)testContains
{
    NSArray* test = @[ @"1", @"2", @"3"];
    
    STAssertTrue(test.contains(@"1"), nil);
    STAssertFalse(test.contains(nil), nil);
    STAssertFalse(test.contains(@"11"), nil);
    
    
    STAssertTrue(test.objectEnumerator.contains(@"1"), nil);
    STAssertFalse(@[].objectEnumerator.contains(@1), nil);
    STAssertFalse(test.objectEnumerator.contains(nil), nil);
    STAssertFalse(test.objectEnumerator.contains(@"11"), nil);
}

- (void)testConcat
{
    STAssertEqualObjects((@[@1, @2]), (@[@1, @2]).concat(@[]).toArray(), nil);
    STAssertEqualObjects((@[@1, @2]), (@[]).concat(@[@1, @2]).toArray(), nil);
    STAssertEqualObjects((@[@1, @1]), (@[@1]).concat(@[@1]).toArray(), nil);
}

- (void)testUnions
{
    STAssertEqualObjects((@[@1, @2]), (@[@1, @2]).unions(@[]).toArray(), nil);
    STAssertEqualObjects((@[@1, @2]), (@[]).unions(@[@1, @2]).toArray(), nil);
    STAssertEqualObjects((@[@1]), (@[@1]).unions(@[@1]).toArray(), nil);
}

- (void)testExcept
{
    STAssertEqualObjects((@[@1, @2]), (@[@1, @2]).except(@[]).toArray(), nil);
    STAssertEqualObjects((@[]), (@[]).except(@[@1, @2]).toArray(), nil);
    STAssertEqualObjects((@[]), (@[@1]).except(@[@1]).toArray(), nil);
    STAssertEqualObjects((@[@2]), (@[@1, @2, @3]).except(@[@1, @3]).toArray(), nil);
}

- (void)testIntersect
{
    STAssertEqualObjects((@[]), (@[@1, @2]).intersect(@[]).toArray(), nil);
    STAssertEqualObjects((@[]), (@[]).intersect(@[@1, @2]).toArray(), nil);
    STAssertEqualObjects((@[@1]), (@[@1]).intersect(@[@1]).toArray(), nil);
    STAssertEqualObjects((@[@1, @3]), (@[@1, @2, @3]).intersect(@[@1, @3]).toArray(), nil);
}

- (void)testOrderBy
{
    
    STAssertEqualObjects((@[]), (@[]).orderBy(kLQIdentity, kLQDefaultComparator).toArray(), nil);
    STAssertEqualObjects((@[@1, @2]), (@[@2, @1]).orderBy(kLQIdentity, kLQDefaultComparator).toArray(), nil);
    STAssertEqualObjects((@[@1, @2]), (@[@1, @2]).orderBy(kLQIdentity, kLQDefaultComparator).toArray(), nil);
    
    STAssertEqualObjects((@[]), (@[]).orderByDescending(kLQIdentity, kLQDefaultComparator).toArray(), nil);
    STAssertEqualObjects((@[@2, @1]), (@[@2, @1]).orderByDescending(kLQIdentity, kLQDefaultComparator).toArray(), nil);
    STAssertEqualObjects((@[@2, @1]), (@[@1, @2]).orderByDescending(kLQIdentity, kLQDefaultComparator).toArray(), nil);
}

- (void)testMin
{
    STAssertEqualObjects(@1, (@[@1]).min(kLQDefaultComparator), nil);
    STAssertEqualObjects(@0, (@[@10, @2, @123, @1, @0]).min(kLQDefaultComparator), nil);
    
    STAssertEqualObjects((@[@1]), (@[@1]).minBy(kLQIdentity, kLQDefaultComparator), nil);
    STAssertEqualObjects((@[@0, @0]), (@[@10, @2, @123, @1, @0, @0]).minBy(kLQIdentity, kLQDefaultComparator), nil);
    STAssertEqualObjects((@[@123]), (@[@10, @2, @123, @1, @1, @1]).minBy(^id(NSNumber* item) { return @(1.0 /[item doubleValue]); }, kLQDefaultComparator), nil);
    
    STAssertThrowsSpecificNamed((@[]).min(kLQDefaultComparator), NSException, @"InvalidOperationException", nil);
    STAssertThrowsSpecificNamed((@[]).minBy(kLQIdentity, kLQDefaultComparator), NSException, @"InvalidOperationException", nil);
}

- (void)testMax
{
    STAssertEqualObjects(@1, (@[@1]).max(kLQDefaultComparator), nil);
    STAssertEqualObjects(@123, (@[@10, @2, @123, @1, @0]).max(kLQDefaultComparator), nil);
    
    STAssertEqualObjects((@[@1]), (@[@1]).maxBy(kLQIdentity, kLQDefaultComparator), nil);
    STAssertEqualObjects((@[@123, @123]), (@[@10, @2, @123, @123, @1, @0, @0]).maxBy(kLQIdentity, kLQDefaultComparator), nil);
    STAssertEqualObjects((@[@1, @1, @1]), (@[@10, @2, @123, @1, @1, @1]).maxBy(^id(NSNumber* item) { return @(1.0 /[item doubleValue]); }, kLQDefaultComparator), nil);
    
    STAssertThrowsSpecificNamed((@[]).max(kLQDefaultComparator), NSException, @"InvalidOperationException", nil);
    STAssertThrowsSpecificNamed((@[]).maxBy(kLQIdentity, kLQDefaultComparator), NSException, @"InvalidOperationException", nil);
}

- (void)testZip
{
    STAssertEqualObjects((@[@3, @5]), (@[@1, @2]).zip(@[@2, @3], ^(NSNumber* a, NSNumber* b) { return @([a integerValue] + [b integerValue]); }).toArray(), nil);
    STAssertEqualObjects((@[@3, @5]), (@[@1, @2]).zip(@[@2, @3, @4], ^(NSNumber* a, NSNumber* b) { return @([a integerValue] + [b integerValue]); }).toArray(), nil);
    STAssertEqualObjects((@[@3, @5]), (@[@1, @2, @3]).zip(@[@2, @3], ^(NSNumber* a, NSNumber* b) { return @([a integerValue] + [b integerValue]); }).toArray(), nil);
    STAssertEqualObjects((@[]), (@[]).zip(@[@2, @3], ^(NSNumber* a, NSNumber* b) { return @([a integerValue] + [b integerValue]); }).toArray(), nil);
    STAssertEqualObjects((@[]), (@[@1, @2]).zip(@[], ^(NSNumber* a, NSNumber* b) { return @([a integerValue] + [b integerValue]); }).toArray(), nil);
}

- (void)testDictionary {
    NSDictionary* test = @{@1 : @1};
    STAssertEquals(test.count, test.ofClass([LQKeyValuePair class]).length(), nil);
}

- (void)testJoin {
    Person* magnus = [Person makeWithName:@"Hedlund, Magnus"];
    Person* terry = [Person makeWithName:@"Adams, Terry"];
    Person* charlotte = [Person makeWithName:@"Weiss, Charlotte"];

    Pet* barley = [Pet  makeWithName:@"Barley" andOwner:terry];
    Pet* boots = [Pet  makeWithName:@"Boots" andOwner:terry];
    Pet* whiskers = [Pet  makeWithName:@"Whiskers" andOwner:charlotte];
    Pet* daisy = [Pet  makeWithName:@"Daisy" andOwner:magnus];

    NSArray* people = @[ magnus, terry, charlotte ];
    NSArray* pets = @[ barley, boots, whiskers, daisy ];

    // Create a list of Person-Pet pairs where
    // each element is a NSDictionary type that contains a
    // Pet's name and the name of the Person that owns the Pet.
    id<LQEnumerable> query = people
        .join(pets,
              ^id(Person* person) { return person; },
              ^id(Pet* pet) { return pet.owner; },
              ^id(Person* person, Pet* pet) { return @{@"OwnerName": person.name, @"Pet": pet.name}; })
        .toArray();

    NSArray* expected = @[
        @{@"OwnerName": @"Hedlund, Magnus", @"Pet": @"Daisy"},
        @{@"OwnerName": @"Adams, Terry", @"Pet": @"Barley"},
        @{@"OwnerName": @"Adams, Terry", @"Pet": @"Boots"},
        @{@"OwnerName": @"Weiss, Charlotte", @"Pet": @"Whiskers"}
    ];
    
    STAssertEqualObjects(expected, query, nil);
}
@end
