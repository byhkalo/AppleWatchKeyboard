//
//  AppDelegate.m
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "AppDelegate.h"
#import "KBWatchDelegate.h"
#import "Tree.h"
#import "FileReader.h"

@interface AppDelegate () <WCSessionDelegate>
@property (nonatomic, strong) KBWatchDelegate *watchDelegate;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadVocabulary];
    self.watchDelegate = [[KBWatchDelegate alloc] initWithSession:[WCSession defaultSession]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loadVocabulary {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self parseData];
        Tree *tree = [Tree getSharedInstance];
        for (NSString *string in self.array) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                [tree addString:string];
                if ([self.array.lastObject isEqual:string]) {
                }
            });
        }
//        tree.delegate = self;
    });
}

- (void)parseData {
    self.array = [NSMutableArray array];
    NSString* filePath = @"TopT9Words";//file path...
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    FileReader * reader = [[FileReader alloc] initWithFilePath:fileRoot];
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [line stringByReplacingOccurrencesOfString:@" "
                                               withString:@""];
        NSMutableArray *lineArray = (NSMutableArray *)[line componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        self.array = lineArray;
    }
}


@end
