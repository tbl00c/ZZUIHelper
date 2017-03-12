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
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" selectionData:[ZZUIHelperConfig sharedInstance].fonts defaultValue:nil editable:YES];
        [font setPropertyCodeByValue:^NSString *(NSString *value) {
            if ([value isPureNumber]) {
                value = [@"systemFontOfSize:" stringByAppendingString:value];
            }
            return [NSString stringWithFormat:@"setFont:[UIFont %@]", value];
        }];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"blackColor" editable:YES];
        [textColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTextColor:[UIColor %@]", value];
        }];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZUIHelperConfig sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *numberOfLines = [[ZZProperty alloc] initWithPropertyName:@"numberOfLines" type:ZZPropertyTypeNumber defaultValue:@"1"];
        
        ZZProperty *lineBreakMode = [[ZZProperty alloc] initWithPropertyName:@"lineBreakMode" selectionData:[ZZUIHelperConfig sharedInstance].lineBreakMode andDefaultSelectIndex:0];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UILabel" properties:@[text, font, textColor, textAlignment, numberOfLines, lineBreakMode]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
