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
@end


CATEGORY_LINK_FIX(NSDictionary_Linq)