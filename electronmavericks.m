// clang -dynamiclib -o libMavericks.dylib electronmavericks.m -framework Cocoa -mmacosx-version-min=10.9 -arch x86_64

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>

@interface NSFont (Swizzle)

+ (NSFont *)swizzled_systemFontOfSize:(CGFloat)size weight:(CGFloat)weight;

@end

@implementation NSFont (Swizzle)

+ (NSFont *)swizzled_systemFontOfSize:(CGFloat)size weight:(CGFloat)weight {
    return [NSFont systemFontOfSize:size];
}

@end

static BOOL swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

    Class metaclass = object_getClass((id)class);

    if (originalMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
        //NSLog(@"Swizzled %@ successfully.", NSStringFromSelector(originalSelector));
        return YES;
    } else {
        BOOL didAddMethod = class_addMethod(metaclass,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            //NSLog(@"Added and swizzled %@ successfully.", NSStringFromSelector(originalSelector));
            return YES;
        }
    }

    //NSLog(@"Failed to swizzle %@.", NSStringFromSelector(originalSelector));
    return NO;
}

__attribute__((constructor))
static void ElectronSwizzle() {
    swizzleMethod([NSFont class], @selector(systemFontOfSize:weight:), @selector(swizzled_systemFontOfSize:weight:));
}
