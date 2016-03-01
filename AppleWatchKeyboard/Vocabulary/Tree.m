//
//  Tree.m
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "Tree.h"

static Tree *instance;

@implementation Tree

- (id)init
{
    if (self = [super init]) {
        self.root = nil;
        self.map = [NSMutableDictionary dictionary];
        [self makeLookUpDictionary];
        return self;
    }
    return nil;
}

+ (Tree *)getSharedInstance;
{
    @synchronized([Tree class])
    {
        if (instance == nil) {
            instance = [[Tree alloc]init];
        }
    }
    return instance;
}

- (void)makeLookUpDictionary
{
    [self.map setValue:@"2" forKey:@"a"];
    [self.map setValue:@"2" forKey:@"b"];
    [self.map setValue:@"2" forKey:@"c"];
    [self.map setValue:@"3" forKey:@"d"];
    [self.map setValue:@"3" forKey:@"e"];
    [self.map setValue:@"3" forKey:@"f"];
    [self.map setValue:@"4" forKey:@"g"];
    [self.map setValue:@"4" forKey:@"h"];
    [self.map setValue:@"4" forKey:@"i"];
    [self.map setValue:@"5" forKey:@"j"];
    [self.map setValue:@"5" forKey:@"k"];
    [self.map setValue:@"5" forKey:@"l"];
    [self.map setValue:@"6" forKey:@"m"];
    [self.map setValue:@"6" forKey:@"n"];
    [self.map setValue:@"6" forKey:@"o"];
    [self.map setValue:@"7" forKey:@"p"];
    [self.map setValue:@"7" forKey:@"q"];
    [self.map setValue:@"7" forKey:@"r"];
    [self.map setValue:@"7" forKey:@"s"];
    [self.map setValue:@"8" forKey:@"t"];
    [self.map setValue:@"8" forKey:@"u"];
    [self.map setValue:@"8" forKey:@"v"];
    [self.map setValue:@"9" forKey:@"w"];
    [self.map setValue:@"9" forKey:@"x"];
    [self.map setValue:@"9" forKey:@"y"];
    [self.map setValue:@"9" forKey:@"z"];
}

- (int )getValueForKey:(NSString *)key
{
    return [[self.map objectForKey:key]intValue];
}

- (NSString *)getWordFromPattern:(NSString *)pattern andPredictionCount:(int)predictionCount
{
    NSString *word = nil;
    Node *node = self.root;
    int i = 0;
    int num = 0;
    while (i < pattern.length) {
        if (node == nil) {
            //i++;
            [self.delegate buttonPatternReset];
            return @"No Prediction";
        }
        NSString *key = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
        num = [key intValue];
        if (num == node.value) {
            i++;
            if (i == pattern.length) {
                if (predictionCount < [node.linkedList count]) {
                    word = [node.linkedList objectAtIndex:predictionCount];
                }
                else
                {
                   if (predictionCount != 0 )
                    {
                        [self.delegate predictionCountReset];
                        word = [node.linkedList objectAtIndex:0];
                    }
                    else
                    {
                        [self.delegate buttonPatternReset];
                        return @"No Prediction";
                    }
                }
                
            }
            node = node.middle;
        }
        else if (num < node.value)
        {
            if (i == pattern.length) {
                if (predictionCount < [node.linkedList count]) {
                    word = [node.linkedList objectAtIndex:predictionCount];
                }
                else
                {
                    if (predictionCount != 0 )
                    {
                        [self.delegate predictionCountReset];
                        word = [node.linkedList objectAtIndex:0];
                    }
                    else
                    {
                        [self.delegate buttonPatternReset];
                        return @"No Prediction";
                    }
                }
            }
            node = node.left;
        }
        else
        {
            if (i == pattern.length) {
                if (predictionCount < [node.linkedList count]) {
                    word = [node.linkedList objectAtIndex:predictionCount];
                }
                else
                {
                    if (predictionCount != 0 )
                    {
                        [self.delegate predictionCountReset];
                        word = [node.linkedList objectAtIndex:0];
                    }
                    else
                    {
                        [self.delegate buttonPatternReset];
                        return @"No Prediction";
                    }
                }
            }
            node = node.right;
        }
        
    }
    return word;
}

- (void)addString:(NSString *)word
{
    if (word.length > 0) {
        word = [word lowercaseString];
        if (!self.root) {
            NSString *key = [NSString stringWithFormat:@"%c", [word characterAtIndex:0]];
            int value = [self getValueForKey:key];
            self.root = [[Node alloc]initWithValue:value];
            Node *node = self.root;
            Node *temp = nil;
            
            for (int i = 1; i < word.length; i++) {
                NSString *tempKey = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
                int tempVal = [self getValueForKey:tempKey];
                temp = [[Node alloc]initWithValue:tempVal];
                node.middle = temp;
                node = temp;
                if (i == word.length - 1) {
                    [temp setString:word];
                }
            }
        }
        else{
            Node *node = self.root;
            int i = 0;
            Node *temp = nil;
            int value = 0;
            while (i < word.length) {
                NSString *key = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
                int value = [self getValueForKey:key];
                if (node.value == value) {
                    if (i == word.length - 1) {
                        [node setString:word];
                        i++;
                    }
                    else
                    {
                        i++;
                        if (!node.middle) {
                            while (i < word.length) {
                                NSString *key = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
                                int value = [self getValueForKey:key];
                                temp = [[Node alloc]initWithValue:value];
                                node.middle = temp;
                                node = temp;
                                if (i == word.length - 1) {
                                    [temp setString:word];
                                }
                                i++;
                            }
                        }
                        //node.middle not nil
                        else
                        {
                            node = node.middle;
                        }
                    }
                }
                // node.value not equal to value
                else if (value < node.value)
                {
                    if (!node.left) {
                        temp = [[Node alloc]initWithValue:value];
                        node.left = temp;
                        node = temp;
                        if (i == word.length - 1) {
                            [temp setString:word];
                        }
                        else
                        {
                            i++;
                            while (i < word.length) {
                                NSString *key = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
                                int value = [self getValueForKey:key];
                                temp = [[Node alloc]initWithValue:value];
                                node.middle = temp;
                                node = temp;
                                if (i == word.length - 1) {
                                    [temp setString:word];
                                }
                                i++;
                            }
                        }
                        }else {
                            node = node.left;
                        }
                    }
                    else{
                        if (!node.right) {
                            temp = [[Node alloc]initWithValue:value];
                            node.right = temp;
                            node = temp;
                            if (i == word.length - 1) {
                                [temp setString:word];
                            }
                            else
                            {
                                i++;
                                while (i < word.length) {
                                    NSString *key = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
                                    int value = [self getValueForKey:key];
                                    temp = [[Node alloc]initWithValue:value];
                                    node.middle = temp;
                                    node = temp;
                                    if (i == word.length - 1) {
                                        [temp setString:word];
                                    }
                                    i++;
                                }
                            }
                        }
                        else{
                            node = node.right;
                        }
                    }
                }
            }
        }
    }



@end
