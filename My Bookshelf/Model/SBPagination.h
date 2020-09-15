//
//  SBPagination.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBPagination : NSObject

@property (strong, nonatomic, nullable) NSMutableArray *list;
@property (nonatomic) NSInteger page;
@property (nonatomic) BOOL pageMoreExist;
@property (nonatomic) NSInteger count;

@end

NS_ASSUME_NONNULL_END
