//
//  SBBookDetail+CoreDataProperties.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/06.
//  Copyright © 2020 JinseonKim. All rights reserved.
//
//

#import "SBBookDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SBBookDetail (CoreDataProperties)

+ (NSFetchRequest<SBBookDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *subtitle;
@property (nullable, nonatomic, copy) NSString *authors;
@property (nullable, nonatomic, copy) NSString *isbn13;
@property (nullable, nonatomic, copy) NSString *isbn10;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *desc;
@property (nullable, nonatomic, copy) NSString *memo;
@property (nullable, nonatomic, copy) NSDate *updatedDate;

@end

NS_ASSUME_NONNULL_END
