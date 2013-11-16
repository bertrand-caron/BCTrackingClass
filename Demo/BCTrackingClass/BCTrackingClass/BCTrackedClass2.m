//
//  BCTrackedClass2.m
//  BCTrackingClass
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCTrackedClass2.h"

@implementation BCTrackedClass2

BOOL doSwizzle2 = YES;

+(void)load
{
    /*if (doSwizzle2)
    {   [BCTrackingClass setUpTrackingForClass:[self class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB", nil]
         ];
    }*/
}

-(id)init
{
    self = [super init];
    
    return self;
}

-(void)doA
{   //NSLog(@"Message : doA");
    //NSLog(@"_cmd : %@\n",NSStringFromSelector(_cmd));
    
}
-(void)doB
{
    //NSLog(@"Message : doB");
    //NSLog(@"_cmd : %@\n",NSStringFromSelector(_cmd));
}
-(void)doC
{
    //NSLog(@"Message : doC");
    //NSLog(@"_cmd : %@\n",NSStringFromSelector(_cmd));
}

-(void)exclusiveMethod
{
    
}

@end
