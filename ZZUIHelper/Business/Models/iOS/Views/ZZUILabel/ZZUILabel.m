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
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *fontSize = [[ZZProperty alloc] initWithPropertyName:@"fontSize" type:ZZPropertyTypeString defaultValue:@"17"];
        [fontSize setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setFont:[UIFont systemFontOfSize:%@]", value];
        }];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeObject defaultValue:@"blackColor"];
        [textColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTextColor:[UIColor %@]", value];
        }];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZControlHelper sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *numberOfLines = [[ZZProperty alloc] initWithPropertyName:@"numberOfLines" type:ZZPropertyTypeNumber defaultValue:@"1"];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UILabel" properties:@[text, fontSize, textColor, textAlignment, numberOfLines]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
