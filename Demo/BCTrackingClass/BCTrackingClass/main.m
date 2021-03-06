//
//  main.m
//  BCTrackingClass
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//
/// @file main.m
/// @mainpage

#import <Foundation/Foundation.h>
#import "BCTrackedClass.h"
#import "BCTrackedClass2.h"
#include <objc/runtime.h>
#include <objc/objc-runtime.h>
#import "BCTrackingClass.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB",@"doD:",@"returnHello", nil]
         ];
        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass2 class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB",@"exclusiveMethod", nil]
         ];
        
        BCTrackingClass* tracker = [[BCTrackingClass alloc]init];
        NSLog(@"Init a tracker at address : %p",tracker);
        [tracker registerTrackerAsDefault];
        
        
        BCTrackedClass* tracked = [[BCTrackedClass alloc]init];
        [tracked doA];
        [tracked doB];
        [tracked doC];
        [tracked doD:@"Hello"];
        [tracked doB];
        [tracked doA];
        
        BCTrackedClass2* tracked2 = [[BCTrackedClass2 alloc]init];
        [tracked2 doA];
        [tracked2 doB];
        [tracked2 doC];
        [tracked2 doB];
        [tracked2 doA];
        [tracked2 exclusiveMethod];
        
        NSLog(@"%@",[tracked returnHello]);
        
        
        //Trying to disable tracking
        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA", nil]
         ];
        NSLog(@"Disabled Tracking for : doA");
        
        for (id key in tracker.trackerDict) {
            NSLog(@"key: %@, value: %@ \n", key, [tracker.trackerDict objectForKey:key]);
        }
        
        NSLog(@"Running doA, which should be untracked.");
        [tracked doA];
        
        for (id key in tracker.trackerDict) {
            NSLog(@"key: %@, value: %@ \n", key, [tracker.trackerDict objectForKey:key]);
        }
        
    }
    return 0;
}

