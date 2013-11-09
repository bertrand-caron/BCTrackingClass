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

Limitations
-----------

- Tracked methods need to be returning a `-(void)` 
- Tracked methods can take up to three arguments, which have to be of type `(id)`, i.e. be objective-C objects (no `BOOL`,`int` or C-struct and so on).

Failure to do so will result in at least BAD bahavior, at most memory corruption and/or loss or arguments.

Discussion
----------

### Where to set up the tracking ?

Depending on how soon your methods are suceptible to be called, you should set up the tracker in "deeper" methods.
If you are not particularly insterested in early calling (i.e. before `- (void)applicationDidFinishLaunching:(NSNotification *)aNotification`), 
it looks like a good place to do so : 

```
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
        BCTrackingClass* tracker = [[BCTrackingClass alloc]init];
        [tracker registerTrackerAsDefault];

        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB",@"doD:", nil]
         ];
        [BCTrackingClass setUpTrackingForClass:[BCTrackedClass2 class] andMethodArray:
         [ NSArray arrayWithObjects:@"doA",@"doB", nil]
         ];
}
```
