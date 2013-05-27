//
//  MMModel.h
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface MMModel : NSObject <NSNetServiceDelegate> {
	NSNetService *netService;
	GCDAsyncSocket *asyncSocket;
	NSMutableArray *connectedSockets;
}

+ (id) sharedModel;

@end
