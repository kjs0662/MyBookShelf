//
//  SBFetchHelper.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/01.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBApiClient.h"
#import "SBUtils.h"

NSString *const SBBookHostURL = @"https://api.itbook.store/1.0/";
NSString *const SBBookEndpointSearch = @"search";
NSString *const SBBookEndpointNew = @"new";
NSString *const SBBookEndpointBooks = @"books";

@interface SBApiClient()

@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation SBApiClient

+ (SBApiClient *)sharedInstance {
    static SBApiClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SBApiClient alloc] init];
    });
    return shared;
}

- (instancetype)initWithQuery:(NSString *)query {
    self = [super init];
    if (self) {
        self.request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SBBookHostURL, query]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
        self.request.HTTPMethod = @"GET";
    }
    return self;
}

- (void)setISBN:(NSString *)isbn {
    NSString *newURL = [NSString stringWithFormat:@"%@/%@", self.request.URL.absoluteString, isbn];
    [self.request setURL:[NSURL URLWithString:newURL]];
}

- (void)setKeyword:(NSString *)keyword page:(NSString *)page {
    NSString *newURL = [NSString stringWithFormat:@"%@/%@/%@", self.request.URL.absoluteString, keyword, page];
    [self.request setURL:[NSURL URLWithString:newURL]];
}

- (void)fetch:(void (^)(NSDictionary * _Nullable obj, NSError * _Nullable error))completionHandler {
    if ([SBApiClient sharedInstance].task) {
        if ([SBApiClient sharedInstance].task.state == NSURLSessionTaskStateRunning) {
            [[SBApiClient sharedInstance].task cancel];
        }
    }
    [SBApiClient sharedInstance].task = [[NSURLSession sharedSession] dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        if (data) {
            NSDictionary<NSString *, id> *jsonObj = [SBUtils jsonToObject:data];
            completionHandler(jsonObj, error);
        }
    }];
    [[SBApiClient sharedInstance].task resume];
}

@end
