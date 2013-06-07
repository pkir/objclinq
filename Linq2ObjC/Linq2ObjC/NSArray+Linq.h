#import <Foundation/Foundation.h>
#import "Macros.h"
#import "LQEnumerable.h"

@interface NSArray (Linq) <LQEnumerable>

@property (readonly, nonatomic) LQSelectBlock select;
@property (readonly, nonatomic) LQWhereBlock where;
@property (readonly, nonatomic) LQSelectManyBlock selectMany;

@end


CATEGORY_LINK_FIX(NSArray_Linq)