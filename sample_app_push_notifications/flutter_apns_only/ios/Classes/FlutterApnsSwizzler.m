#import "FlutterApnsSwizzler.h"
#import <objc/runtime.h>
#import <Flutter/Flutter.h>

static int swizzleCounter;

@interface FlutterApnsSwizzler ()
@end

@implementation FlutterApnsSwizzler

+ (BOOL)didSwizzle {
    return swizzleCounter > 0;
}

+ (void)apns_registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    swizzleCounter++;
}

+ (void)disablePluginNamed:(NSString *)name {
    Class c = NSClassFromString(name);
    
    if (!c) {
        return;
    }
    
    SEL orig = @selector(registerWithRegistrar:);
    SEL new = @selector(apns_registerWithRegistrar:);
    
    Method origMethod = class_getClassMethod(c, orig);
    Method newMethod = class_getClassMethod(self, new);
    
    c = object_getClass((id)c);
    
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_setImplementation(origMethod, method_getImplementation(newMethod));
}

/// Returns flag stored in Info.plist. True if value is not present.
+ (BOOL)getFlag:(NSString *)key defaultValue:(BOOL)defaultValue {
    NSString *keyWithSuffix = [NSString stringWithFormat:@"flutter_apns.%@", key];
    NSObject *disable = [NSBundle mainBundle].infoDictionary[keyWithSuffix];
    
    if (disable) {
        if ([disable isKindOfClass:[NSNumber class]]) {
            return ((NSNumber *)disable).boolValue;
        }
        NSAssert(false, @"flutter_apns: invalid value of flutter_apns.%@", key);
    }
    
    return defaultValue;
}

+ (void)load {
    if ([self getFlag:@"disable_swizzling" defaultValue: NO]) {
        return;
    }

    if ([self getFlag:@"disable_firebase_core" defaultValue: YES]) {
        [self disablePluginNamed:@"FLTFirebaseCorePlugin"];
    }

    [self disablePluginNamed:@"FLTFirebaseMessagingPlugin"];
}

@end
