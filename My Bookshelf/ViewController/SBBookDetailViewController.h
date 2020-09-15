//
//  SBBookDetailViewController.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBBookDetailViewController : UIViewController

- (instancetype)initWithIsbn:(nonnull NSString *)isbn;

@end

NS_ASSUME_NONNULL_END
