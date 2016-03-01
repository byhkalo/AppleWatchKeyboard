//
//  KBWatchDelegate.h
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 01.03.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface KBWatchDelegate : NSObject <WCSessionDelegate>

- (instancetype)initWithSession:(WCSession*)session;

@end
