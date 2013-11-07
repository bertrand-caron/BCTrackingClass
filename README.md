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
Drag the two files `BCTrackingClass.h` and `BCTrackingClass.m`.


Usage
-----
For every class you would like to track :
- import the class header
in your `.m` file : `#import "BCTrackingClass.h"`
- Create a `+(void)load` method calling `+(void)setUpTrackingForClass:(Class)aClass andMethodArray:(NSArray*)anArray` : 

```
[TrackingClass setUpTrackingForClass:[self class] andMethodArray:
            [ NSArray arrayWithObjects:@"doA",@"doB", nil]
         ];
```
- Personnalize the `+(void)logCallForMethod:(NSString*)aSelectorString` method


