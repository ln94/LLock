//
//  LPhotoImage+CoreDataProperties.m
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoImage+CoreDataProperties.h"

@implementation LPhotoImage (CoreDataProperties)

+ (NSFetchRequest<LPhotoImage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LPhotoImage"];
}

@dynamic fullImage;
@dynamic photoId;
@dynamic thumbnail;

@end
