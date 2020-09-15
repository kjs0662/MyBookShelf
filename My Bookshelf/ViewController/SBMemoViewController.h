//
//  SBMemoViewController.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SBMemoViewControllerDelegate;

@interface SBMemoViewController : UIViewController

@property (nonatomic, weak, nullable) id<SBMemoViewControllerDelegate>delegate;
- (instancetype)initWithText:(nullable NSString *)text;

@end

@protocol SBMemoViewControllerDelegate <NSObject>

- (void)sbMemoViewControllerWillDismiss:(nonnull SBMemoViewController *)controller memo:(nullable NSString *)text;

@end

NS_ASSUME_NONNULL_END
