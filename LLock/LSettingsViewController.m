//
//  LSettingsViewController.m
//  LLock
//
//  Created by Lana Shatonova on 18/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LSettingsViewController.h"
#import "LSettingsViewCell.h"

@interface LSettingsViewController ()

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
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
