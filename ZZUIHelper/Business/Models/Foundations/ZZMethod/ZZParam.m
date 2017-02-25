//
//  ZZParam.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/25.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZParam.h"

@implementation ZZParam

- (id)initWithParamString:(NSString *)paramString
{
    if (self = [super init]) {
        [self setParam:paramString];
    }
    return self;
}

- (id)initWithType:(NSString *)type andName:(NSString *)name
{
    if (self = [super init]) {
        [self setParamType:type];
        [self setParamName:name];
        _param = [NSString stringWithFormat:@"(%@)%@", self.paramType, self.paramName];
    }
    return self;
}

- (void)setParam:(NSString *)param
{
    _param = param.strip;
    
    NSString *des = [_param copy];
    if (!([des hasPrefix:@"("] && [des containsString:@")"])) {
        NSLog(@"参数解析错误(括号不匹配)");
        return;
    }
    des = [[des substringFromIndex:1] strip];
    NSArray *seg = [des componentsSeparatedByString:@")"];
    if (seg.count != 2) {
        NSLog(@"参数解析错误");
        return;
    }
    
    NSString *type = seg[0];
    [self setParamType:type];
    
    NSString *name = seg[1];
    [self setParamName:name];
}

- (void)setParamType:(NSString *)paramType
{
    _paramType = paramType.strip;
}

- (void)setParamName:(NSString *)paramName
{
    _paramName = paramName.strip;
}

@end
