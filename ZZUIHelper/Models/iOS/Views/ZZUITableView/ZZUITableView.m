//
//  ZZUITableView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableView.h"

@implementation ZZUITableView

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDataSource:self];\n", self.propertyName]];
    return extCode;
}

@end
