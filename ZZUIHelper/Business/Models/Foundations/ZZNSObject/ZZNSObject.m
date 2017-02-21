//
//  ZZNSObject.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"

@implementation ZZNSObject

- (id)init
{
    if (self = [super init]) {
        NSString *className = NSStringFromClass([self class]);
        if ([className hasPrefix:@"ZZ"]) {
            className = [className substringFromIndex:2];
        }
        self.superClassName = className;
    }
    return self;
}

- (NSString *)className
{
    if (!_className) {
        return self.superClassName;
    }
    return _className;
}

- (NSString *)propertyCode
{
    NSString *propertyCode = @"";
    if (self.remarks.length > 0) {
        propertyCode = [propertyCode stringByAppendingFormat:@"/// %@\n", self.remarks];
    }
    propertyCode = [propertyCode stringByAppendingFormat:@"@property (nonatomic, strong) %@ *%@;\n", self.className, self.propertyName];
    return propertyCode;
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = @[].mutableCopy;
    [extCode addObject:[NSString stringWithFormat:@"_%@ = [[%@ alloc] init];", self.propertyName, self.className]];
    return extCode;
}

- (NSString *)getterCode
{
    NSString *getterCode = @"";
    NSArray *extCodes = [self getterCodeExtCode];
    for (NSString *code in extCodes) {
        getterCode = [getterCode stringByAppendingFormat:@"\t\t%@\n", code];
    }
    getterCode = M_GETTER(self.className, self.propertyName, getterCode);
    return getterCode;
}

@end
