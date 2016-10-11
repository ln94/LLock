//
//  LPhotoData+CoreDataProperties.m
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoData+CoreDataProperties.h"

@implementation LPhotoData (CoreDataProperties)

+ (NSFetchRequest<LPhotoData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LPhotoData"];
}

@dynamic creationDate;
@dynamic photoId;
@dynamic location;
@dynamic folder;

@end
