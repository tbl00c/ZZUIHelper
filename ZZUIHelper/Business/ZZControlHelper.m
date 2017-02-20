//
//  ZZControlHelper.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlHelper.h"

@implementation ZZControlHelper

+ (ZZControlHelper *)sharedInstance
{
    static ZZControlHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ZZControlHelper alloc] init];
    });
    return helper;
}

- (NSArray *)controls
{
//    return @[@{@"ClassName" : @"UIView"}];
    return @[
             @"UIImageView",
             @"UILabel",
             @"UIButton",
             @"UIView",
             @"UITableView",
             @"UICollectionView",
             @"UITextField",
             @"UITextView",
             @"UIScrollView",
             @"UISwitch"];
}

@end
