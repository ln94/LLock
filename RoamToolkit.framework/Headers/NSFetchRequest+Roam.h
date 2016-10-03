//
//  NSFetchRequest+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchRequest (Roam)

+ (instancetype)fetchRequestWithEntity:(Class)entityClass;
+ (instancetype)fetchRequestWithEntity:(Class)entityClass predicate:(NSPredicate *)predicate;

- (void)setSortDescriptor:(NSSortDescriptor *)sortDescriptor;

@property (nonatomic) NSSortDescriptor *sortDescriptor;

@end
