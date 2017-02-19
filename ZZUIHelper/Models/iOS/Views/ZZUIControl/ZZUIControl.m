//
//  ZZUIControl.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIControl.h"

@implementation ZZUIControl

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    if (self.actionMethodName.length > 0 && self.eventType.length > 0) {
        [extCode addObject:[NSString stringWithFormat:@"[_%@ addTarget:self action:@selector(%@) forControlEvents:%@];\n", self.propertyName, self.actionMethodName, self.eventType]];
    }
    return extCode;
}

- (NSArray *)actionMethodExtCode
{
    return @[];
}

- (NSString *)actionMethodRemarks
{
    NSString *remarks = self.remarks.length > 0 ? self.remarks : self.propertyName;
    remarks = [NSString stringWithFormat:@"/// %@点击事件\n", remarks];
    return remarks;
}

- (NSString *)actionMethod
{
    if (self.actionMethodName.length > 0 && self.eventType.length > 0) {
        NSString *actionExtCode = @"";
        NSArray *extCodes = [self actionMethodExtCode];
        if (extCodes.count > 0) {
            for (NSString *code in extCodes) {
                actionExtCode = [actionExtCode stringByAppendingFormat:@"\t\t%@", code];
            }
        }
        else {
            actionExtCode = @"\n";
        }
        
        NSString *action = @"";
        if (self.actionMethodRemarks.length > 0) {
            action = [action stringByAppendingString:self.actionMethodRemarks];
        }
        action = [action stringByAppendingString:M_ACTION(self.className, self.actionMethodName, actionExtCode)];
        return action;
    }
    return nil;
}


@end
