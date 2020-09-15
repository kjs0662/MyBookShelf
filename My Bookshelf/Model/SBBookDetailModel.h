//
//  SBBookDetailModel.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBBookModel.h"
#import "SBBookDetail+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBBookDetailModel : SBBookModel

@property (nonatomic, strong, nullable) NSString *authors;
@property (nonatomic, strong, nullable) NSString *publisher;
@property (nonatomic, strong, nullable) NSString *isbn10;
@property (nonatomic, strong, nullable) NSString *pages;
@property (nonatomic, strong, nullable) NSString *year;
@property (nonatomic, strong, nullable) NSString *rating;
@property (nonatomic, strong, nullable) NSString *desc;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *pdf;

@property (nonatomic, strong, nullable) NSString *memo;

- initWithDB:(SBBookDetail *)db;

@end

NS_ASSUME_NONNULL_END
