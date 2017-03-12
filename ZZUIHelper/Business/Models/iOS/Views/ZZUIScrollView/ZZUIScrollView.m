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
        ZZProperty *delegate = [[ZZProperty alloc] initWithPropertyName:@"delegate" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZProperty *pagingEnabled = [[ZZProperty alloc] initWithPropertyName:@"pagingEnabled" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *scrollEnabled = [[ZZProperty alloc] initWithPropertyName:@"scrollEnabled" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *scrollsToTop = [[ZZProperty alloc] initWithPropertyName:@"scrollsToTop" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *bounces = [[ZZProperty alloc] initWithPropertyName:@"bounces" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *alwaysBounceVertical = [[ZZProperty alloc] initWithPropertyName:@"alwaysBounceVertical" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *alwaysBounceHorizontal = [[ZZProperty alloc] initWithPropertyName:@"alwaysBounceHorizontal" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *showsHorizontalScrollIndicator = [[ZZProperty alloc] initWithPropertyName:@"showsHorizontalScrollIndicator" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *showsVerticalScrollIndicator = [[ZZProperty alloc] initWithPropertyName:@"showsVerticalScrollIndicator" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIScrollView" properties:@[scrollEnabled, pagingEnabled, scrollsToTop, ZZ_PROPERTY_LINE, bounces, alwaysBounceVertical, alwaysBounceHorizontal, ZZ_PROPERTY_LINE, showsVerticalScrollIndicator, showsHorizontalScrollIndicator] privateProperties:@[delegate]];
        [_properties addObject:group];
    }
    
    return _properties;
}

@end
