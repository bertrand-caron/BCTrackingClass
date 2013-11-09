//
//  main.m
//  BCTrackingClass
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCTrackedClass.h"
#import "BCTrackedClass2.h"
#include <objc/runtime.h>
#include <objc/objc-runtime.h>
#import "BCTrackingClass.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BCTrackingClass* tracker = [[BCTrackingClass alloc]init];
        NSLog(@"Init a tracker at address : %p",tracker);
        
        /*Method trackerLog =class_getClassMethod([BCTrackingClass class], @selector(logCallForMethod:));
        
        Method classLog =class_getInstanceMethod([tracker class], @selector(logCallForMethod:));
        
        method_exchangeImplementations(trackerLog, classLog);*/
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
        
 
        
        
    }
    return 0;
}

