#import "NSArray+Linq.h"
#import "LQEnumerator.h"

@implementation NSArray (Linq)

@dynamic select;
- (LQSelectBlock) select {
    return [self objectEnumerator].select;
}

@dynamic where;
- (LQWhereBlock) where {
    return [self objectEnumerator].where;
}

@dynamic selectMany;
- (LQSelectManyBlock) selectMany {
    return [self objectEnumerator].selectMany;
}

@dynamic toArray;
- (NSArray*) toArray {
    return self;
}

@end

CATEGORY_LINK_FIX_IMPL(NSArray_Linq)