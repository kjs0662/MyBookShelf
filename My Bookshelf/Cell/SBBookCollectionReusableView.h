//
//  SBBookCollectionReusableView.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SBBookCollectionReuseableViewID;

@interface SBBookCollectionReusableView : UICollectionReusableView

- (void)configureView:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
