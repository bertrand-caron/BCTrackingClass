//
//  BCTrackingClass.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 07/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Abstract class in charge of tracking message sending to any given class.
 */

@interface BCTrackingClass : NSObject

/**
 Used to keep track of the calls when a registered Tracker is set.
 */
@property NSMutableDictionary* trackerDict;

/**
Only way to init a Tracker object.
*/
-(id)init;

/**
 Only method to call to set up tracking of the methods.
 
 @param aClass The class whose method will be tracked.
 @param anArray
 */
+(void)setUpTrackingForClass:(Class)aClass andMethodArray:(NSArray*)anArray;

/**
 
 @param aSelectorString String of the selector whose call we are logging.
*/
+(void)logCallForMethod:(NSString*)aSelectorString;

/**
 
 @param aSelectorString String of the selector whose call we are logging.
 */
-(void)logCallForMethod:(NSString*)aSelectorString;

/**
 Register a tracker as defaut using "static BCTrackingClass* registeredTracker". Plain simple.
*/
-(void)registerTrackerAsDefault;

@end
