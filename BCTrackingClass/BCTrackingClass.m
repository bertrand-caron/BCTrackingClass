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

static BCTrackingClass* registeredTracker;

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
    if (registeredTracker==nil)
    {[BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];}
    else
    {
        [registeredTracker logCallForMethod:NSStringFromSelector(_cmd)];
    }
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]));
}


void myMethodIMP1Arg(id self, SEL _cmd, id object1);

void myMethodIMP1Arg(id self, SEL _cmd, id object1)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    if (registeredTracker==nil)
    {[BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];}
    else
    {
        [registeredTracker logCallForMethod:NSStringFromSelector(_cmd)];
    }
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object1);
}

void myMethodIMP2Arg(id self, SEL _cmd, id object1, id object2);

void myMethodIMP2Arg(id self, SEL _cmd, id object1, id object2)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    if (registeredTracker==nil)
    {[BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];}
    else
    {
        [registeredTracker logCallForMethod:NSStringFromSelector(_cmd)];
    }
    objc_msgSend(self,
                 NSSelectorFromString([NSString stringWithFormat:@"tracked%@",NSStringFromSelector(_cmd)]),
                 object1,
                 object2);
}

void myMethodIMP3Arg(id self, SEL _cmd, id object1, id object2, id object3);

void myMethodIMP3Arg(id self, SEL _cmd, id object1, id object2, id object3)
{
    //NSLog(@"_cmd : %@",NSStringFromSelector(_cmd));
    if (registeredTracker==nil)
    {[BCTrackingClass logCallForMethod:NSStringFromSelector(_cmd)];}
    else
    {
        [registeredTracker logCallForMethod:NSStringFromSelector(_cmd)];
    }
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
        
        //Select the correct IMP, givent the number of arguments
        IMP correctIMP;
        if (argNumber==0)
        {
            correctIMP =(IMP) myMethodIMP;
        }
        else if (argNumber==1)
        {
            correctIMP =(IMP) myMethodIMP1Arg;
        }
        else if (argNumber==2)
        {
            correctIMP =(IMP) myMethodIMP2Arg;
        }
        else if (argNumber==3)
        {
            correctIMP =(IMP) myMethodIMP3Arg;
        }
        else
        {
            NSLog(@"Your method takes too many argument to be tracked. Aborting.");
            return;
        }
        class_addMethod(aClass,
                        trackedSelector,
                        correctIMP, encoding);
        
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
 If we have a registered tracker, the calls are being logged here.
*/
-(void)logCallForMethod:(NSString*)aSelectorString
{
    /*if (! [trackerDict isKindOfClass:[NSMutableDictionary class]])
    {
        return;
    }*/
    
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
Register a tracker as using "static BCTrackingClass* registeredTracker". Plain simple.
*/
-(void)registerTrackerAsDefault
{
    registeredTracker = self;
}


@end
