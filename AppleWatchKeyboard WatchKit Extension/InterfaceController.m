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
#import "KBWordModel.h"

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

@interface InterfaceController() <TreeDelegate, WCSessionDelegate>
//@property (nonatomic, assign) NSInteger predictionCount; //count of finding iteraction. Example: ball - call
@property (nonatomic, strong) NSMutableArray *array; //vocabulary array with words
//@property (nonatomic, strong) NSString *predictedWord; //finding word. Example: he - hel - hell - hello
//@property (nonatomic, strong) NSString *buttonPattern; //number code for word. Example: 43556 (word "hello")
@property (nonatomic, strong) NSString *realText; //text visible for user in textLabel
@property (nonatomic, strong) NSMutableArray *wordModelsArray;

@property (nonatomic, assign) BOOL isCanWrite;
@property (nonatomic, strong) WCSession *session;

@end


@implementation InterfaceController

-(instancetype)init {
    self = [super init];
    if (self) {
        if ([WCSession isSupported]) {
            self.session = [WCSession defaultSession];
            self.session.delegate = self;
            [self.session activateSession];
        }
    }
    return self;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    
    self.wordModelsArray = [NSMutableArray array];
    KBWordModel *wordModel = [[KBWordModel alloc] initWithPredictionWord:@"" pattern:@"" count:0];
    [self.wordModelsArray addObject:wordModel];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self parseData];
        Tree *tree = [Tree getSharedInstance];
        for (NSString *string in self.array) {
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                [tree addString:string];
                if ([self.array.lastObject isEqual:string]) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        self.textLabel.text = @"";
                        self.isCanWrite = YES;
                    });
                }
            });
        
        }
        tree.delegate = self;
    });
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark -
#pragma mark Private Methods -

- (void)parseData {
    self.textLabel.text = @"Wait Please...";
    self.isCanWrite = NO;
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

- (void)reloadText {
    NSMutableArray *mutTextArray = [NSMutableArray array];
    for (KBWordModel *wordModel in self.wordModelsArray) {
        [mutTextArray addObject:[wordModel.predictedWord copy]];
    }
    self.realText = [mutTextArray componentsJoinedByString:@" "];
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
//    self.predictionCount = 0;
}

- (void)buttonPatternReset {
//    self.buttonPattern = @"";
//    self.predictionCount = 0;
//    self.predictedWord = @"";
}

#pragma mark -
#pragma mark Find word in Vocabulary -

- (void)signButtonPressedDecimalNumber:(NSInteger)number {
    if (!self.isCanWrite) {
        return;
    }
    KBWordModel *wordModel = [self.wordModelsArray lastObject];
    
    NSString *pattern = wordModel.buttonPattern;
    NSString *predictedWord = wordModel.predictedWord;
    NSInteger predictedCount = wordModel.predictionCount;
    
    //create word-code
    pattern = [pattern stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
    NSString *newWord = [[Tree getSharedInstance] getWordFromPattern:pattern andPredictionCount:predictedCount];
    //get true word by word-code and number of finding iteraction
    
    
    // if can find word
    if (![newWord isEqualToString:@"No Prediction"]) {
        predictedWord = newWord;
    }else {
        pattern = [pattern substringToIndex:(pattern.length - 2)];
    }
    
    wordModel.buttonPattern = pattern;
    wordModel.predictedWord = predictedWord;
    wordModel.predictionCount = predictedCount;
    [self reloadText];
}

#pragma mark -
#pragma mark Action Button -

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
    NSMutableArray *wordModelsArray = self.wordModelsArray;
    KBWordModel *wordModel = [wordModelsArray lastObject];
    
    switch (wordModel.predictedWord.length) {
        case 0:
            if (wordModelsArray.count > 1) {
                [wordModelsArray removeLastObject];
                [self reloadText];
                break;
            }
        case 1:
            wordModel.predictedWord = @"";
            wordModel.buttonPattern = @"";
            wordModel.predictionCount = 0;
            [self reloadText];
            break;
            
        default: {
            NSString *text = wordModel.buttonPattern;
            text = [text substringToIndex:(text.length-1)];
            NSInteger numberReWrite = [[text substringFromIndex:(text.length - 1)] integerValue];
            text = [text substringToIndex:(text.length-1)];
            
            wordModel.buttonPattern = text;
            [self signButtonPressedDecimalNumber:numberReWrite];
            break;
        }
    }
}


- (IBAction)spaseButtonPressed {
    KBWordModel *wordModel = [self.wordModelsArray lastObject];
    switch (wordModel.predictedWord.length) {
        case 0:
            break;
            
        default: {
            KBWordModel *wordModel = [[KBWordModel alloc] initWithPredictionWord:@"" pattern:@"" count:0];
            [self.wordModelsArray addObject:wordModel];
            break;
        }
    }
    [self reloadText];
}

- (IBAction)sendButtonPressed {
}

#pragma mark -
#pragma mark WCSessionDelegate -



@end



