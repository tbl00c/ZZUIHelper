//
//  ZZUITableView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableView.h"
#import "ZZUITableViewDelegate.h"
#import "ZZUITableViewDataSource.h"

@implementation ZZUITableView
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITableViewDataSource *dataSource = [[ZZUITableViewDataSource alloc] init];
        ZZUITableViewDelegate *delegate = [[ZZUITableViewDelegate alloc] init];
        _delegates = @[dataSource, delegate];
    }
    return _delegates;
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDataSource:self];", self.propertyName]];
    return extCode;
}

@end
