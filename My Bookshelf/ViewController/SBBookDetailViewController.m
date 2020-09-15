//
//  SBBookDetailViewController.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookDetailViewController.h"
#import "SBBookService.h"
#import "SBUtils.h"
#import "SBMemoViewController.h"
#import "SBCoreDataManager.h"

@interface SBBookDetailViewController () <SBMemoViewControllerDelegate, UIAdaptivePresentationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *authorsLabel;
@property (nonatomic, strong) UITextView *linkTextView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *memoLabel;
@property (nonatomic, strong) UIButton *memoButton;

@property (nonatomic, strong) NSString *isbn;
@property (nonatomic, strong) SBBookDetailModel *book;

@end

@implementation SBBookDetailViewController

- (instancetype)initWithIsbn:(NSString *)isbn {
    self = [super init];
    if (self) {
        _isbn = isbn;
    }
    return self;
}

- (void)setBook:(SBBookDetailModel *)book {
    _book = book;
    [SBUtils imageForUrl:book.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                return;
            }
            if (image) {
                self.imageView.image = image;
            }
        });
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.subtitleLabel.text = book.subtitle;
        self.authorsLabel.text = book.authors;
        self.priceLabel.text = book.price;
        self.descLabel.text = book.desc;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        if (book.url) {
            [attribute setObject:book.url forKey:NSLinkAttributeName];
        }
        [attribute setObject:[UIFont systemFontOfSize:20 weight:UIFontWeightBold] forKey:NSFontAttributeName];
        [attribute setObject:style forKey:NSParagraphStyleAttributeName];
        NSAttributedString *linkString = [[NSAttributedString alloc] initWithString:book.title attributes:attribute];
        self.linkTextView.attributedText = linkString;
        if (book.memo.length > 0) {
            [self.memoButton setTitle:book.memo forState:UIControlStateNormal];
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [imageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:self.view.bounds.size.width * 1.17].active = YES;
    _imageView = imageView;
    
    UITextView *link = [[UITextView alloc] init];
    link.backgroundColor = UIColor.clearColor;
    link.scrollEnabled = NO;
    link.showsHorizontalScrollIndicator = NO;
    link.showsVerticalScrollIndicator = NO;
    link.translatesAutoresizingMaskIntoConstraints = NO;
    link.textAlignment = NSTextAlignmentCenter;
    link.editable = NO;
    link.linkTextAttributes = @{
        NSForegroundColorAttributeName: UIColor.labelColor,
        NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
    };
    [self.view addSubview:link];
    [link.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor].active = YES;
    [link.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [link.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    _linkTextView = link;
    
    UILabel *authors = [[UILabel alloc] init];
    authors.textColor = UIColor.labelColor;
    authors.textAlignment = NSTextAlignmentCenter;
    authors.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    authors.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:authors];
    [authors.topAnchor constraintEqualToAnchor:self.linkTextView.bottomAnchor constant:0].active = YES;
    [authors.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
    [authors.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-8].active = YES;
    _authorsLabel = authors;
    
    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.textColor = UIColor.labelColor;
    subtitle.textAlignment = NSTextAlignmentCenter;
    subtitle.font = [UIFont systemFontOfSize:15];
    subtitle.translatesAutoresizingMaskIntoConstraints = NO;
    subtitle.numberOfLines = 0;
    [self.view addSubview:subtitle];
    [subtitle.topAnchor constraintEqualToAnchor:self.authorsLabel.bottomAnchor constant:5].active = YES;
    [subtitle.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
    [subtitle.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-8].active = YES;
    _subtitleLabel = subtitle;
    
    UILabel *price = [[UILabel alloc] init];
    price.textColor = UIColor.labelColor;
    price.textAlignment = NSTextAlignmentCenter;
    price.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    price.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:price];
    [price.topAnchor constraintEqualToAnchor:self.subtitleLabel.bottomAnchor constant:5].active = YES;
    [price.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [price.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    _priceLabel = price;
    
    UILabel *desc = [[UILabel alloc] init];
    desc.textColor = UIColor.labelColor;
    desc.textAlignment = NSTextAlignmentNatural;
    desc.font = [UIFont systemFontOfSize:12];
    desc.translatesAutoresizingMaskIntoConstraints = NO;
    desc.numberOfLines = 0;
    [self.view addSubview:desc];
    [desc.topAnchor constraintEqualToAnchor:self.priceLabel.bottomAnchor constant:5].active = YES;
    [desc.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16].active = YES;
    [desc.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
    _descLabel = desc;
    
    UILabel *memo = [[UILabel alloc] init];
    memo.text = @"Memo";
    memo.textColor = UIColor.labelColor;
    memo.textAlignment = NSTextAlignmentLeft;
    memo.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    memo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:memo];
    [memo.topAnchor constraintEqualToAnchor:self.descLabel.bottomAnchor constant:12].active = YES;
    [memo.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [memo.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    _memoLabel = memo;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"Write memo here..." forState:UIControlStateNormal];
    [button setTitleColor:UIColor.secondaryLabelColor forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setBackgroundColor:UIColor.secondarySystemBackgroundColor];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 10;
    [button addTarget:self action:@selector(_memoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button.topAnchor constraintEqualToAnchor:self.memoLabel.bottomAnchor constant:5].active = YES;
    [button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [button.heightAnchor constraintEqualToConstant:50].active = YES;
    _memoButton = button;
    
    [self _fetchBookDetail];
}

- (void)_memoButtonClick:(UIButton *)sender {
    SBMemoViewController *vc = [[SBMemoViewController alloc] initWithText:self.book.memo];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_fetchBookDetail {
    if (self.isbn) {
        SBBookDetail *db = [[SBCoreDataManager sharedInstance] fetchBookDetail:self.isbn];
        if (db) {
            self.book = [[SBBookDetailModel alloc] initWithDB:db];
            return;
        }
        __weak SBBookDetailViewController *weakSelf = self;
        [SBBookService fetchBookDetail:self.isbn completion:^(SBBookDetailModel * _Nullable result) {
            if (result) {
                weakSelf.book = result;
                [[SBCoreDataManager sharedInstance] saveBookDetail:result];
            }
        }];
    }
}

#pragma mark - SBMeoDetailViewControllerDelegate

- (void)sbMemoViewControllerWillDismiss:(SBMemoViewController *)controller memo:(NSString *)text {
    if (text.length > 0) {
        self.book.memo = text;
        [self.memoButton setTitle:text forState:UIControlStateNormal];
        [[SBCoreDataManager sharedInstance] saveBookDetail:self.book];
    }
}



@end
