//
//  ZZUISlider.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUISlider.h"

@implementation ZZUISlider

@synthesize events = _events;
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        ZZProperty *value = [[ZZProperty alloc] initWithPropertyName:@"value" type:ZZPropertyTypeNumber defaultValue:0];
        ZZProperty *minimumValue = [[ZZProperty alloc] initWithPropertyName:@"minimumValue" type:ZZPropertyTypeNumber defaultValue:0];
        ZZProperty *maximumValue = [[ZZProperty alloc] initWithPropertyName:@"maximumValue" type:ZZPropertyTypeNumber defaultValue:@(1)];
        
        ZZProperty *minimumValueImage = [[ZZProperty alloc] initWithPropertyName:@"minimumValueImage" type:ZZPropertyTypeImage defaultValue:@""];
        ZZProperty *maximumValueImage = [[ZZProperty alloc] initWithPropertyName:@"maximumValueImage" type:ZZPropertyTypeImage defaultValue:@""];
        
        ZZProperty *minimumTrackTintColor = [[ZZProperty alloc] initWithPropertyName:@"minimumTrackTintColor" type:ZZPropertyTypeColor defaultValue:@"blueColor"];
        ZZProperty *maximumTrackTintColor = [[ZZProperty alloc] initWithPropertyName:@"maximumTrackTintColor" type:ZZPropertyTypeColor defaultValue:@"grayColor"];
        ZZProperty *thumbTintColor = [[ZZProperty alloc] initWithPropertyName:@"thumbTintColor" type:ZZPropertyTypeColor defaultValue:@"whiteColor"];
        
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIPageControl" properties:@[value, minimumValue, maximumValue, ZZ_PROPERTY_LINE, minimumValueImage, maximumValueImage, ZZ_PROPERTY_LINE, minimumTrackTintColor, maximumTrackTintColor, thumbTintColor]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *valueChanged = [[ZZEvent alloc] initWithEventType:@"UIControlEventValueChanged" selected:YES];
        _events = @[valueChanged];
    }
    return _events;
}

@end
