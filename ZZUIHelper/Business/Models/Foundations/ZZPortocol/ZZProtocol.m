//
//  ZZProtocol.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@implementation ZZProtocol

- (NSString *)protocolName
{
    NSString *protocolName = NSStringFromClass([self class]);
    if ([protocolName hasPrefix:@"ZZ"]) {
        protocolName = [protocolName substringFromIndex:2];
    }
    return protocolName;
}

- (NSString *)protocolCode
{
    NSString *code = @"";
    for (ZZMethod *method in self.protocolMethods) {
        if (method.selected) {
            code = [code stringByAppendingFormat:@"%@\n", method.methodCode];
        }
    }
    return code;
}

@end
