//
//  Node.h
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic,strong) Node *left;
@property (nonatomic,strong) Node *middle;
@property (nonatomic,strong) Node *right;
@property (nonatomic,assign) int value;
@property (nonatomic,strong) NSMutableArray *linkedList;

- (id)initWithValue:(int)value;
- (void)setString:(NSString *)s;
- (NSString *)getStringValueOfVal;

@end
