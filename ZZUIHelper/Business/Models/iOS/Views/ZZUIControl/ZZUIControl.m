//
//  ZZUIControl.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIControl.h"

@implementation ZZUIControl
@synthesize properties = _properties;
@synthesize events = _events;

- (void)setPropertyName:(NSString *)propertyName
{
    [super setPropertyName:propertyName];
    for (ZZEvent *event in self.events) {
        [event setPropertyName:propertyName];
        [event setClassName:self.className];
    }
}

- (NSArray *)events
{
    if (!_events) {
        _events = @[];
    }
    return _events;
}

- (NSString *)eventsCode
{
    if (self.events.count > 0) {
        NSMutableString *code = [[NSMutableString alloc] init];
        for (ZZEvent *event in self.events) {
            if (event.selected) {
                if (event.method.remarks) {
                    [code appendFormat:@"%@\n", event.method.remarks];
                }
                [code appendFormat:@"%@\n", event.method.methodCode];
            }
        }
        return code;
    }
    
    return @"";
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        NSMutableArray *privateProperties = [[NSMutableArray alloc] init];
        for (ZZEvent *event in self.events) {
            ZZProperty *property = event.property;
            [privateProperties addObject:property];
            
        }
        ZZProperty *enabled = [[ZZProperty alloc] initWithPropertyName:@"enabled" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *verticalAlignment = [[ZZProperty alloc] initWithPropertyName:@"contentVerticalAlignment" selectionData:[ZZUIHelperConfig sharedInstance].controlContentVerticalAlignment andDefaultSelectIndex:0];
        ZZProperty *horizontalAlignment = [[ZZProperty alloc] initWithPropertyName:@"contentHorizontalAlignment" selectionData:[ZZUIHelperConfig sharedInstance].controlContentHorizontalAlignment andDefaultSelectIndex:0];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIControl" properties:@[enabled, verticalAlignment, horizontalAlignment] privateProperties:privateProperties];
        [_properties addObject:group];
    }
    return _properties;
}


@end
