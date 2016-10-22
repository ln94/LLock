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

@property (nonatomic) NSInteger pin;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray<LPinDotView *> *pinDotView;

@property (nonatomic, strong) UILabel *errorLabel;

@property (nonatomic) BOOL isTouchIDAsked;

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
    self.titleLabel = [[UILabel alloc] initCenterInSuperview:self.view size:s(self.view.width, 30)];
    self.titleLabel.y -= 100;
    self.titleLabel.backgroundColor = C_CLEAR;
    self.titleLabel.textColor = C_MAIN;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = [self titleLabelText];
    
    // Textfield
    self.textField = [[UITextField alloc] initCenterInSuperview:self.view size:CGSizeZero];
    self.textField.hidden = YES;
    self.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    
    // Pin dots
    self.pinDotView = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < pinLength; i++) {
        [self.pinDotView addObject:[[LPinDotView alloc] initCenterInSuperview:self.view size:size_square([LPinDotView width])]];
        self.pinDotView[i].y = self.titleLabel.bottom + 30;
        self.pinDotView[i].x -= [LPinDotView width]*(0.5+1-i) + [LPinDotView between]*(0.5+1-i);
    }
    
    // Passcodes not match label
    self.errorLabel = [[UILabel alloc] initCenterInSuperview:self.view size:s(self.view.width, 30)];
    self.errorLabel.y = self.pinDotView[0].y + 50;
    self.errorLabel.backgroundColor = C_CLEAR;
    self.errorLabel.textColor = C_SECONDARY;
    self.errorLabel.font = [UIFont systemFontOfSize:14.5];
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self isEnterType] && [PinEntryManager willDisplayTouchIDAlert]) {
        // If Pin entry screen is presented and Touch ID alert will also be displayed, hide keyboard
        [self hideKeyboard];
    }
    else {
        // Open keyboard for every other type of Pin screen
        [self showKeyboard];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didPressCloseButton {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard

- (void)showKeyboard {
    [self.textField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.textField resignFirstResponder];
}

#pragma mark - Type

- (BOOL)isEnterType {
    return self.type == LPinViewControllerTypeEnter;
}

- (void)setType:(LPinViewControllerType)type {
    
    // Process error if it happened
    [self processErrorForNewType:type fromOldType:self.type];
    
    _type = type;
    
    // Reset UI
    self.titleLabel.text = [self titleLabelText];
    self.textField.text = @"";
    for (LPinDotView *dot in self.pinDotView) {
        dot.entered = NO;
    }
}

#pragma mark - Text for labels

- (NSString *)titleLabelText {
    
    switch (self.type) {
        case LPinViewControllerTypeSetup:
            return @"Enter your new passcode";
           
        case LPinViewControllerTypeConfirm:
            return @"Confirm your new passcode";
           
        case LPinViewControllerTypeChange:
        case LPinViewControllerTypeDisable:
            return @"Enter your old passcode";
            
        case LPinViewControllerTypeEnter:
            return @"Enter passcode";
            
        default:
            return nil;
    }
}

- (void)processErrorForNewType:(LPinViewControllerType)newType fromOldType:(LPinViewControllerType)oldType {
    
    if (newType == LPinViewControllerTypeSetup && oldType == LPinViewControllerTypeConfirm) {
        self.errorLabel.text = @"Passcodes did not match. Try again.";
        self.errorLabel.hidden = NO;
    }
    else if ((newType == LPinViewControllerTypeChange && oldType == LPinViewControllerTypeChange)
             || (newType == LPinViewControllerTypeDisable && oldType == LPinViewControllerTypeDisable)
             || (newType == LPinViewControllerTypeEnter && oldType == LPinViewControllerTypeEnter)) {
        self.errorLabel.text = @"Incorrect passcode. Try again.";
        self.errorLabel.hidden = NO;
    }
    else {
        self.errorLabel.hidden = YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    __block NSString *pinString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    int oldCount = (int)textField.text.length;
    int newCount = (int)[textField.text stringByReplacingCharactersInRange:range withString:string].length;
    
    if (textField.text.length == pinLength) {
        // If all the pin digits are already entered, do nothing
        return NO;
    }
    
    if (newCount > oldCount) {
        // Add circle dot
        self.pinDotView[newCount-1].entered = YES;
        
        if (newCount == pinLength) {
            run_delayed(0.1f, ^{
                [self pinEntered:[pinString integerValue]];
            });
        }
    }
    else {
        // Remove circle dot
        self.pinDotView[oldCount-1].entered = NO;
    }
    
    return YES;
}

- (void)pinEntered:(NSInteger)pin {
    
    switch (self.type) {
            
        case LPinViewControllerTypeSetup: {
    
            // Switch to Confirm
            self.pin = pin;
            self.type = LPinViewControllerTypeConfirm;
        }
            break;
           
        case LPinViewControllerTypeConfirm: {
            
            // Check pin match
            if (pin == self.pin) {
                
                // Save pin
                SettingsManager.pinEnabled = YES;
                SettingsManager.pin = self.pin;
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                // Return to Setup
                self.pin = -1;
                self.type = LPinViewControllerTypeSetup;
            }
        }
            break;
            
        case LPinViewControllerTypeChange: {
            
            // Check if old pin was entered correctly
            if (pin == SettingsManager.pin) {
                
                // Setup new pin
                self.type = LPinViewControllerTypeSetup;
            }
            else {
                // Show error
                self.type = LPinViewControllerTypeChange;
            }
        }
            break;
            
        case LPinViewControllerTypeDisable: {
            
            // Check if old pin was entered correctly
            if (pin == SettingsManager.pin) {
                
                // Disable pin and Touch ID
                SettingsManager.pinEnabled = NO;
                SettingsManager.pin = -1;
                SettingsManager.touchIDEnabled = NO;
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                // Show error
                self.type = LPinViewControllerTypeDisable;
            }
        }
            break;
            
        case LPinViewControllerTypeEnter: {
            
            // Check if pin was entered correctly
            if (pin == SettingsManager.pin) {
                
                // Grant access
                [PinEntryManager handleSuccessfulPinEntry];
            }
            else {
                // Show error
                self.type = LPinViewControllerTypeEnter;
            }
        }
            break;
            
        default:
            break;
    }
}

@end
