//
//  MMCommandProcessor.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMCommandProcessor.h"

@implementation MMCommandProcessor

+ (NSString *) executeAppleScriptFromString:(NSString *) scriptString {
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptString];    
    NSMutableDictionary *errorDict;
    // do something with errors?
    NSString *returnValue = [[script executeAndReturnError:&errorDict] stringValue];
    return returnValue;
}

@end
