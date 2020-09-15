//
//  SBUtils.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/03.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBUtils.h"

@implementation SBUtils

+ (NSCache <NSString *, UIImage *> *)sharedImageCache
{
    static NSCache <NSString *, UIImage *> *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[NSCache alloc] init];
    });
    return shared;
}

+ (void)imageForUrl:(NSString *const)url completion:(void (^)(UIImage * _Nullable image, NSError * _Nullable error))completion {
    NSURL *urlObj = [NSURL URLWithString:url];
    if (!urlObj) {
        NSError *err = [NSError errorWithDomain:@"image.cache.url" code:0 userInfo:@{NSLocalizedDescriptionKey: @"nil url from string rul"}];
        return completion(nil, err);
    }
    
    UIImage *img = [[SBUtils sharedImageCache] objectForKey:url];
    if (img) {
        return completion(img, nil);
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:urlObj];
        if (data) {
            UIImage *img = [UIImage imageWithData:data];
            if (img) {
                [[SBUtils sharedImageCache] setObject:img forKey:url];
                return completion(img, nil);
            }
        }
        NSError *err = [NSError errorWithDomain:@"image.cache.url" code:0 userInfo:@{NSLocalizedDescriptionKey: @"nil data from image url"}];
        completion(nil, err);
    });
}

+ (nullable id)jsonToObject:(NSData *)json
{
    NSError *error = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    if(error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    return jsonObj;
}

@end
