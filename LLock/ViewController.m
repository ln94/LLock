//
//  ViewController.m
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "ViewController.h"
#import "LFolderTableViewCell.h"
#import "LPhotoCollectionViewController.h"

@interface ViewController () <UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *folders;
@property (nonatomic, strong) UIAlertController *addFolderAlertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar: title
    self.navigationItem.title = [@"All Folders" uppercaseString];
    
    // Navigation bar: add photo button
    UIBarButtonItem *addFolderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddFolderButton)];
    addFolderButton.tintColor = C_WHITE;
    self.navigationItem.leftBarButtonItem = addFolderButton;
    
    // Add folder alert controller
    self.addFolderAlertController = [UIAlertController alertControllerWithTitle:@"New Folder" message:@"Enter a name for this folder." preferredStyle:UIAlertControllerStyleAlert];
    
    [self.addFolderAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        textField.placeholder = @"Name";
    }];
    self.addFolderAlertController.textFields[0].delegate = self;
    
    [self.addFolderAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Save the folder
        LFolder *newFolder = [LFolder createInContext:DataContext];
        newFolder.name = self.addFolderAlertController.textFields[0].text;
        [DataStore save];
        // Empty the textfield
        self.addFolderAlertController.textFields[0].text = nil;
        action.enabled = YES;
    }];
    saveAction.enabled = NO;
    [self.addFolderAlertController addAction:saveAction];
    
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folders.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFolderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[LFolderTableViewCell reuseIdentifier]];
    cell.folderName = ((LFolder *)[self.folders objectAtIndexPath:indexPath]).name;
    cell.photoCount = 155;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LPhotoCollectionViewController *photoVC = [[LPhotoCollectionViewController alloc] initWithFolder:[self.folders objectAtIndexPath:indexPath]];
    [self.navigationController pushViewController:photoVC animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)didPressAddFolderButton {
    // Show alert controller
    [self presentViewController:self.addFolderAlertController animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.addFolderAlertController.actions[1].enabled = ![textField.text stringByReplacingCharactersInRange:range withString:string].isEmpty;
    
    return YES;
}

@end
