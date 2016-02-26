//
//  InterfaceController.m
//  AppleWatchKeyboard WatchKit Extension
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
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



