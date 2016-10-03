//
//  NSFetchRequestController.h
//
//  Copyright © Roam Creative. All rights reserved.
//
//  This class essentially functions as a one dimensional NSFetchedResultsController and
//  is simplified to make observing core data changes on a single object or group of
//  objects easier.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol NSFetchRequestControllerDelegate;

@interface NSFetchRequestController : NSObject

+ (NSFetchRequestController *)controllerWithFetchRequest:(NSFetchRequest *)fetchRequest;

@property (nonatomic) NSFetchRequest *fetchRequest;

@property (nonatomic) id<NSFetchRequestControllerDelegate> delegate;
@property (nonatomic, readonly) NSArray *fetchedObjects;

- (void)performFetch;

@end

@protocol NSFetchRequestControllerDelegate <NSObject>

@optional
- (void)requestWillChangeContent:(NSFetchRequestController *)controller;
- (void)requestDidChangeContent:(NSFetchRequestController *)controller;

- (void)request:(NSFetchRequestController *)controller didChangeObject:(id)object atIndex:(NSInteger)index changeType:(NSFetchedResultsChangeType)type newIndex:(NSInteger)newIndex;

- (void)request:(NSFetchRequestController *)controller didChangeObject:(id)object;
                                 
@end
