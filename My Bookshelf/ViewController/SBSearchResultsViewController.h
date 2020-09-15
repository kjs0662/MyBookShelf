//
//  SBSearchResultsViewController.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBBookDetailModel.h"
#import "SBPagination.h"
#import "SBBookDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SBSearchResultsVCDeleagte;

@interface SBSearchResultsViewController : UIViewController

@property (nonatomic, weak, nullable) id<SBSearchResultsVCDeleagte>delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SBPagination *results;

@end

@protocol SBSearchResultsVCDeleagte <NSObject>

- (void)sbPresentDetailVC:(nonnull SBSearchResultsViewController *)constroller present:(nonnull SBBookDetailViewController *)detail;
- (void)sbResultsNeedLoadMore:(nonnull SBSearchResultsViewController *)controller;

@end

NS_ASSUME_NONNULL_END
