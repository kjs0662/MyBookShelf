//
//  SBBookModel.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBBookModel : NSObject

@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong, nullable) NSString *subtitle;
@property (nonatomic, strong, nonnull) NSString *isbn13;
@property (nonatomic, strong, nullable) NSString *price;
@property (nonatomic, strong, nullable) NSString *image;
@property (nonatomic, strong, nullable) NSString *url;


@end

NS_ASSUME_NONNULL_END
