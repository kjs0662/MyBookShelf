//
//  SBBookCollectionViewCell.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookCollectionViewCell.h"
#import "SBUtils.h"

NSString *const SBBookCollectionViewCellID = @"SBBookCollectionViewCellID";

@interface SBBookCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *highlightView;

@end

@implementation SBBookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.lightGrayColor;
    } else {
        self.contentView.backgroundColor = UIColor.clearColor;
    }
}

- (void)configureCell:(SBBookDetailModel *)book {
    [SBUtils imageForUrl:book.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }
    }];
    self.titleLabel.text = book.title;
}

- (void)_initView {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColor.labelColor;
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    [label.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [label.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [label.heightAnchor constraintEqualToConstant:[@"Title" boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font} context:nil].size.height].active = YES;
    self.titleLabel = label;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imageView];
    [imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [imageView.bottomAnchor constraintEqualToAnchor:self.titleLabel.topAnchor].active = YES;
    self.imageView = imageView;
}

@end
