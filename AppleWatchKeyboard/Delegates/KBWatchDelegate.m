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

- (void)sessionReachabilityDidChange:(WCSession *)session {
    NSLog(@"sessionReachabilityDidChange");
}

/** Called on the delegate of the receiver. Will be called on startup if the incoming message caused the receiver to launch. */
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSLog(@"didReceiveMessage");
}

/** Called on the delegate of the receiver when the sender sends a message that expects a reply. Will be called on startup if the incoming message caused the receiver to launch. */
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
//    replyHandler(nil);
    NSLog(@"didReceiveMessagereplyHandler");
}

/** Called on the delegate of the receiver. Will be called on startup if the incoming message data caused the receiver to launch. */
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData {
    NSLog(@"didReceiveMessageData");
}

/** Called on the delegate of the receiver when the sender sends message data that expects a reply. Will be called on startup if the incoming message data caused the receiver to launch. */
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler {
//    replyHandler(nil);
    NSLog(@"didReceiveMessageDatareplyHandler");
}


- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext {
    NSLog(@"didReceiveApplicationContext");
}

/** Called on the sending side after the user info transfer has successfully completed or failed with an error. Will be called on next launch if the sender was not running when the user info finished. */
- (void)session:(WCSession * __nonnull)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer *)userInfoTransfer error:(nullable NSError *)error {
    NSLog(@"didFinishUserInfoTransfer");
}

/** Called on the delegate of the receiver. Will be called on startup if the user info finished transferring when the receiver was not running. */
- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo {
    NSLog(@"didReceiveUserInfo");
}

/** Called on the sending side after the file transfer has successfully completed or failed with an error. Will be called on next launch if the sender was not running when the transfer finished. */
- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error {
    NSLog(@"didFinishFileTransfer");
}

/** Called on the delegate of the receiver. Will be called on startup if the file finished transferring when the receiver was not running. The incoming file will be located in the Documents/Inbox/ folder when being delivered. The receiver must take ownership of the file by moving it to another location. The system will remove any content that has not been moved when this delegate method returns. */
- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file {
     NSLog(@"didReceiveFile");
}

@end
