//
//  SBCoreDataContext.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBBookDetailModel.h"
#import "SBBookDetail+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBCoreDataManager : NSObject

@property (class, strong, nonatomic, readonly, nonnull) SBCoreDataManager *sharedInstance;

- (SBBookDetail *)fetchBookDetail:(NSString *)isbn;
- (void)saveBookDetail:(SBBookDetailModel *)book;

@end

NS_ASSUME_NONNULL_END
