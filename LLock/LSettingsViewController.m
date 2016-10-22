//
//  LSettingsViewController.m
//  LLock
//
//  Created by Lana Shatonova on 18/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LSettingsViewController.h"
#import "LSettingsViewCell.h"
#import "LPinViewController.h"

@interface LSettingsViewController () <LSettingsViewCellDelegate>

@property (nonatomic) UIAlertController *pinChangeActionSheet;
@end

@implementation LSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Navigation bar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = C_WHITE;

    UIButton *closeButton = [[UIButton alloc] initWithSize:size_square(23)];
    [closeButton setImage:[UIImage imageNamed:@"close_icon.PNG"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didPressCloseButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    // Table view
    self.tableView.backgroundColor = C_BLACK;
    self.tableView.separatorColor = C_DARK_GRAY;
    [self.tableView registerClass:[LSettingsViewCell class] forCellReuseIdentifier:[LSettingsViewCell reuseIdentifier]];
    self.tableView.rowHeight = [LSettingsViewCell rowHeight];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // Pin change alert controller
    self.pinChangeActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *changeAction = [UIAlertAction actionWithTitle:@"Change Passcode" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPinViewControllerWithType:LPinViewControllerTypeChange];
    }];
    [self.pinChangeActionSheet addAction:changeAction];
    UIAlertAction *disableAction = [UIAlertAction actionWithTitle:@"Disable Passcode" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPinViewControllerWithType:LPinViewControllerTypeDisable];
    }];
    [self.pinChangeActionSheet addAction:disableAction];
    [self.pinChangeActionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.tableView reloadData];
    }]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (PinEntryManager.alertControllerToReopen != self.pinChangeActionSheet) {
        [self.tableView reloadData];
    }
}

- (void)didPressCloseButton {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSettingsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LSettingsViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.type = indexPath.row == 0 ? LSettingsViewCellTypePIN : LSettingsViewCellTypeTouchID;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - LSettingsViewCellDelegate

- (void)settingsViewCell:(LSettingsViewCell *)cell didChangeSwitch:(BOOL)on {
    
    if (cell.type == LSettingsViewCellTypePIN){
        
        if (on) {
            // Enable PIN
            // Open PIN setup screen
            [self openPinViewControllerWithType:LPinViewControllerTypeSetup];
        }
        else {
            // Disable or change PIN
            // Open alert view controller
            [self presentViewController:self.pinChangeActionSheet animated:YES completion:nil];
        }
        
    } else {
        
        if (on) {
            // Enable Touch ID
            // Check if passcode was setup
            if (SettingsManager.pinEnabled) {
                
                // Check if Touch ID is available
                if (SettingsManager.touchIDAvailable) {
                    // Enable
                    SettingsManager.touchIDEnabled = YES;
                }
                else {
                    // Show avalability error
                    UIAlertController *errorVC = [UIAlertController alertControllerWithTitle:@"Touch ID" message:@"Touch ID is not available." preferredStyle:UIAlertControllerStyleAlert];
                    [errorVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController:errorVC animated:YES completion:^{
                        [self.tableView reloadData];
                    }];
                }
            } else {
                // Show pin disabled error
                UIAlertController *errorVC = [UIAlertController alertControllerWithTitle:@"Touch ID" message:@"Enable passcode first." preferredStyle:UIAlertControllerStyleAlert];
                [errorVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:errorVC animated:YES completion:^{
                    [self.tableView reloadData];
                }];
            }
        }
        else {
            // Disable Touch ID
            SettingsManager.touchIDEnabled = NO;
        }
    }
}

- (void)openPinViewControllerWithType:(LPinViewControllerType)type {
    
    LPinViewController *vc = [[LPinViewController alloc] initWithType:type];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

@end
