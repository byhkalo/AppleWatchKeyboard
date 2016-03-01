//
//  Tree.h
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

#define mTree ((Tree*)[Tree getSharedInstance])

@protocol TreeDelegate <NSObject>

- (void)predictionCountReset;
- (void)buttonPatternReset;

@end

@interface Tree : NSObject

@property (nonatomic,strong) Node *root;
@property (nonatomic,strong) NSMutableDictionary *map;
@property (nonatomic,assign) id <TreeDelegate>delegate;


+ (Tree *)getSharedInstance;
- (int )getValueForKey:(NSString *)key;
- (void)addString:(NSString *)s;
- (NSString *)getWordFromPattern:(NSString *)pattern andPredictionCount:(int)predictionCount;

@end
