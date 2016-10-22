//
//  LFolderTableViewController.m
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolderTableViewController.h"
#import "LFolderTableViewCell.h"
#import "LPhotoGridViewController.h"
#import "LSettingsViewController.h"
#import "LPinViewController.h"

@interface LFolderTableViewController () <UITextFieldDelegate, NSFetchedResultsControllerDelegate, LFolderTableViewCellDelegate>

@property (nonatomic, strong) NSFetchedResultsController *folders;
@property (nonatomic, strong) UIAlertController *addFolderAlertController;
@property (nonatomic, strong) UIAlertController *deleteFolderAlertController;

@property (nonatomic, strong) LFolderTableViewCell *cellWithDeleteButtonShown;

@end

@implementation LFolderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_BLACK;
    
    // Navigation bar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = C_WHITE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Navigation bar: add photo button
    UIBarButtonItem *addFolderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddFolderButton)];
    addFolderButton.tintColor = C_WHITE;
    self.navigationItem.leftBarButtonItem = addFolderButton;
    
    // Navigation bar: settings button
    UIButton *settingsButton = [[UIButton alloc] initWithSize:s(14,20)];
    [settingsButton setImage:[UIImage imageNamed:@"lock_icon.PNG"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(didPressSettingsButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    // Add folder alert controller
    self.addFolderAlertController = [UIAlertController alertControllerWithTitle:@"New Folder" message:@"Enter a name for this folder." preferredStyle:UIAlertControllerStyleAlert];
    
    [self.addFolderAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        textField.placeholder = @"Name";
    }];
    self.addFolderAlertController.textFields[0].delegate = self;
    
    [self.addFolderAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self resetAddFolderAlertController];
    }]];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Save folder
        [PhotoManager createFolderWithName:self.addFolderAlertController.textFields[0].text];
        [self resetAddFolderAlertController];
    }];
    saveAction.enabled = NO;
    [self.addFolderAlertController addAction:saveAction];
    
    // Delete folder alert controller
    self.deleteFolderAlertController = [UIAlertController alertControllerWithTitle:@"Delete Folder" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [self.deleteFolderAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Hide delete button
        [self hideDeleteFolderButton];
        
    }]];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteFolder];
    }];
    [self.deleteFolderAlertController addAction:deleteAction];
    
    // Table view
    self.tableView.backgroundColor = C_CLEAR;
    self.tableView.separatorColor = C_DARK_GRAY;
    [self.tableView registerClass:[LFolderTableViewCell class] forCellReuseIdentifier:[LFolderTableViewCell reuseIdentifier]];
    self.tableView.rowHeight = [LFolderTableViewCell rowHeight];
    self.tableView.contentInset = inset_bottom(20);
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // Frc
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[LFolder class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:NO];
    self.folders = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:DataContext sectionNameKeyPath:nil cacheName:nil];
    [self.folders performFetch];
    self.folders.delegate = self;
}

#pragma mark - Add/Delete Folder

- (void)didPressAddFolderButton {
    // Show add folder alert controller
    [self presentViewController:self.addFolderAlertController animated:YES completion:nil];
}

- (void)hideDeleteFolderButton {
    
    if (self.cellWithDeleteButtonShown) {
        self.cellWithDeleteButtonShown.showDeleteButton = NO;
        self.cellWithDeleteButtonShown = nil;
    }
}

- (void)resetAddFolderAlertController {
    
    self.addFolderAlertController.message = @"Enter a name for this folder.";
    self.addFolderAlertController.textFields[0].text = nil;
    self.addFolderAlertController.actions[1].enabled = NO;
}

- (void)deleteFolder {
    
    [self.cellWithDeleteButtonShown.folder destroy];
    [self hideDeleteFolderButton];
    [DataStore save];
}


#pragma mark - Settings

- (void)didPressSettingsButton {
    LSettingsViewController *vc = [[LSettingsViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folders.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFolderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[LFolderTableViewCell reuseIdentifier]];
    cell.folder = [self.folders objectAtIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Hide delete button
    [self hideDeleteFolderButton];
    
    // Open photo grid view controller
    LPhotoGridViewController *photoVC = [[LPhotoGridViewController alloc] initWithFolder:[self.folders objectAtIndexPath:indexPath]];
    [self.navigationController pushViewController:photoVC animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide delete button
    [self hideDeleteFolderButton];
}

#pragma mark - LFolderTableViewCellDelegate

- (void)LFolderTableViewCell:(LFolderTableViewCell *)cell didSetShowDeleteButton:(BOOL)showing {
    
    if (showing) {
        // Hide previously shown Delete button
        [self hideDeleteFolderButton];
        
        self.cellWithDeleteButtonShown = cell;
    }
    else {
        self.cellWithDeleteButtonShown = nil;
    }
}

- (void)LFolderTableViewCell:(LFolderTableViewCell *)cell didPressDeleteButton:(UIButton *)button {
    // Show delete folder alert controller
    self.deleteFolderAlertController.message = string(@"Are you sure you want to delete folder '%@' and all the photos in it?", cell.folder.name);
    [self presentViewController:self.deleteFolderAlertController animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.addFolderAlertController.actions[1].enabled = ![textField.text stringByReplacingCharactersInRange:range withString:string].isEmpty;
    
    return YES;
}

@end
