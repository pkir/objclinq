#import "LQEnumerable.h"

@interface LQEmptyEnumerable : NSObject<LQEnumerable>

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len;

@end
