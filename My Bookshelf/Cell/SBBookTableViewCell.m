//
//  SBBookTableViewCell.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookTableViewCell.h"
#import "SBUtils.h"

NSString *const SBBookTableViewCellID = @"SBBookTableViewCellID";

@interface SBBookTableViewCell()

@property (nonatomic, strong) UIImageView *bookImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation SBBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(SBBookModel *)book {
    [SBUtils imageForUrl:book.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bookImageView.image = image;
            });
        }
    }];
    self.titleLabel.text = book.title;
    self.subtitleLabel.text = book.subtitle;
    self.priceLabel.text = book.price;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.bookImageView.image = nil;
    self.titleLabel.text = nil;
    self.subtitleLabel.text = nil;
    self.priceLabel.text = nil;
}

- (void)_initView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imageView];
    _bookImageView = imageView;
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    title.textColor = UIColor.labelColor;
    title.textAlignment = NSTextAlignmentLeft;
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.numberOfLines = 0;
    [self.contentView addSubview:title];
    _titleLabel = title;
    
    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.font = [UIFont systemFontOfSize:15];
    subtitle.textColor = UIColor.labelColor;
    subtitle.textAlignment = NSTextAlignmentLeft;
    subtitle.numberOfLines = 3;
    subtitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:subtitle];
    _subtitleLabel = subtitle;
    
    UILabel *price = [[UILabel alloc] init];
    price.font = [UIFont systemFontOfSize:15];
    price.textColor = UIColor.labelColor;
    price.textAlignment = NSTextAlignmentLeft;
    price.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:price];
    _priceLabel = price;
    
    [self _setConstraint];
}

- (void)_setConstraint {
    [self.bookImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.bookImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:10].active = YES;
    [self.bookImageView.widthAnchor constraintEqualToConstant:150*0.86].active = YES;
    [self.bookImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16].active = YES;
    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.bookImageView.rightAnchor constant:10].active = YES;
    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10].active = YES;
    
    [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5].active = YES;
    [self.subtitleLabel.leftAnchor constraintEqualToAnchor:self.bookImageView.rightAnchor constant:10].active = YES;
    [self.subtitleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10].active = YES;
    
    [self.priceLabel.topAnchor constraintEqualToAnchor:self.subtitleLabel.bottomAnchor constant:5].active = YES;
    [self.priceLabel.leftAnchor constraintEqualToAnchor:self.bookImageView.rightAnchor constant:10].active = YES;
    [self.priceLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-10].active = YES;
}

@end
