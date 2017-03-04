//
//  ZZUIControl.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIControl.h"

@implementation ZZUIControl
@synthesize actionMethods = _actionMethods;

- (NSArray *)actionMethods
{
    if (!_actionMethods) {
        _actionMethods = @[];
    }
    return _actionMethods;
}

- (NSString *)actionMethodsCode
{
    if (self.actionMethods.count > 0) {
        NSMutableString *code = [[NSMutableString alloc] init];
        for (ZZMethod *method in self.actionMethods) {
            if (method.selected) {
                if (method.remarks) {
                    [code appendFormat:@"%@\n", method.remarks];
                }
                [code appendFormat:@"%@\n", method.methodCode];
            }
        }
        return code;
    }
    
    return @"";
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    for (ZZMethod *method in self.actionMethods) {
        if (method.selected) {
            [extCode addObject:[NSString stringWithFormat:@"[_%@ addTarget:self action:@selector(%@) forControlEvents:%@]", self.propertyName, method.actionName, method.eventsType]];
        }
    }
    return extCode;
}


@end
