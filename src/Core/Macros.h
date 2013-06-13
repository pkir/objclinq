#define CATEGORY_LINK_FIX(name) @interface LinkFix##name: NSObject @end
#define CATEGORY_LINK_FIX_IMPL(name) @implementation LinkFix##name @end

#define LQ_AUTORELEASE(obj) [obj autorelease]

#if defined(__has_feature) && __has_feature(objc_arc)
#define WeakRefAttribute __weak
#else
#define WeakRefAttribute __block __unsafe_unretained
#endif

#define WeakRef(weakVar, var) WeakRefAttribute __typeof(var) weakVar = var