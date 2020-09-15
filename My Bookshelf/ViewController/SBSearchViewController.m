//
//  SBSearchViewController.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBSearchViewController.h"
#import "SBSearchResultsViewController.h"
#import "SBApiClient.h"
#import "SBBookCollectionViewCell.h"
#import "SBBookCollectionReusableView.h"
#import "SBBookService.h"
#import "SBBookDetailViewController.h"

@interface SBSearchViewController () <
UISearchControllerDelegate,
UISearchResultsUpdating,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UISearchBarDelegate,
SBSearchResultsVCDeleagte
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SBSearchResultsViewController *resultsVC;

@property (nonatomic, strong) NSArray *books;
@property (nonatomic) BOOL isLoadingMore;

@end

@implementation SBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.title = @"Search";
    _isLoadingMore = NO;
    SBSearchResultsViewController *searchResultsVC = [[SBSearchResultsViewController alloc] init];
    searchResultsVC.delegate = self;
    self.resultsVC = searchResultsVC;
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsVC];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"Please type only alphabet or number.";
    searchController.obscuresBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.searchController = searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    
    self.definesPresentationContext = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = YES;
    collectionView.backgroundColor = UIColor.clearColor;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [collectionView registerClass:SBBookCollectionViewCell.class forCellWithReuseIdentifier:SBBookCollectionViewCellID];
    [collectionView registerClass:SBBookCollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SBBookCollectionReuseableViewID];
    [self.view addSubview:collectionView];
    [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    self.collectionView = collectionView;
    
    [self _fetchNewBooks];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [super viewWillAppear:animated];
}

- (void)_fetchNewBooks {
    [SBBookService fetchNewBooks:^(NSArray<SBBookModel *> * _Nullable result) {
        if (result.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.books = result;
                [self.collectionView reloadData];
            });
        }
    }];
}

- (void)_fetchSearchedBooks:(NSString *)keyword page:(NSUInteger)page {
    __weak SBSearchViewController *weakSelf = self;
    [SBBookService fetchSearchBooks:keyword page:[NSString stringWithFormat:@"%ld", (long)page] completion:^(SBPagination * _Nullable result) {
         weakSelf.isLoadingMore = NO;
        if (result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultsVC.results.page = result.page;
                self.resultsVC.results.pageMoreExist = result.pageMoreExist;
                if (self.resultsVC.results.count > 0) {
                    [self.resultsVC.results.list addObjectsFromArray:result.list];
                } else {
                    self.resultsVC.results.list = [NSMutableArray arrayWithArray:result.list];
                }
                [self.resultsVC.tableView reloadData];
            });
        }
    }];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}

#pragma mark - UINavigationBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@".*[^A-Za-z0-9].*" options:kNilOptions error:&error];
    if (error) {
        NSLog(@"%@", error.description);
        return;
    }
    if ([reg firstMatchInString:searchText options:kNilOptions range:NSMakeRange(0, searchText.length)] != nil) {
        searchBar.searchTextField.text = @"";
        return;
    }
    if (searchBar.searchTextField.text > 0) {
        self.resultsVC.results = [[SBPagination alloc] init];
        [self.resultsVC.tableView reloadData];
        
        [self _fetchSearchedBooks:searchBar.searchTextField.text page:self.resultsVC.results.page];
    }
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.books.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SBBookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SBBookCollectionViewCellID forIndexPath:indexPath];
    [cell configureCell:self.books[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.bounds.size.width - 24)/2;
    CGFloat height = width * 7/6;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SBBookCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SBBookCollectionReuseableViewID forIndexPath:indexPath];
    [view configureView:@"Browse New Releases"];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.bounds.size.width, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    SBBookModel *book = self.books[indexPath.item];
    SBBookDetailViewController *vc = [[SBBookDetailViewController alloc] initWithIsbn:book.isbn13];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SBSearchResultsVCDeleagte

- (void)sbResultsNeedLoadMore:(SBSearchResultsViewController *)controller {
    if (!self.isLoadingMore) {
        NSInteger page = controller.results.page + 1;
        [self _fetchSearchedBooks:self.navigationItem.searchController.searchBar.text page:page];
        self.isLoadingMore = YES;
    }
}

- (void)sbPresentDetailVC:(SBSearchResultsViewController *)constroller present:(SBBookDetailViewController *)detail {
    [self.navigationController pushViewController:detail animated:YES];
}

@end
