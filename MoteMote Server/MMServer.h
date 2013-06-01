//
//  MMServer.h
//  NetworkingTestServer
//
//  Created by Cameron Ehrlich on 5/31/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "DTBonjourServer.h"
#import "DTBonjourDataConnection.h"
#import "DTBonjourDataChunk.h"
#import "MMCommandProcessor.h"


@interface MMServer : NSObject <DTBonjourServerDelegate, DTBonjourDataConnectionDelegate>

@property (nonatomic, strong) DTBonjourServer *server;

- (void) sendObject:(id) object;

@end
