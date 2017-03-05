//
//  ZZUIImageView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIImageView.h"

@implementation ZZUIImageView
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        for (ZZPropertyGroup *group in _properties) {
            for (int i = 0; i < group.properties.count; i++) {
                ZZProperty *property = group.properties[i];
                if ([property.propertyName isEqualToString:@"contentMode"]) {
                    [group removePropertiy:property];
                    i --;
                }
            }
        }
        
        ZZProperty *image = [[ZZProperty alloc] initWithPropertyName:@"image" type:ZZPropertyTypeObject defaultValue:@""];
        ZZProperty *highlightedImage = [[ZZProperty alloc] initWithPropertyName:@"highlightedImage" type:ZZPropertyTypeObject defaultValue:@""];
        ZZProperty *highlighted = [[ZZProperty alloc] initWithPropertyName:@"highlighted" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *contentMode = [[ZZProperty alloc] initWithPropertyName:@"contentMode" type:ZZPropertyTypeObject defaultValue:@"UIViewContentModeScaleToFill"];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIImageView" properties:@[image, highlightedImage, highlighted, contentMode]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
