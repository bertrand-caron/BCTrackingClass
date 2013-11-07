BCTrackingClass
===============

Objective-C class setting up method swizzling for tracking message sending

Motivation
----------
Designing a framework allowing an Application to instrospect its own behaviour,
 via the logging of its message sending.


Installation
------------
Drag the two files `BCTrackingClass.h` and `BCTrackingClass.m`.


Usage
-----
For every class you would like to track :
- import the class header
in your `.m` file : `#import "BCTrackingClass.h"`
- Create a `+(void)load` method


