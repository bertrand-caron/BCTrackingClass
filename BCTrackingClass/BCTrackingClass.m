//
//  BCTrackingClass.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCTrackingClass.h"
#import "BCTrackedClass.h"
#include <objc/runtime.h>
#include <objc/objc-runtime.h>

@implementation BCTrackingClass

void myMethodIMP(id self, SEL _cmd);

void myMethodIMP(id self, SEL _cmd)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]));
}

void myMethodIMP1Arg(id self, SEL _cmd, id object);

void myMethodIMP1Arg(id self, SEL _cmd, id object)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object);
}

+(void)setUpTrackingForClass:(Class)aClass andMethodArray:(NSArray*)anArray //Array of selectorsStrings of methods to track
{
    for (NSString* selectorString in anArray)
    {
        SEL selector = NSSelectorFromString(selectorString);
        
        Method original = class_getInstanceMethod(aClass,
                                                  selector);
        const char* encoding = method_getTypeEncoding(original);
        
        //Get number of arguments
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@":" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger argNumber = [regex numberOfMatchesInString:selectorString options:0 range:NSMakeRange(0, [selectorString length])];
        
        SEL trackedSelector = NSSelectorFromString([NSString stringWithFormat:@"tracked%@",selectorString]);
        
        if (argNumber==0)
        {
            class_addMethod(aClass,
                        trackedSelector,
                        (IMP) myMethodIMP, encoding);
        }
        else if (argNumber==1)
        {
            class_addMethod(aClass,
                            trackedSelector,
                            (IMP) myMethodIMP1Arg, encoding);
        }
        
        
        //Swizzle the original method with the tracked one

        Method swizzled = class_getInstanceMethod(aClass,
                                                  trackedSelector);
        method_exchangeImplementations(original, swizzled);
    }
}

+(void)logCallForMethod:(NSString*)aSelectorString
{
    NSLog(@"Catched a call to : %@",aSelectorString);
}
@end
