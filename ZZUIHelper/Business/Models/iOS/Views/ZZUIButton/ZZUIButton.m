//
//  ZZUIButton.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIButton.h"

@implementation ZZUIButton

- (NSString *)actionMethodName
{
    NSString *action = [self.propertyName hasSuffix:@"Button"] ? self.propertyName : [self.propertyName stringByAppendingString:@"Button"];
    action = [action stringByAppendingString:@"Clicked:"];
    return action;
}

- (NSString *)actionMethodRemarks
{
    NSString *remarks = self.remarks.length > 0 ? self.remarks : self.propertyName;
    remarks = [NSString stringWithFormat:@"/// %@点击事件\n", remarks];
    return remarks;
}

- (NSString *)eventType
{
    return @"UIControlEventTouchUpInside";
}

@end
