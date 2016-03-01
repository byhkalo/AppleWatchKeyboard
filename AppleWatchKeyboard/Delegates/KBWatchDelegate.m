//
//  KBWatchDelegate.m
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 01.03.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "KBWatchDelegate.h"
#import "Tree.h"

@interface KBWatchDelegate ()

@end

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
    NSString *word = [[Tree getSharedInstance] getWordFromPattern:message[@"pattern"] andPredictionCount:(int)[message[@"predictionCount"] integerValue]];
    replyHandler(@{@"word":word});
}

@end
