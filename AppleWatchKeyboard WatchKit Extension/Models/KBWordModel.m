//
//  KBWordModel.m
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "KBWordModel.h"

@implementation KBWordModel

- (instancetype)initWithPredictionWord:(NSString *)word pattern:(NSString *)pattern count:(NSInteger)count {
    
    if (self = [super init]) {
        self.predictedWord = word;
        self.buttonPattern = pattern;
        self.predictionCount = count;
    }
    
    return self;
}

@end
