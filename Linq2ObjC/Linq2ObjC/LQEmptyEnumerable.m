#import "LQEmptyEnumerable.h"

@implementation LQEmptyEnumerable

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
    return 0;
}

- (LQSelectBlock) select {
    LQSelectBlock block = ^id<LQEnumerable>(LQProjection selector) {
        return self;
    };
    
    return [Block_copy(block) autorelease];
}

- (LQWhereBlock) where {
    LQWhereBlock block = ^id<LQEnumerable>(LQFilter filter) {
        return self;
    };
    
    return [Block_copy(block) autorelease];
}

- (LQSelectManyBlock) selectMany {
    LQSelectManyBlock block = ^id<LQEnumerable>(LQSelectMany  selector) {
        return self;
    };
    
    return [Block_copy(block) autorelease];
}

- (NSArray*) toArray {
    return nil;
}

@end
