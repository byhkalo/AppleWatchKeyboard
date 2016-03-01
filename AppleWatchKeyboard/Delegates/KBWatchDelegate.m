//
//  KBWatchDelegate.m
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 01.03.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "KBWatchDelegate.h"

@implementation KBWatchDelegate

#pragma mark -
#pragma mark Initialization -

- (instancetype)initWithSession:(WCSession*)session {
    if (self = [super init]) {
        if ([WCSession isSupported]) {
            session.delegate = self;
            [session activateSession];
        }
    }
    return self;
}

#pragma mark -
#pragma mark WCSessionDelegate -

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    
    
    
    NSInteger random = arc4random()%200;
    NSString *stringRandom = [NSString stringWithFormat:@"%ld",(long)random];
    replyHandler(@{@"word":stringRandom});
    
    NSLog(@"This method");
}

@end
