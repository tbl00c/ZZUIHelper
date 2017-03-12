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
            for (ZZProperty *property in group.properties) {
                if ([property.propertyName isEqualToString:@"userInteractionEnabled"]) {
                    property.defaultValue = @(NO);
                    break;
                }
            }
        }
        
        ZZProperty *imageName = [[ZZProperty alloc] initWithPropertyName:@"imageName" type:ZZPropertyTypeObject defaultValue:@""];
        [imageName setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        ZZProperty *highlightedImage = [[ZZProperty alloc] initWithPropertyName:@"highlightedImage" type:ZZPropertyTypeObject defaultValue:@""];
        [highlightedImage setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setHighlightedImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        ZZProperty *highlighted = [[ZZProperty alloc] initWithPropertyName:@"highlighted" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIImageView" properties:@[imageName, highlightedImage, highlighted]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
