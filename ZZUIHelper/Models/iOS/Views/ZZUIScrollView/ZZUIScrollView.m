//
//  ZZUIScrollView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollView.h"
#import "ZZUIScrollViewDelegate.h"

@implementation ZZUIScrollView

- (NSArray *)delegates
{
    ZZUIScrollViewDelegate *delegate = [[ZZUIScrollViewDelegate alloc] init];
    return @[delegate];
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDelegate:self];", self.propertyName]];
    return extCode;
}

@end
