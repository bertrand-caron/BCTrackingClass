//
//  main.m
//  BCTrackingClass
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCTrackedClass.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        //NSLog(@"Hello, World!");
        
        
        BCTrackedClass* tracked = [[BCTrackedClass alloc]init];
        [tracked doA];
        [tracked doB];
        [tracked doC];
        [tracked doB];
        [tracked doA];
        
        
    }
    return 0;
}

