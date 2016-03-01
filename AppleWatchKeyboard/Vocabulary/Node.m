//
//  Node.m
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "Node.h"

@implementation Node

- (id)initWithValue:(int)value
{
    self = [super init];
    self.value = value;
    self.linkedList = [NSMutableArray array];
    return self;
}

- (void)setString:(NSString *)s
{
    [self.linkedList addObject:s];
}

- (NSString *)getStringValueOfVal
{
    return [NSString stringWithFormat:@"%d",self.value];
}

@end
