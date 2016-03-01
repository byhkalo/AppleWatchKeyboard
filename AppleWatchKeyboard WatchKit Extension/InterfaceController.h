//
//  InterfaceController.h
//  AppleWatchKeyboard WatchKit Extension
//
//  Created by Byhkalo Konstantyn on 26.02.16.
//  Copyright © 2016 Anadea. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *textLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *punctuationButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *abcButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *defButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *ghiButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *jklButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *mnoButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *pqrsButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *tuvButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *wxyzButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *backSpaceButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *spaceButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *sendButton;

//Sign ButtonPressed
- (IBAction)punctuationButtonPressed;
- (IBAction)abcButtonPressed;
- (IBAction)defButtonPressed;
- (IBAction)ghiButtonPressed;
- (IBAction)jklButtonPressed;
- (IBAction)mnoButtonPressed;
- (IBAction)pqrsButtonPressed;
- (IBAction)tuvButtonPressed;
- (IBAction)wxyzButtonPressed;

- (IBAction)backSpaceButtonPressed;
- (IBAction)spaseButtonPressed;
- (IBAction)sendButtonPressed;

@end
