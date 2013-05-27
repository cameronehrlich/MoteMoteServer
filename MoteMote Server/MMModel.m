//
//  MMModel.m
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMModel.h"
#import "MMCommandProcessor.h"

#define DATA_LENGTH 30

@implementation MMModel

+ (id)sharedModel {
    static MMModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
        asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        connectedSockets = [[NSMutableArray alloc] init];

        NSError *err = nil;
        if ([asyncSocket acceptOnPort:0 error:&err]) {
            UInt16 port = [asyncSocket localPort];
            netService = [[NSNetService alloc] initWithDomain:@"local." type:@"_motemote._tcp." name:@"" port:port];
            [netService setDelegate:self];
            [netService publish];

        }else {
            NSLog(@"Error in acceptOnPort:error: -> %@", err);
        }
    }
    return self;
}


- (void) processCommand: (NSData *) data {
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
    NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    
    [MMCommandProcessor send:msg];
    [self logNotification:msg];
}

- (void) logNotification: (NSString *) string {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"log" object:nil userInfo:@{@"message":string}];
    NSLog(@"%@", string);
}

#pragma mark NetService Delegate

- (void)netServiceDidPublish:(NSNetService *)ns {
    
    [self logNotification:[NSString stringWithFormat:@"Bonjour Published: %@ %@ %@ :%i", [ns domain], [ns type], [ns name], (int)[ns port]]];
}

- (void)netService:(NSNetService *)ns didNotPublish:(NSDictionary *)errorDict {
	[self logNotification:@"Failed to Publish Service"];
}

#pragma mark GCDAsyncSocket Delegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
	[connectedSockets addObject:newSocket];
	
	NSString *host = [newSocket connectedHost];
	UInt16 port = [newSocket connectedPort];
	
    [self logNotification:[NSString stringWithFormat:@"New client %@:%hu", host, port]];
    
    [newSocket readDataToLength:DATA_LENGTH withTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    [self processCommand:data];
    
    for (GCDAsyncSocket *sock in connectedSockets) {
        [sock readDataToLength:DATA_LENGTH withTimeout:-1 tag:1];
    }
}


- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
	[connectedSockets removeObject:sock];
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
}

@end
