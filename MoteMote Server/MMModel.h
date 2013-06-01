//
//  MMModel.h
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMServer.h"

@interface MMModel : NSObject <NSNetServiceDelegate>

@property (nonatomic, strong) MMServer *server;
+ (id) sharedModel;

@end
