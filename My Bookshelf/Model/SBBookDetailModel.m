//
//  SBBookDetailModel.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/08/31.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookDetailModel.h"

@implementation SBBookDetailModel

- initWithDB:(SBBookDetail *)db {
    self = [super init];
    if (self) {
        self.title = db.title;
        self.subtitle = db.subtitle;
        self.authors = db.authors;
        self.price = db.price;
        self.desc = db.desc;
        self.isbn10 = db.isbn10;
        self.isbn13 = db.isbn13;
        self.memo = db.memo;
        self.image = db.image;
        self.url = db.url;
    }
    return self;
}

@end
