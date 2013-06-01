//
//  MMServer.m
//  NetworkingTestServer
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMServer.h"

static NSString *_domain = @"_motemote._tcp.";

@implementation MMServer

@synthesize server;
- (id)init
{
    self = [super init];
    if (self) {
        server = [[DTBonjourServer alloc] initWithBonjourType:_domain];
        [server setDelegate:self];
        [server start];
    }
    return self;
}

-(void) sendObject:(id) object{
    [self.server broadcastObject:object];
    
}


#pragma mark DTBonjourDataConnectionDelegate

-(void)connectionDidClose:(DTBonjourDataConnection *)connection{
    NSLog(@"Connection closed");
}

-(void)connection:(DTBonjourDataConnection *)connection willStartSendingChunk:(DTBonjourDataChunk *)chunk{
    NSLog(@"will start sending chunks");
}

-(void)connection:(DTBonjourDataConnection *)connection willStartReceivingChunk:(DTBonjourDataChunk *)chunk{
    NSLog(@"will start reciving chunks");
}

-(void)connection:(DTBonjourDataConnection *)connection didFinishSendingChunk:(DTBonjourDataChunk *)chunk{
    NSLog(@"did finish sending chunks");
}

-(void)connection:(DTBonjourDataConnection *)connection didFinishReceivingChunk:(DTBonjourDataChunk *)chunk{
    NSLog(@"did finish receiving chunks");
}


#pragma mark DTBonjourServerDelegate

-(void)bonjourServer:(DTBonjourServer *)server didAcceptConnection:(DTBonjourDataConnection *)connection{
    NSLog(@"new connection : %@", connection.description);
}

-(void)bonjourServer:(DTBonjourServer *)server didReceiveObject:(id)object onConnection:(DTBonjourDataConnection *)connection{
    NSLog(@"%@", object);
    CGDisplayMoveCursorToPoint (kCGDirectMainDisplay, CGPointMake([[object objectForKey:@"x"] floatValue], [[object objectForKey:@"y"] floatValue]));
    
//    [MMCommandProcessor executeAppleScriptFromString:object];
    
//    [self sendObject:theVolume];
}


@end
