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

void myMethodIMP(id self, SEL _cmd, SEL mySelector);

void myMethodIMP(id self, SEL _cmd, SEL mySelector)
{
    NSLog(@"%@",NSStringFromSelector(mySelector));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(mySelector)];
    objc_msgSend(self, mySelector);      // Equivalent to [self mySelector];
}

+(void)setUpTrackingWithMethodArray:(NSArray*)anArray	//Array of selectorsStrings of methods to track
{
    for (NSString* selectorString in anArray)
    {
        SEL selector = NSSelectorFromString(selectorString);
        SEL trackedSelector = NSSelectorFromString([NSString stringWithFormat:@"tracked%@",selectorString]);
    	/*//Create a method stub @selector(trackedMySelector) doing :
    	^{       [BCTrackingClass logCallForMethod: "mySelector"]; //Log whatever I wanna log
                [myObject "call my selector"]; 		//Then call the method it is stubbing
    	}
    	// HOW ??*/
        
        class_addMethod([BCTrackedClass class],
                        trackedSelector,
                        (IMP) myMethodIMP, "v@:@"); //Whats the type encoding for myMethodImp ?
        
        //Swizzle the original method with the tracked one
        Method original = class_getInstanceMethod([BCTrackedClass class],
                        selector);
    	Method swizzled = class_getInstanceMethod([BCTrackedClass class],
                        trackedSelector);
        method_exchangeImplementations(original, swizzled);
    }
}

+(void)logCallForMethod:(NSString*)aSelectorString
{
    NSLog(@"%@",aSelectorString);
}
@end
