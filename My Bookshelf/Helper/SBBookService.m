//
//  SBBookService.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/04.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBBookService.h"
#import "SBApiClient.h"

@implementation SBBookService

+ (void)fetchNewBooks:(void (^)(NSArray<SBBookModel*> * _Nullable result))completion {
    SBApiClient *client = [[SBApiClient alloc] initWithQuery:SBBookEndpointNew];
    [client fetch:^(id _Nullable obj, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        NSArray *books = [self _parsing:obj];
        completion(books);
    }];
}

+ (void)fetchSearchBooks:(NSString *)text page:(NSString *)page completion:(void (^)(SBPagination * _Nullable result))completion {
    SBApiClient *client= [[SBApiClient sharedInstance] initWithQuery:SBBookEndpointSearch];
    [client setKeyword:text page:page];
    [client fetch:^(NSDictionary * _Nullable obj, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        if (obj) {
            SBPagination *pagination = [[SBPagination alloc] init];
            pagination.list = [NSMutableArray arrayWithArray:[self _parsing:obj]];
            NSInteger page = ((NSString *)obj[@"page"]).integerValue;
            pagination.page = page;
            NSInteger total = ((NSString *)obj[@"total"]).integerValue;
            pagination.pageMoreExist = page*10 - total > 0 ? NO : YES;
            completion(pagination);
            return;
        }
        NSLog(@"Fetched nil obj");
        completion(nil);
    }];
}

+ (void)fetchBookDetail:(NSString *)isbn completion:(void (^)(SBBookDetailModel * _Nullable result))completion {
    SBApiClient *client = [[SBApiClient alloc] initWithQuery:SBBookEndpointBooks];
    [client setISBN:isbn];
    [client fetch:^(NSDictionary * _Nullable obj, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        if (obj) {
            SBBookDetailModel *b = [[SBBookDetailModel alloc] init];
            b.title = obj[@"title"];
            b.subtitle = obj[@"subtitle"];
            b.image = obj[@"image"];
            b.isbn10 = obj[@"isbn10"];
            b.isbn13 = obj[@"isbn13"];
            b.price = obj[@"price"];
            b.image = obj[@"image"];
            b.url = obj[@"url"];
            b.pages = obj[@"pages"];
            b.year = obj[@"year"];
            b.rating = obj[@"rating"];
            b.authors = obj[@"authors"];
            b.publisher = obj[@"publisher"];
            b.desc = obj[@"desc"];
            b.pdf = obj[@"pdf"];
            completion(b);
            return;
        }
        NSLog(@"Fetched nil obj");
        completion(nil);
    }];
}

+ (NSArray *)_parsing:(id)data {
    NSMutableArray *books = [NSMutableArray array];
    for (NSDictionary<NSString *, NSString *>*book in data[@"books"]) {
        SBBookModel *b = [[SBBookModel alloc] init];
        b.title = book[@"title"];
        b.subtitle = book[@"subtitle"];
        b.image = book[@"image"];
        b.isbn13 = book[@"isbn13"];
        b.price = book[@"price"];
        b.image = book[@"image"];
        b.url = book[@"url"];
        [books addObject:b];
    }
    return books;
}

@end
