//
//  SBBookDetail+CoreDataProperties.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/06.
//  Copyright © 2020 JinseonKim. All rights reserved.
//
//

#import "SBBookDetail+CoreDataProperties.h"

@implementation SBBookDetail (CoreDataProperties)

+ (NSFetchRequest<SBBookDetail *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SBBookDetail"];
}

@dynamic title;
@dynamic subtitle;
@dynamic authors;
@dynamic isbn13;
@dynamic isbn10;
@dynamic url;
@dynamic image;
@dynamic price;
@dynamic desc;
@dynamic memo;
@dynamic updatedDate;

@end
