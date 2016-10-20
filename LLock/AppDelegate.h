//
//  AppDelegate.h
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LFolderTableViewController.h"

#define LLock ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LFolderTableViewController *mainViewController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

