//
//  ZZUIView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"

@implementation ZZUIView
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        _delegates = @[];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        [_properties addObjectsFromArray:self.layer.properties];
        ZZProperty *frame = [[ZZProperty alloc] initWithPropertyName:@"frame" type:ZZPropertyTypeRect defaultValue:nil];
        ZZProperty *tag = [[ZZProperty alloc] initWithPropertyName:@"tag" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *color = [[ZZProperty alloc] initWithPropertyName:@"backgroundColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultSelectIndex:0 editable:YES];
        [color setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setBackgroundColor:[UIColor %@]", value];
        }];
        ZZProperty *alpha = [[ZZProperty alloc] initWithPropertyName:@"alpha" type:ZZPropertyTypeNumber defaultValue:@(1)];
        ZZProperty *hidden = [[ZZProperty alloc] initWithPropertyName:@"hidden" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *userInteractionEnabled = [[ZZProperty alloc] initWithPropertyName:@"userInteractionEnabled" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *contentMode = [[ZZProperty alloc] initWithPropertyName:@"contentMode" selectionData:[ZZUIHelperConfig sharedInstance].contentMode andDefaultSelectIndex:0];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIView" properties:@[frame, tag, color, alpha, hidden, userInteractionEnabled, contentMode]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSString *)m_initMethodName
{
    return @"- (id)initWithFrame:(CGRect)frame";
}

- (ZZCALayer *)layer
{
    if (!_layer) {
        _layer = [[ZZCALayer alloc] init];
    }
    return _layer;
}

@end
