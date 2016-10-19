//
//  LPinViewController.m
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPinViewController.h"
#import "LPinDotView.h"

static const NSInteger pinLength = 4;

@interface LPinViewController () <UITextFieldDelegate>

@property (nonatomic) LPinViewControllerType type;

@property (nonatomic) NSString *pin;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray<LPinDotView *> *pinDotView;

@property (nonatomic, strong) UILabel *notMatchLabel;

@end

@implementation LPinViewController

- (instancetype)initWithType:(LPinViewControllerType)type {
    self = [super init];
    if (!self) return nil;
    
    _type = type;
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_BLACK;
    
    // Navigation bar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = C_WHITE;
    
    UIButton *closeButton = [[UIButton alloc] initWithSize:size_square(23)];
    [closeButton setImage:[UIImage imageNamed:@"close_icon.PNG"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didPressCloseButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    // Label
    self.label = [[UILabel alloc] initCenterInSuperview:self.view size:s(self.view.width, 30)];
    self.label.y -= 100;
    self.label.backgroundColor = C_CLEAR;
    self.label.textColor = C_MAIN_WHITE;
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = [self labelText];
    
    // Textfield
    self.textField = [[UITextField alloc] initCenterInSuperview:self.view size:CGSizeZero];
    self.textField.hidden = YES;
    self.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    
    // Pin dots
    self.pinDotView = [NSMutableArray arrayWithCapacity:4];
    CGFloat between = 26;
    for (int i = 0; i < pinLength; i++) {
        [self.pinDotView addObject:[[LPinDotView alloc] initCenterInSuperview:self.view size:size_square([LPinDotView width])]];
        self.pinDotView[i].y = self.label.bottom + 30;
        self.pinDotView[i].x -= [LPinDotView width]*(0.5+1-i) + between*(0.5+1-i);
    }
    
    // Passcodes not match label
    self.notMatchLabel = [[UILabel alloc] initCenterInSuperview:self.view size:s(self.view.width, 30)];
    self.notMatchLabel.y = self.pinDotView[0].y + 50;
    self.notMatchLabel.backgroundColor = C_CLEAR;
    self.notMatchLabel.textColor = C_MAIN_WHITE;
    self.notMatchLabel.font = [UIFont systemFontOfSize:14];
    self.notMatchLabel.textAlignment = NSTextAlignmentCenter;
    self.notMatchLabel.text = @"Passcodes did not match. Try again.";
    self.notMatchLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didPressCloseButton {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setters

-(void)setType:(LPinViewControllerType)type {
    _type = type;
    
    self.label.text = [self labelText];
    self.textField.text = @"";
    for (LPinDotView *dot in self.pinDotView) {
        dot.entered = NO;
    }
    
    self.notMatchLabel.hidden = type != LPinViewControllerTypeSetup;
}
- (NSString *)labelText {
    
    switch (self.type) {
        case LPinViewControllerTypeSetup:
            return @"Enter your new passcode";
            break;
           
        case LPinViewControllerTypeConfirm:
            return @"Confirm your new passcode";
            
        default:
            return nil;
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int oldCount = (int)textField.text.length;
    int newCount = (int)[textField.text stringByReplacingCharactersInRange:range withString:string].length;
    
    if (newCount > oldCount) {
        // Add circle dot
        self.pinDotView[newCount-1].entered = YES;
        
        if (newCount == pinLength) {
            run_delayed(0.1f, ^{
                [self pinEntered:[textField.text stringByReplacingCharactersInRange:range withString:string]];
            });
            return NO;
        }
    }
    else {
        // Remove circle dot
        self.pinDotView[oldCount-1].entered = NO;
    }
    
    return YES;
}

- (void)pinEntered:(NSString *)pin {
    
    switch (self.type) {
            
        case LPinViewControllerTypeSetup: {
    
            // Switch to Confirm
            self.pin = pin;
            self.type = LPinViewControllerTypeConfirm;
        }
            break;
           
        case LPinViewControllerTypeConfirm: {
            
            // Check pin match
            if ([pin isEqualToString:self.pin]) {
                
                // Save pin
                SettingsManager.pinEnabled = YES;
                SettingsManager.pin = [self.pin integerValue];
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                // Return to Setup
                self.pin = nil;
                self.type = LPinViewControllerTypeSetup;
            }
        }
            break;
            
            
        default:
            break;
    }
}

@end
