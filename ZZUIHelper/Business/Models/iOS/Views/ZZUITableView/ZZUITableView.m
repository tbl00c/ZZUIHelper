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

- (NSArray *)delegates
{
    ZZUITableViewDataSource *dataSource = [[ZZUITableViewDataSource alloc] init];
    ZZUITableViewDelegate *delegate = [[ZZUITableViewDelegate alloc] init];
    return @[dataSource, delegate];
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDataSource:self];", self.propertyName]];
    return extCode;
}

@end
