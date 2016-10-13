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

@interface LFolderTableViewController () <UITextFieldDelegate, NSFetchedResultsControllerDelegate, LFolderTableViewCellDelegate>

@property (nonatomic, strong) NSFetchedResultsController *folders;
@property (nonatomic, strong) UIAlertController *addFolderAlertController;
@property (nonatomic, strong) UIAlertController *deleteFolderAlertController;

@property (nonatomic, strong) LFolderTableViewCell *cellWithDeleteButtonShown;

@end

@implementation LFolderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar
//    self.navigationItem.title = [@"Folders" uppercaseString];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Navigation bar: add photo button
    UIBarButtonItem *addFolderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddFolderButton)];
    addFolderButton.tintColor = C_WHITE;
    self.navigationItem.rightBarButtonItem = addFolderButton;
    
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
        [self addFolder];
    }];
    saveAction.enabled = NO;
    [self.addFolderAlertController addAction:saveAction];
    
    // Delete folder alert controller
    self.deleteFolderAlertController = [UIAlertController alertControllerWithTitle:@"Delete Folder" message:@"Are you sure you want to delete this folder and all the photos in it?" preferredStyle:UIAlertControllerStyleAlert];
    
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
    
    // Frc
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[LFolder class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.folders = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:DataContext sectionNameKeyPath:nil cacheName:nil];
    [self.folders performFetch];
    self.folders.delegate = self;
}

#pragma mark - Actions

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

- (void)addFolder {
    
    NSString *folderName = self.addFolderAlertController.textFields[0].text;
    
    if (![LFolder firstWithKey:@"name" value:folderName]) {
        
        // Save the folder
        LFolder *newFolder = [LFolder createInContext:DataContext];
        newFolder.name = folderName;
        [DataStore save];
        
        [self resetAddFolderAlertController];
    }
    else {
        self.addFolderAlertController.message = @"Folder with this name already exists! Enter another name.";
        self.addFolderAlertController.actions[1].enabled = NO;
        [self presentViewController:self.addFolderAlertController animated:YES completion:nil];
    }
}

- (void)resetAddFolderAlertController {
    
    self.addFolderAlertController.message = @"Enter a name for this folder.";
    self.addFolderAlertController.textFields[0].text = nil;
    self.addFolderAlertController.actions[1].enabled = NO;
}

- (void)deleteFolder {
    
    LFolder *folder = [LFolder firstWithKey:@"name" value:self.cellWithDeleteButtonShown.folderName];
    [self hideDeleteFolderButton];
    [folder destroy];
    [DataStore save];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folders.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFolderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[LFolderTableViewCell reuseIdentifier]];
    cell.delegate = self;
    
    LFolder *folder = [self.folders objectAtIndexPath:indexPath];
    cell.folderName = folder.name;
    cell.photoCount = folder.photos.count;
    
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
    [self presentViewController:self.deleteFolderAlertController animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.addFolderAlertController.actions[1].enabled = ![textField.text stringByReplacingCharactersInRange:range withString:string].isEmpty;
    
    return YES;
}

@end
