//
//  AppDelegate.m
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "AppDelegate.h"
#import "LFolderTableViewController.h"
#import "LPinViewController.h"
#import "LPinEntryManager.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = C_BLACK;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LFolderTableViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    // First time use: create sample folder
    if (SettingsManager.firstTimeUse) {
        [PhotoManager createFolderWithName:@"My Folder"];
        SettingsManager.firstTimeUse = NO;
    }
    
    // Blurer
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.window.bounds;
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addBlurredView];

    // Ask for Pin
    [PinEntryManager validatePin];
    
    return YES;
}

/*
 App became active:
 1. App was just launched
 2. Touch ID alert was closed
 3. Notification bar was pulled back up
 4. App was opened back after being backgrounded (actions after Enter Foreground activity)
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
//    LOG(@"-----Did become active");

    // If Touch ID was closed and Pin entry screen is displayed, show keyboard
    if (![PinEntryManager isTouchIDAlertDisplayed]) {
        
        UIViewController *topVC = [self topViewController];
        if ([topVC isKindOfClass:[LPinViewController class]] && [(LPinViewController *)topVC isEnterType]) {
            [(LPinViewController *)topVC showKeyboard];
        }
    }
    
    [self removeBlurredView];
}

/*
 App resigned active:
 1. Touch ID alert was displayed
 2. Notification tab was pulled down
 3. Lock button was pressed
 4. Home button was pressed (always: Touch ID alert wasn't displayed)
 */
- (void)applicationWillResignActive:(UIApplication *)application {
//    LOG(@"-----WILL resign active");

    // If Touch ID entry alert isn't displayed, add blurer
    if (![PinEntryManager isTouchIDAlertDisplayed]) {
        [self addBlurredView];
    }
}

/*
 App entered Foreground (actions before applicationDidBecomeActive):
 1. App was opened back after backgrounded
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    LOG(@"-----Will Enter Foreground");
    
    [PinEntryManager validatePin];
}

/*
 App entered Background (actions after applicationWillResignActive):
 1. Lock button was pressed
 2. Home button was pressed (always: Touch ID alert wasn't displayed)
 */
-(void)applicationDidEnterBackground:(UIApplication *)application {
//    LOG(@"-----Did Enter Background");
    
    UIViewController *topVC = [self topViewController];
    
    if ([topVC isKindOfClass:[LPinViewController class]]) {
        
        // If any type of Pin screen is displayed, hide keyboard
        [(LPinViewController *)topVC hideKeyboard];
    }
    else if ([topVC isKindOfClass:[UIAlertController class]] && SettingsManager.pinEnabled) {
        
        // If Pin is enabled and any Alert controller is displayed, dismiss it and reopen after reopening app and entering pin
        PinEntryManager.alertControllerToReopen = (UIAlertController *)topVC;
        [topVC.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    }
    
    [self addBlurredView];
}


#pragma  mark - Top View Controller

- (UIViewController *)topViewController {
    // Find the top view controller
    UIViewController *topVC = self.window.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = [topVC.childViewControllers lastObject];
    }
    
    return topVC;
    
}


#pragma mark - Blurer

- (void)addBlurredView {
    if (!self.blurEffectView.superview) {
        LOG(@"-----self.blurEffectView add");
        [self.window addSubview:self.blurEffectView];
    }
}

- (void)removeBlurredView {
    if (self.blurEffectView.superview) {
        LOG(@"-----self.blurEffectView removeFromSuperview");
        
        [UIView transitionFromView:self.blurEffectView toView:[self topViewController].view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
            [self.blurEffectView removeFromSuperview];
        }];
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LLock"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
