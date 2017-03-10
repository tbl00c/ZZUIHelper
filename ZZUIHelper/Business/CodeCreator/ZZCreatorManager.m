//
//  ZZCreatorManager.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorManager.h"
#import "ZZLazyLoadCreator.h"

@implementation ZZCreatorManager

+ (ZZCreatorManager *)sharedInstance
{
    static ZZCreatorManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZZCreatorManager alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init]) {
        NSInteger index = self.curCreatorIndex < self.creatorList.count ? self.curCreatorIndex : 0;
        self.curCreator = [self.creatorList[index] creator];
    }
    return self;
}

#pragma mark - # Protocol
- (NSString *)hFileForViewClass:(ZZUIResponder *)viewClass
{
    return [self.curCreator hFileForViewClass:viewClass];
}

- (NSString *)mFileForViewClass:(ZZUIResponder *)viewClass
{
    return [self.curCreator mFileForViewClass:viewClass];
}

#pragma mark - # Getter
- (NSArray *)creatorList
{
    if (!_curCreator) {
        ZZLazyLoadCreator *lazyLoadCreator = [[ZZLazyLoadCreator alloc] init];
        ZZCreatorModel *lazyLoadModel = [[ZZCreatorModel alloc] initWithName:@"Lazy Load" andCreator:lazyLoadCreator];
        _creatorList = @[lazyLoadModel];
    }
    return _creatorList;
}

- (NSInteger)curCreatorIndex
{
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curCreatorIndex"] integerValue];
    return index;
}
- (void)setCurCreatorIndex:(NSInteger)curCreatorIndex
{
    [[NSUserDefaults standardUserDefaults] setObject:@(curCreatorIndex) forKey:@"curCreatorIndex"];
}

@end
