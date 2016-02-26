//
//  InterfaceController.m
//  AppleWatchKeyboard WatchKit Extension
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "InterfaceController.h"
#import "Tree.h"
#import "FileReader.h"

typedef enum {
    KBSignDecimalABC = 2,
    KBSignDecimalDEF = 3,
    KBSignDecimalGHI = 4,
    KBSignDecimalJKL = 5,
    KBSignDecimalMNO = 6,
    KBSignDecimalPQRS = 7,
    KBSignDecimalTUV = 8,
    KBSignDecimalWXYZ = 9
} KBSignDecimal;

@interface InterfaceController() <TreeDelegate>
@property (nonatomic, assign) NSInteger predictionCount;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSString *predictedWord;
@property (nonatomic, strong) NSString *buttonPattern;
@property (nonatomic, strong) NSString *realText;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    
        self.predictedWord = [[NSString alloc]init];
        self.buttonPattern = [[NSString alloc]init];
        self.predictionCount = 0;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [self parseData];
            Tree *tree = [Tree getSharedInstance];
            for (NSString *string in self.array) {
                [tree addString:string];
            }
            tree.delegate = self;
    });
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark -
#pragma mark Private Methods -

- (void)parseData {
    
        self.array = [NSMutableArray array];
        NSString* filePath = @"TopT9Words";//file path...
        NSString* fileRoot = [[NSBundle mainBundle]
                              pathForResource:filePath ofType:@"txt"];
        FileReader * reader = [[FileReader alloc] initWithFilePath:fileRoot];
        __block NSString * line = nil;
    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    while ((line = [reader readLine])) {
            line = [line stringByReplacingOccurrencesOfString:@" "
                                                   withString:@""];
            NSMutableArray *lineArray = (NSMutableArray *)[line componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            self.array = lineArray;
        }
//    });
}

#pragma mark -
#pragma mark Setters -

- (void)setRealText:(NSString *)realText {
    _realText = realText;
    [self.textLabel setText:realText];
}

#pragma mark -
#pragma mark TreeDelegate -

- (void)predictionCountReset {
    self.predictionCount = 0;
}

- (void)buttonPatternReset {
    self.buttonPattern = @"";
    self.predictionCount = 0;
    self.predictedWord = @"";
}

#pragma mark -
#pragma mark Action Button -

- (void)signButtonPressedDecimalNumber:(NSInteger)number {
    self.buttonPattern = [self.buttonPattern stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
    self.predictedWord = [mTree getWordFromPattern:self.buttonPattern andPredictionCount:self.predictionCount];
    if ([self.predictedWord isEqualToString:@""]) {
        self.realText = @" ";
    }
    self.textLabel.text = self.predictedWord;
    if (self.buttonPattern.length == 0) {
        self.predictedWord = @"";
        self.realText = @" ";
    }
    //if (predictionCount == 0) {
    self.realText = self.predictedWord;
    // }
}

- (IBAction)punctuationButtonPressed {
    
}
- (IBAction)abcButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalABC];
}
- (IBAction)defButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalDEF];
}
- (IBAction)ghiButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalGHI];
}
- (IBAction)jklButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalJKL];
}
- (IBAction)mnoButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalMNO];
}
- (IBAction)pqrsButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalPQRS];
}
- (IBAction)tuvButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalTUV];
}
- (IBAction)wxyzButtonPressed {
    [self signButtonPressedDecimalNumber:KBSignDecimalWXYZ];
}


- (IBAction)backSpaceButtonPressed {
    NSString *text = self.realText;
    self.realText = [text substringToIndex:(text.length-2)];
}

- (IBAction)spaseButtonPressed {
}

- (IBAction)sendButtonPressed {
}

@end



