//
//  MMAppDelegate.m
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMAppDelegate.h"

@implementation MMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [MMModel sharedModel];
    CGDisplayMoveCursorToPoint (kCGDirectMainDisplay, CGPointZero);
}

@end
