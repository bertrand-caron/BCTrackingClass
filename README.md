BCTrackingClass
===============

Objective-C class setting up method swizzling for tracking message sending

Motivation
----------
Designing a framework allowing an Application to instrospect its own behaviour,
 via the logging of its message sending.
One could imagine writing a Framework that would dynamically present to the user 
some underused feature he could benefit from.

Installation
------------
Drag the two files `BCTrackingClass.h` and `BCTrackingClass.m` to your project.


Usage
-----
- Init a tracker and make it your application default one, adding 
these lines to your `main.m` : 
```
//  main.m

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
        BCTrackingClass* tracker = [[BCTrackingClass alloc]init];
        NSLog(@"Init a tracker at address : %p",tracker);
        [tracker registerTrackerAsDefault];

	return NSApplicationMain(argc, (const char **)argv);
}

```
- Add the relevant line for every class and methods you would like to track :
```
//  main.m

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
        BCTrackingClass* tracker = [[BCTrackingClass alloc]init];
        NSLog(@"Init a tracker at address : %p",tracker);
        [tracker registerTrackerAsDefault];

        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB",@"doD:", nil]
         ];
        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass2 class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB", nil]
         ];


	return NSApplicationMain(argc, (const char **)argv);
}

```
- Optionnal : By default, the calls are logged to `NSMutableDictionnary* trackerDict `. 
Feel free to personnalize the `-(void)logCallForMethod:(NSString*)aSelectorString` method if you need more.


