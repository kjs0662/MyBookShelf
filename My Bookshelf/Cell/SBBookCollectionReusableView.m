//
//  SBBookCollectionReusableView.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookCollectionReusableView.h"

NSString *const SBBookCollectionReuseableViewID = @"SBBookCollectionReuseableViewID";

@interface SBBookCollectionReusableView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation SBBookCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)configureView:(NSString *)text {
    self.label.text = text;
}

- (void)_initView {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColor.labelColor;
    label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    [label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [label.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
    [label.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    self.label = label;
}

@end
