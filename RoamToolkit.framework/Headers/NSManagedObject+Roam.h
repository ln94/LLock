//
//  NSManagedObject+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Roam)

+ (instancetype)create;

+ (NSArray *)all;
+ (NSArray *)allForPredicate:(NSPredicate *)predicate;
+ (NSArray *)allForPredicate:(NSPredicate *)predicate orderBy:(NSString *)key ascending:(BOOL)ascending;
+ (NSArray *)allOrderedBy:(NSString *)key ascending:(BOOL)ascending;

+ (instancetype)first;
+ (instancetype)firstWithKey:(NSString *)key value:(id)value;
+ (instancetype)firstWithKeyValues:(NSDictionary *)pairs;
+ (instancetype)firstWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)allWithKey:(NSString *)key value:(id)value;

+ (NSInteger)count;
+ (NSInteger)countWithPredicate:(NSPredicate *)predicate;
+ (NSInteger)countWithKey:(NSString *)key value:(id)value;

+ (void)destroyAll;



+ (instancetype)createInContext:(NSManagedObjectContext *)context;

+ (NSArray *)allInContext:(NSManagedObjectContext *)context;
+ (NSArray *)allForPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (NSArray *)allForPredicate:(NSPredicate *)predicate orderBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;
+ (NSArray *)allOrderedBy:(NSString *)key ascending:(BOOL)ascending context:(NSManagedObjectContext *)context;

+ (instancetype)firstInContext:(NSManagedObjectContext *)context;
+ (instancetype)firstWithKey:(NSString *)key value:(id)value context:(NSManagedObjectContext *)context;
+ (instancetype)firstWithKeyValues:(NSDictionary *)pairs context:(NSManagedObjectContext *)context;
+ (instancetype)firstWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (NSArray *)allWithKey:(NSString *)key value:(id)value context:(NSManagedObjectContext *)context;

+ (NSInteger)countInContext:(NSManagedObjectContext *)context;
+ (NSInteger)countWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (NSInteger)countWithKey:(NSString *)key value:(id)value context:(NSManagedObjectContext *)context;

+ (void)destroyAllInContext:(NSManagedObjectContext *)context;

- (void)destroy;

@end
