
//
//  ZZUISwitch.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUISwitch.h"

@implementation ZZUISwitch

- (NSString *)actionMethodName
{
    NSString *action = [self.propertyName stringByAppendingString:@"StateChanged:"];
    return action;
}

- (NSString *)actionMethodRemarks
{
    NSString *remarks = self.remarks.length > 0 ? self.remarks : self.propertyName;
    remarks = [NSString stringWithFormat:@"/// %@状态改变\n", remarks];
    return remarks;
}

- (NSString *)eventType
{
    return @"UIControlEventValueChanged";
}


@end
