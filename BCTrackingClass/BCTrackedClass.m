//
//  BCTrackedClass.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCTrackedClass.h"

@implementation BCTrackedClass

+(void)load
{
    [BCTrackingClass setUpTrackingWithMethodArray:(NSArray *)
        [NSArray arrayWithObjects:@"doA", nil]
     ];
}

-(id)init
{
    self = [super init];
    
    return self;
}

-(void)doA
{
    NSLog(@"Do A");
}
-(void)doB
{
    NSLog(@"Do B");
}


@end
