//
//  NSFetchedResultsController+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (Roam)

+ (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest;
+ (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest sectionKey:(NSString *)sectionKey;
+ (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest sectionKey:(NSString *)sectionKey cacheName:(NSString *)cacheName;

- (void)performFetch;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)nameOfSection:(NSInteger)section;

- (NSUInteger)numberOfObjects;

- (BOOL)isEmpty;

@end
