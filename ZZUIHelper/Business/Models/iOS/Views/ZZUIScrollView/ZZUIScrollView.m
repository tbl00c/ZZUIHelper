//
//  ZZUIScrollView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollView.h"
#import "ZZUIScrollViewDelegate.h"

@implementation ZZUIScrollView
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUIScrollViewDelegate *delegate = [[ZZUIScrollViewDelegate alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        for (ZZPropertyGroup *group in _properties) {
            for (ZZProperty *property in group.properties) {
                if ([property.propertyName isEqualToString:@"userInteractionEnabled"]) {
                    property.defaultValue = @(YES);
                }
            }
        }
        ZZProperty *delegate = [[ZZProperty alloc] initWithPropertyName:@"delegate" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZProperty *pagingEnabled = [[ZZProperty alloc] initWithPropertyName:@"pagingEnabled" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *scrollEnabled = [[ZZProperty alloc] initWithPropertyName:@"scrollEnabled" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *scrollsToTop = [[ZZProperty alloc] initWithPropertyName:@"scrollsToTop" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *bounces = [[ZZProperty alloc] initWithPropertyName:@"bounces" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *alwaysBounceVertical = [[ZZProperty alloc] initWithPropertyName:@"alwaysBounceVertical" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *alwaysBounceHorizontal = [[ZZProperty alloc] initWithPropertyName:@"alwaysBounceHorizontal" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *showsHorizontalScrollIndicator = [[ZZProperty alloc] initWithPropertyName:@"showsHorizontalScrollIndicator" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *showsVerticalScrollIndicator = [[ZZProperty alloc] initWithPropertyName:@"showsVerticalScrollIndicator" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIScrollView" properties:@[pagingEnabled, scrollEnabled, scrollsToTop, bounces, alwaysBounceVertical, alwaysBounceHorizontal, showsVerticalScrollIndicator, showsHorizontalScrollIndicator] privateProperties:@[delegate]];
        [_properties addObject:group];
    }
    
    return _properties;
}

@end
