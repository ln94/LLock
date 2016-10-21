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

@interface AppDelegate ()

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = C_BLACK;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LFolderTableViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    // Blurer
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.window.bounds;
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addBlurredView];
    
    // First time use: create sample folder
    if (SettingsManager.firstTimeUse) {
        [PhotoManager createFolderWithName:@"My Folder"];
        SettingsManager.firstTimeUse = NO;
    }
    
    // Pin and Touch ID
    self.isTouchIDAsked = NO;
    [self checkPin];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    LOG(@"Did become active");
    if (!self.isTouchIDAsked) {
        self.isTouchIDAsked = NO;
    }
    if (SettingsManager.pinEnabled) {
        // Show Pin screen
        UIViewController *topVC = [self topViewController];
        
        if (![topVC isKindOfClass:[LPinViewController class]]) {
            
            if (!self.isTouchIDAsked) {
                LOG(@"1");
                // Open pin screen
                if ([topVC isKindOfClass:[UINavigationController class]]) {
                    topVC = [((UINavigationController *)topVC).childViewControllers firstObject];
                }
                LPinViewController *pinVC = [[LPinViewController alloc] initWithType:LPinViewControllerTypeEnter];
                [topVC presentViewController:pinVC animated:NO completion:^{
                    self.isTouchIDAsked = YES;
                    [pinVC askForTouchID];
                }];
            }
            else {
                // Successfully unlocked with Touch ID
                self.isTouchIDAsked = NO;
            }
        }
        else {
            if (!self.isTouchIDAsked){
                LOG(@"2");
                // Pin screen is open, but Touch ID is not asked for: ask for Touch ID
                self.isTouchIDAsked = YES;
                [(LPinViewController *)topVC askForTouchID];
            }
            else {
                LOG(@"3");
                // Case when Touch ID asking alert was cancelled: ask for pin
                self.isTouchIDAsked = NO;
                [(LPinViewController *)topVC askForPin];
            }
        }
    }

    [self removeBlurredView];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    LOG(@"WILL resign active");
    if (!self.isTouchIDAsked) {
        // App is just resigning active, not asking for Touch ID
        
        UIViewController *topVC = [self topViewController];
        
        if ([topVC isKindOfClass:[LPinViewController class]]) {
            // If pin screen is presented, hide the keyboard
            [(LPinViewController *)[self topViewController] hideAskingForPin];
        }
        else if ([topVC isKindOfClass:[UIAlertController class]]) {
            [topVC.presentingViewController dismissViewControllerAnimated:NO completion:nil];
        }
        
        [self addBlurredView];
    }
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    LOG(@"Did Enter Background");
    UIViewController *topVC = [self topViewController];
    if ([topVC isKindOfClass:[LPinViewController class]]) {
        [(LPinViewController *)topVC hideAskingForPin];
        self.isTouchIDAsked = NO;
    }
    
    [self addBlurredView];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    LOG(@"Will Enter Foregrond");
}

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
    [self.window addSubview:self.blurEffectView];
}

- (void)removeBlurredView {
    [self.blurEffectView removeFromSuperview];
}

#pragma mark - Pin / Touch ID

- (void)checkPin {
    
    if (SettingsManager.pinEnabled) {
        // Open Pin screen
        
        UIViewController *topVC = [self topViewController];
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            
            LPinViewController *pinVC = [[LPinViewController alloc] initWithType:LPinViewControllerTypeEnter];
            [topVC presentViewController:pinVC animated:NO completion:^{
//                [self checkTouchID];
            }];

        }
    }
}

- (void)checkTouchID {
    
    if (SettingsManager.touchIDEnabled && SettingsManager.touchIDAvailable) {
        // Open Touch ID alert
        
        [SettingsManager askForTouchID:^(BOOL success, NSError *error) {
            run_main(^{
                if (success) {
                    [(LPinViewController *)[self topViewController] dismissForCorrectlyEnteredPin];
                }
            });
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
