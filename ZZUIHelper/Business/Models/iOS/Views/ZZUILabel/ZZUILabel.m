//
//  ZZUILabel.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUILabel.h"

@implementation ZZUILabel
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
        
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" type:ZZPropertyTypeFont defaultValue:nil];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeColor defaultValue:@"blackColor"];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZUIHelperConfig sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *numberOfLines = [[ZZProperty alloc] initWithPropertyName:@"numberOfLines" type:ZZPropertyTypeNumber defaultValue:@"1"];
        
        ZZProperty *lineBreakMode = [[ZZProperty alloc] initWithPropertyName:@"lineBreakMode" selectionData:[ZZUIHelperConfig sharedInstance].lineBreakMode andDefaultSelectIndex:0];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UILabel" properties:@[text, font, textColor, textAlignment, numberOfLines, lineBreakMode]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
