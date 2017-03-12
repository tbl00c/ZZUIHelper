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
@synthesize layouts = _layouts;
@synthesize superViewNameProperty = _superViewNameProperty;

- (void)setSuperViewName:(NSString *)superViewName
{
    [self.superViewNameProperty setValue:superViewName];
}
- (NSString *)superViewName
{
    return self.superViewNameProperty.value;
}
- (ZZProperty *)superViewNameProperty
{
    if (!_superViewNameProperty) {
        _superViewNameProperty = [[ZZProperty alloc] initWithPropertyName:@"superView" selectionData:@[] defaultValue:nil editable:NO];
    }
    return _superViewNameProperty;
}

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
        ZZProperty *contentMode = [[ZZProperty alloc] initWithPropertyName:@"contentMode" selectionData:[ZZUIHelperConfig sharedInstance].contentMode andDefaultSelectIndex:0];
        
        // 用户响应
        ZZProperty *userInteractionEnabled = [[ZZProperty alloc] initWithPropertyName:@"userInteractionEnabled" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *multipleTouch = [[ZZProperty alloc] initWithPropertyName:@"multipleTouchEnabled" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        // 颜色
        ZZProperty *alpha = [[ZZProperty alloc] initWithPropertyName:@"alpha" type:ZZPropertyTypeNumber defaultValue:@(1)];
        ZZProperty *backgroundColor = [[ZZProperty alloc] initWithPropertyName:@"backgroundColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"clearColor" editable:YES];
        [backgroundColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setBackgroundColor:[UIColor %@]", value];
        }];
        ZZProperty *tintColor = [[ZZProperty alloc] initWithPropertyName:@"tintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"blueColor" editable:YES];
        [tintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTintColor:[UIColor %@]", value];
        }];
        
        ZZProperty *opaque = [[ZZProperty alloc] initWithPropertyName:@"opaque" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *hidden = [[ZZProperty alloc] initWithPropertyName:@"hidden" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *clipsToBounds = [[ZZProperty alloc] initWithPropertyName:@"clipsToBounds" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIView" properties:@[frame, contentMode, tag, userInteractionEnabled, multipleTouch, alpha, backgroundColor, tintColor, opaque, hidden, clipsToBounds]];
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

- (NSMutableArray *)layouts
{
    if (!_layouts) {
        _layouts = [[NSMutableArray alloc] init];
    }
    return _layouts;
}

@end
