//
//  BCTrackingClass.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCTrackingClass : NSObject


+(void)setUpTrackingWithMethodArray:(NSArray*)anArray;
+(void)logCallForMethod:(NSString*)aSelectorString;

@end