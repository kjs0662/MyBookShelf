//
//  SBPagination.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBPagination.h"

@implementation SBPagination

- (instancetype)init {
    self = [super init];
    if (self) {
        _page = 1;
        _pageMoreExist = NO;
    }
    return self;
}

- (NSInteger)count {
    return self.list.count;
}

@end
