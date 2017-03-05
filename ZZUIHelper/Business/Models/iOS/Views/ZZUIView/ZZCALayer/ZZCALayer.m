//
//  ZZCALayer.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCALayer.h"

@implementation ZZCALayer
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *masksToBounds = [[ZZProperty alloc] initWithPropertyName:@"masksToBounds" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *cornerRadius = [[ZZProperty alloc] initWithPropertyName:@"cornerRadius" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *borderWidth = [[ZZProperty alloc] initWithPropertyName:@"borderWidth" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *borderColor = [[ZZProperty alloc] initWithPropertyName:@"borderColor" type:ZZPropertyTypeObject defaultValue:@"[UIColor clearColor]"];
        ZZProperty *zPosition = [[ZZProperty alloc] initWithPropertyName:@"zPosition" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *anchorPoint = [[ZZProperty alloc] initWithPropertyName:@"anchorPoint" type:ZZPropertyTypeObject defaultValue:@"CGPointMake(0.5, 0.5)"];
        ZZProperty *transform = [[ZZProperty alloc] initWithPropertyName:@"transform" type:ZZPropertyTypeObject defaultValue:@""];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"CALayer" properties:@[masksToBounds, cornerRadius, borderWidth, borderColor, zPosition, anchorPoint, transform]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
