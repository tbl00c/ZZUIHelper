//
//  ZZNSObject.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"

@interface ZZNSObject ()

@property (nonatomic, strong, readonly) ZZMethod *getterMethod;

@end

@implementation ZZNSObject
@synthesize getterMethod = _getterMethod;

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
    if (_className.length == 0) {
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
    NSArray *extCodes = [self getterCodeExtCode];
    if (extCodes.count > 0) {
        NSMutableString *getterCode = [NSMutableString stringWithFormat:@"if (!_%@) {", self.propertyName];;
        for (NSString *code in extCodes) {
            [getterCode appendFormat:@"%@\n", code];
        }
        [getterCode appendFormat:@"}\nreturn _%@;\n", self.propertyName];
        [self.getterMethod clearMethodContent];
        [self.getterMethod addMethodContentCode:getterCode];
        return [self.getterMethod.methodCode stringByAppendingString:@"\n"];
    }
    
    return @"";
}

- (ZZMethod *)getterMethod
{
    if (!_getterMethod) {
        _getterMethod = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (%@ *)%@", self.className, self.propertyName]];
    }
    return _getterMethod;
}

@end
