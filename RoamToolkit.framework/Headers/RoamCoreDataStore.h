//
//  RoamCoreDataStore.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RoamSingleton.h"

#define DataStore               [CoreDataStore singleton]
#define DataContext             [DataStore context]
#define DataContextBackground   [DataStore backgroundContext]
#define DataContextSync         [DataStore syncContext]

typedef NS_ENUM(NSUInteger, RCLManagedContext) {
    RCLManagedContextMain, // Main context for UI
    RCLManagedContextEdit, // Here you can edit things. This is a pererable way to edit things without getting the UI locked
    
    RCLManagedContextSync = 999 // Separate background context for syching stuff from the server. Parent is RCLManagedContextWriter. However merges with MAIN automatically on save.    
};

typedef void(^RCLCompletionHandler)(BOOL success);

@interface CoreDataStore : NSObject <Singleton>

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectContext *backgroundContext;
@property (nonatomic, readonly) NSManagedObjectContext *syncContext;

@end

@interface CoreDataStore (DatabaseOperations)

/// The correct method do a coredata clean up
- (void)clearAllData:(RCLCompletionHandler)completionHandler;

/**
 
 Saves all contexts up to the one specified (inclusive). This method is @b asynchronous
 
 @discussion In order to properly save the data, it is needed to go through the list of contexts and save each, from the very first child to the very last parent. So this method will save all the context UP to the one you specified (inclusive). In order to save everything, you will have to specify the context with the number 0. Currently it's @c RCLManagedContextWriter
 */
- (void)saveContext:(RCLManagedContext)managedContext handler:(RCLCompletionHandler)completionHandler;
/**
 
 Saves all contexts up to the one specified (inclusive). This method is @b synchronous
 
 @discussion In order to properly save the data, it is needed to go through the list of contexts and save each, from the very first child to the very last parent. So this method will save all the context UP to the one you specified (inclusive). In order to save everything, you will have to specify the context with the number 0. Currently it's @c RCLManagedContextWriter
 */
- (void)saveContextAndWait:(RCLManagedContext)managedContext;

/// Saves all contexts asynchronously, except of the @c Sync one
- (void)save;

/// Saves all contexts synchronously, except of the @c Sync one
- (void)saveAndWait;

@end

@interface CoreDataStore (ManagedObjects)

- (NSManagedObject *)createNewEntityForClass:(Class)entityClass context:(NSManagedObjectContext *)context;

- (void)removeEntity:(NSManagedObject *)entity context:(NSManagedObjectContext *)context;
- (void)removeAllEntitiesForClass:(Class)entityClass context:(NSManagedObjectContext *)context;

- (NSArray *)allForEntity:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass predicate:(NSPredicate *)predicate orderBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;
- (NSArray *)allForEntity:(Class)entityClass orderBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;

- (NSManagedObject *)entityForClass:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSManagedObject *)entityForClass:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;

- (NSManagedObject *)entityWithURI:(NSURL *)uri context:(NSManagedObjectContext *)context;
- (NSManagedObject *)entityWithObjectID:(NSManagedObjectID *)objectID context:(NSManagedObjectContext *)context;

- (NSInteger)countForEntity:(Class)entityClass context:(NSManagedObjectContext *)context;
- (NSInteger)countForEntity:(Class)entityClass predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;

@end
