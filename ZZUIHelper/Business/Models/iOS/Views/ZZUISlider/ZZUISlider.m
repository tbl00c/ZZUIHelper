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
        
        ZZProperty *minimumValueImage = [[ZZProperty alloc] initWithPropertyName:@"minimumValueImage" type:ZZPropertyTypeObject defaultValue:@""];
        [minimumValueImage setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setMinimumValueImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        ZZProperty *maximumValueImage = [[ZZProperty alloc] initWithPropertyName:@"maximumValueImage" type:ZZPropertyTypeObject defaultValue:@""];
        [maximumValueImage setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setMaximumValueImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        
        ZZProperty *minimumTrackTintColor = [[ZZProperty alloc] initWithPropertyName:@"minimumTrackTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"blueColor" editable:YES];
        [minimumTrackTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setMinimumTrackTintColor:[UIColor %@]", value];
        }];
        ZZProperty *maximumTrackTintColor = [[ZZProperty alloc] initWithPropertyName:@"maximumTrackTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"grayColor" editable:YES];
        [maximumTrackTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setMaximumTrackTintColor:[UIColor %@]", value];
        }];
        ZZProperty *thumbTintColor = [[ZZProperty alloc] initWithPropertyName:@"thumbTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"whiteColor" editable:YES];
        [thumbTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setThumbTintColor:[UIColor %@]", value];
        }];
        
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
