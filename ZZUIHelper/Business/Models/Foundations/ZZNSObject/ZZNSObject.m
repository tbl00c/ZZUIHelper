//
//  ZZNSObject.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"
#import "ZZCALayer.h"

@implementation ZZNSObject
@synthesize properties = _properties;
@synthesize delegates = _delegates;

#pragma mark - # 类名
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

#pragma mark - # 属性代码
- (NSString *)propertyCode
{
    NSString *propertyCode = @"";
    if (self.remarks.length > 0) {
        propertyCode = [propertyCode stringByAppendingFormat:@"/// %@\n", self.remarks];
    }
    propertyCode = [propertyCode stringByAppendingFormat:@"@property (nonatomic, strong) %@ *%@;\n", self.className, self.propertyName];
    return propertyCode;
}

- (NSArray *)delegates
{
    if (!_delegates) {
        _delegates = @[];
    }
    return _delegates;
}

#pragma mark - # Getter
- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [[NSMutableArray alloc] init];
    }
    return _properties;
}

- (ZZMethod *)getterMethod
{
    ZZMethod *getterMethod = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (%@ *)%@", self.className, self.propertyName]];
    NSMutableString *getterCode = [NSMutableString stringWithFormat:@"if (!_%@) {\n", self.propertyName];
    [getterCode appendFormat:@"_%@ = %@;\n", self.propertyName, self.getterCodeInitMethodName];
    
    NSArray *properties = self.properties;
    for (ZZPropertyGroup *group in properties) {
        for (ZZProperty *item in group.properties) {
            if (item.selected) {
                if ([group.groupName isEqualToString:@"CALayer"]) {
                    [getterCode appendFormat:@"[_%@.layer %@];\n", self.propertyName, item.propertyCode];
                }
                else {
                    [getterCode appendFormat:@"[_%@ %@];\n", self.propertyName, item.propertyCode];
                }
            }
        }
        for (ZZProperty *item in group.privateProperties) {
            if (item.selected) {
                [getterCode appendFormat:@"[_%@ %@];\n", self.propertyName, item.propertyCode];
            }
        }
    }
    
    [getterCode appendFormat:@"}\nreturn _%@;\n", self.propertyName];
    [getterMethod addMethodContentCode:getterCode];
    return getterMethod;
}

- (NSString *)getterCodeInitMethodName
{
    return [NSString stringWithFormat:@"[[%@ alloc] init]", self.className];
}

- (NSString *)getterCode
{
    return [[self.getterMethod methodCode] stringByAppendingString:@"\n"];
}

@end
