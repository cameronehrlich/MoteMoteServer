//
//  MMCommandProcessor.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMCommandProcessor.h"

@implementation MMCommandProcessor

+ (void) process: (NSData *) input {
    NSData *jsonData = [[[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {NSLog(@"%@", error);}
    NSLog(@"%@", parsedData.description);
    
    // Contruct Command and run it
    NSString *application = [parsedData objectForKey:@"application"];
    NSString *command = [parsedData objectForKey:@"command"];
    NSString *constructedCommand = [NSString stringWithFormat:@"tell application \"%@\" to %@", application, command];
    
    [self runAppleScript:constructedCommand];
}

+ (void) runAppleScript: (NSString *)appleScript {
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:appleScript];
    [script executeAndReturnError:nil];
}

@end
