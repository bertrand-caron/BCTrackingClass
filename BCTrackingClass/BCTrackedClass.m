//
//  BCTrackedClass.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCTrackedClass.h"

@implementation BCTrackedClass

BOOL doSwizzle = YES;

+(void)load
{
    /*if (doSwizzle)
    {   [BCTrackingClass setUpTrackingForClass:[self class] andMethodArray:
            [ NSArray arrayWithObjects:@"doA",@"doB",@"doD:", nil]
         ];
    }*/
}

-(id)init
{
    self = [super init];
    
    return self;
}

-(void)doA
{   //NSLog(@"Running : doA");
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

//Method with arguments
-(void)doD:(id)anObject
{
    if ([anObject isKindOfClass:[NSString class]])
    {NSLog(@"%@",anObject);}
}

-(NSString*)returnHello
{
    return @"Hello";
}

@end
