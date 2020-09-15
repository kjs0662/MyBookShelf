//
//  SBCoreDataContext.m
//  My Bookshelf
//
//  Created by 김진선 on 2020/09/05.
//  Copyright © 2020 JinseonKim. All rights reserved.
//

#import "SBCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface SBCoreDataManager()

@property (nonatomic, readonly) AppDelegate *appDelegate;
@property (nonatomic, readonly) NSManagedObjectContext *context;

@end

@implementation SBCoreDataManager

+ (instancetype)sharedInstance {
    static SBCoreDataManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SBCoreDataManager alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _context = self.appDelegate.persistentContainer.viewContext;
    }
    return self;
}

- (SBBookDetail *)fetchBookDetail:(NSString *)isbn {
    NSFetchRequest *reqeust = [SBBookDetail fetchRequest];
    reqeust.predicate = [NSPredicate predicateWithFormat:@"isbn13 = %@", isbn];
    NSError *error = nil;
    NSArray<SBBookDetail *> *matches = [self.context executeFetchRequest:reqeust error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    if (matches.count > 1) {
        for (SBBookDetail *book in matches) {
            [self.context deleteObject:book];
        }
        return nil;
    }
    return matches.firstObject;
}

- (void)saveBookDetail:(SBBookDetailModel *)book {
    NSFetchRequest *reqeust = [SBBookDetail fetchRequest];
    reqeust.predicate = [NSPredicate predicateWithFormat:@"isbn13 = %@", book.isbn13];
    NSError *error = nil;
    NSArray<SBBookDetail *> *matches = [self.context executeFetchRequest:reqeust error:&error];
    if (matches.count > 0) {
        for (SBBookDetail *book in matches) {
            [self.context deleteObject:book];
        }
    }
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SBBookDetail" inManagedObjectContext:self.context];
    SBBookDetail *model = [[SBBookDetail alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
    model.authors = book.authors;
    model.desc = book.desc;
    model.image = book.image;
    model.isbn10 = book.isbn10;
    model.isbn13 = book.isbn13;
    model.memo = book.memo;
    model.price = book.price;
    model.subtitle = book.subtitle;
    model.title = book.title;
    model.url = book.url;
    model.updatedDate = [NSDate now];
    [self.appDelegate saveContext];
}


@end
