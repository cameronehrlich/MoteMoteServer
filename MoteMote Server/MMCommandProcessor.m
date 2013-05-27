//
//  MMCommandProcessor.m
//  MoteMote
//
//  Created by Cameron Ehrlich on 5/27/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMCommandProcessor.h"

@implementation MMCommandProcessor

+ (void) send: (NSString *) input {
    NSString *command = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([command isEqualToString:@"Play"]) {
        [self play];
    }
    if ([command isEqualToString:@"Pause"]) {
        [self pause];
    }
    if ([command isEqualToString:@"Playpause"]) {
        [self playpause];
    }
    if ([command isEqualToString:@"Prev"]) {
        [self previous];
    }
    if ([command isEqualToString:@"Next"]) {
        [self next];
    }
}

+ (void) runAppleScript: (NSString *)appleScript {
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:appleScript];
    [script executeAndReturnError:nil];
}


+ (void) play {

    [self runAppleScript:@"tell application \"Spotify\" to play"];
}

+ (void) pause {

    [self runAppleScript:@"tell application \"Spotify\" to pause"];
}

+ (void) playpause {

    [self runAppleScript:@"tell application \"Spotify\" to playpause"];
}

+ (void) previous {
    
    [self runAppleScript:@"tell application \"Spotify\" to previous track"];
}

+ (void) next {
    
    [self runAppleScript:@"tell application \"Spotify\" to next track"];
}
@end
