//
//  KBWordModel.h
//  AppleWatchKeyboard
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBWordModel : NSObject
@property (nonatomic, strong) NSString      *predictedWord;
@property (nonatomic, strong) NSString      *buttonPattern;
@property (nonatomic, assign) NSUInteger    predictionCount;

- (instancetype)initWithPredictionWord:(NSString *)word pattern:(NSString *)pattern count:(NSInteger)count;

@end
