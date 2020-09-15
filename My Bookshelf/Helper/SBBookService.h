//
//  SBBookService.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBBookDetailModel.h"
#import "SBPagination.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBBookService : NSObject

+ (void)fetchNewBooks:(void (^)(NSArray<SBBookModel*> * _Nullable result))completion;
+ (void)fetchSearchBooks:(NSString *)text page:(NSString *)page completion:(void (^)(SBPagination * _Nullable result))completion;
+ (void)fetchBookDetail:(NSString *)isbn completion:(void (^)(SBBookDetailModel * _Nullable result))completion;

@end

NS_ASSUME_NONNULL_END
