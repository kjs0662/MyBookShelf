//
//  SBFetchHelper.h
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/01.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SBBookHostURL;
extern NSString *const SBBookEndpointSearch;
extern NSString *const SBBookEndpointNew;
extern NSString *const SBBookEndpointBooks;

@interface SBApiClient : NSObject

@property (class, strong, nonatomic, readonly, nonnull) SBApiClient *sharedInstance;

- (instancetype)initWithQuery:(nonnull NSString *)query;
- (void)fetch:(void (^)(NSDictionary * _Nullable obj, NSError * _Nullable error))completionHandler;
- (void)setKeyword:(nonnull NSString *)keyword page:(nonnull NSString *)page;
- (void)setISBN:(nonnull NSString *)isbn;

@end

NS_ASSUME_NONNULL_END
