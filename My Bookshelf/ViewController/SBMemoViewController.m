//
//  SBMemoViewController.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBMemoViewController.h"

@interface SBMemoViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *text;

@end

@implementation SBMemoViewController

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _text = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    UITextView *textView = [[UITextView alloc] init];
    textView.clearsOnInsertion = YES;
    textView.text = self.text;
    textView.scrollEnabled = YES;
    textView.alwaysBounceVertical = YES;
    textView.showsHorizontalScrollIndicator = NO;
    textView.textColor = UIColor.labelColor;
    textView.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textView];
    [textView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [textView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [textView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [textView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    _textView = textView;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.delegate sbMemoViewControllerWillDismiss:self memo:self.textView.text];
    [super viewWillDisappear:animated];
    
}

@end
