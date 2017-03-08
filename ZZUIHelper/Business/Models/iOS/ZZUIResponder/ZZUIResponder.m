//
//  ZZUIResponder.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"

@implementation ZZUIResponder
@synthesize interfaceProperties = _interfaceProperties;
@synthesize extensionProperties = _extensionProperties;

- (NSString *)curView
{
    return @"self";
}

- (NSMutableArray *)interfaceProperties
{
    if (!_interfaceProperties) {
        _interfaceProperties = [[NSMutableArray alloc] init];
    }
    return _interfaceProperties;
}

- (NSMutableArray *)extensionProperties
{
    if (!_extensionProperties) {
        _extensionProperties = [[NSMutableArray alloc] init];
    }
    return _extensionProperties;
}

@end
