//
//  ZZCreatorManager.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorManager.h"
#import "ZZLazyLoadCreator.h"
#import "ZZSetupCreator.h"

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
        // 惰性初始化
        ZZLazyLoadCreator *lazyLoadCreator = [[ZZLazyLoadCreator alloc] init];
        ZZCreatorModel *lazyLoadModel = [[ZZCreatorModel alloc] initWithName:@"Lazy Load Creator" andCreator:lazyLoadCreator];
        [lazyLoadModel setDes:@"通过惰性初始化的方式添加UI"];
        
        // setup
        ZZSetupCreator *setupCreator = [[ZZSetupCreator alloc] init];
        ZZCreatorModel *setupModel = [[ZZCreatorModel alloc] initWithName:@"Setup Creator" andCreator:setupCreator];
        [setupModel setDes:@"通过在setup方法中初始化UI"];
        
        _creatorList = @[lazyLoadModel, setupModel];
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
    self.curCreator = [self.creatorList[curCreatorIndex] creator];
    [[NSUserDefaults standardUserDefaults] setObject:@(curCreatorIndex) forKey:@"curCreatorIndex"];
}

@end
