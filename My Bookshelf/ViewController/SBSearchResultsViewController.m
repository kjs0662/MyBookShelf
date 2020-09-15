//
//  SBSearchResultsViewController.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBSearchResultsViewController.h"
#import "SBBookTableViewCell.h"

@interface SBSearchResultsViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation SBSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _results = [[SBPagination alloc] init];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.systemBackgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tableView];
    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    self.tableView = tableView;
    [tableView registerClass:SBBookTableViewCell.class forCellReuseIdentifier:SBBookTableViewCellID];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBBookTableViewCellID forIndexPath:indexPath];
    [cell configureCell:self.results.list[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SBBookModel *book = self.results.list[indexPath.row];
    SBBookDetailViewController *vc = [[SBBookDetailViewController alloc] initWithIsbn: book.isbn13];
    [self.delegate sbPresentDetailVC:self present:vc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if(maximumOffset - currentOffset <= 30) {
        if (self.results.pageMoreExist) {
            [self.delegate sbResultsNeedLoadMore:self];
        }
    }
}

@end
