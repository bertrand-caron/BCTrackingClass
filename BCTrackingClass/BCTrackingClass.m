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

@synthesize trackerDict;


-(id)init
{
    self = [super init];
    if (self)
    {
        trackerDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return self;
}


void myMethodIMP(id self, SEL _cmd);

void myMethodIMP(id self, SEL _cmd)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]));
}

void myMethodIMP1Arg(id self, SEL _cmd, id object1);

void myMethodIMP1Arg(id self, SEL _cmd, id object1)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object1);
}

void myMethodIMP2Arg(id self, SEL _cmd, id object1, id object2);

void myMethodIMP2Arg(id self, SEL _cmd, id object1, id object2)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object1,
                 object2);
}

void myMethodIMP3Arg(id self, SEL _cmd, id object1, id object2, id object3);

void myMethodIMP3Arg(id self, SEL _cmd, id object1, id object2, id object3)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    [BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object1,
                 object2,
                 object3);
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
        else if (argNumber==2)
        {
            class_addMethod(aClass,
                            trackedSelector,
                            (IMP) myMethodIMP2Arg, encoding);
        }
        else if (argNumber==3)
        {
            class_addMethod(aClass,
                            trackedSelector,
                            (IMP) myMethodIMP3Arg, encoding);
        }
        else
        {
            NSLog(@"Your method takes too many argument to be tracked. Aborting.");
            return;
        }
        
        //Swizzle the original method with the tracked one

        Method swizzled = class_getInstanceMethod(aClass,
                                                  trackedSelector);
        method_exchangeImplementations(original, swizzled);
    }
}

#pragma mark - Logging the calls

/**
If we don't have a registered tracker, the calls will end up being logged here
*/
+(void)logCallForMethod:(NSString*)aSelectorString
{
    NSLog(@"Catched a call to : %@",aSelectorString);
}

/**
 If we have a registered tracker, the calls are being logged here
*/
-(void)logCallForMethod:(NSString*)aSelectorString
{
    if (! [trackerDict isKindOfClass:[NSMutableDictionary class]])
    {
        return;
    }
    
    NSLog(@"Catched a call to : %@",aSelectorString);
    if ([trackerDict objectForKey:aSelectorString])
    {
        [trackerDict setObject:
         	[NSNumber numberWithInt:
             	[[trackerDict objectForKey:aSelectorString]intValue]+1]
            forKey:aSelectorString];
    }
    else
    {
        [trackerDict setObject:[NSNumber numberWithInt:1] forKey:aSelectorString];
    }
        
}

#pragma mark - Registering a tracker as the default one

/**
Register a tracker as the default one by swizzling its own -logCallForMethod with the class' one.
//FIXME: Is gonna be troublesome if called multiple times
*/
-(void)registerTrackerAsDefault
{
    Method classLog =class_getClassMethod([BCTrackingClass class], @selector(logCallForMethod:));
    
    Method selfLog =class_getInstanceMethod([self class], @selector(logCallForMethod:));
    
    method_exchangeImplementations(selfLog, classLog);
}


@end
