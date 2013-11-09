//
//  BCTrackingClass.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCTrackingClass : NSObject

@property (assign) NSMutableDictionary* trackerDict;

-(id)init;

+(void)setUpTrackingForClass:(Class)aClass andMethodArray:(NSArray*)anArray;
+(void)logCallForMethod:(NSString*)aSelectorString;
-(void)logCallForMethod:(NSString*)aSelectorString;

-(void)registerTrackerAsDefault;

@end
