//
//  SBUtils.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/03.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBUtils : NSObject

+ (void)imageForUrl:(NSString *const)url completion:(void (^)(UIImage * _Nullable image, NSError * _Nullable error))completion;
+ (nullable id)jsonToObject:(nonnull NSData *)json;

@end

NS_ASSUME_NONNULL_END
