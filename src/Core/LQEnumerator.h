#import <Foundation/Foundation.h>
#import "LQEnumerable.h"

extern LQProjection kLQIdentity;
extern LQPredicate kLQYesPredicate;
extern LQPredicate kLQNoPredicate;
extern NSComparator kLQDefaultComparator;
extern LQEqualityComparer kLQDefaultEqualityComparer;

@interface LQEnumerator : NSEnumerator {
    NSEnumerator* _src;
    id (^_nextObject)(NSEnumerator*);
}

+ (LQEnumerator*)enumeratorWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject;
- (id)initWithFunction:(NSEnumerator*)src nextObjectBlock:(id(^)(NSEnumerator*))nextObject;
- (id)nextObject;
@end

@interface NSEnumerator(Linq)<LQEnumerable>
@end