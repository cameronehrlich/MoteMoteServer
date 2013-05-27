//
//  MMMainViewController.m
//  MoteMote Server
//
//  Created by Cameron Ehrlich on 5/26/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "MMMainViewController.h"

@implementation MMMainViewController

@synthesize textView;

-(void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"log" object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification {
    
    [textView setString:[NSString stringWithFormat:@"%@\n%@", [notification.userInfo objectForKey:@"message"], textView.string]];
}

@end
