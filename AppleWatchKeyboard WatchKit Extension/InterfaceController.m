//
//  InterfaceController.m
//  AppleWatchKeyboard WatchKit Extension
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "InterfaceController.h"
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

@interface InterfaceController() <WCSessionDelegate>
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
            WCSession *session = [WCSession defaultSession];
            session.delegate = self;
            [session activateSession];
            self.session = session;
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
    dispatch_async(dispatch_get_main_queue(), ^(void){
        _realText = realText;
        [self.textLabel setText:realText];
    });
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
    KBWordModel *wordModel = [self.wordModelsArray lastObject];
    
    __block NSString *pattern = wordModel.buttonPattern;
    __block NSString *predictedWord = wordModel.predictedWord;
    NSInteger predictedCount = wordModel.predictionCount;
    
    //create word-code
    pattern = [pattern stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
    
    NSDictionary *dictionaryMessage = @{@"pattern":pattern, @"predictionCount":@(predictedCount)};
    
    [self.session sendMessage:dictionaryMessage
                 replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
                     NSString *newWord = replyMessage[@"word"];
                     
                     if (![newWord isEqualToString:@"No Prediction"]) {
                         predictedWord = newWord;
                     }else {
                         pattern = [pattern substringToIndex:(pattern.length - 2)];
                     }
                     
                     wordModel.buttonPattern = pattern;
                     wordModel.predictedWord = predictedWord;
                     wordModel.predictionCount = predictedCount;
                     [self reloadText];
                     
                 } errorHandler:^(NSError * _Nonnull error) {
                     [self.textLabel setText:@"ERROR!!"];
                 }];
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



