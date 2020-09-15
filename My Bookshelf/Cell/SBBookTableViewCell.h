//
//  SBBookTableViewCell.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBBookDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SBBookTableViewCellID;

@interface SBBookTableViewCell : UITableViewCell

- (void)configureCell:(SBBookModel *)book;

@end

NS_ASSUME_NONNULL_END
