//
//  ZZUITableView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableView.h"
#import "ZZUITableViewDelegate.h"
#import "ZZUITableViewDataSource.h"

@implementation ZZUITableView
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITableViewDataSource *dataSource = [[ZZUITableViewDataSource alloc] init];
        ZZUITableViewDelegate *delegate = [[ZZUITableViewDelegate alloc] init];
        _delegates = @[dataSource, delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *dataSource = [[ZZProperty alloc] initWithPropertyName:@"dataSource" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZProperty *rowHeight = [[ZZProperty alloc] initWithPropertyName:@"rowHeight" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *sectionHeaderHeight = [[ZZProperty alloc] initWithPropertyName:@"sectionHeaderHeight" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *sectionFooterHeight = [[ZZProperty alloc] initWithPropertyName:@"sectionFooterHeight" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *separatorInset = [[ZZProperty alloc] initWithPropertyName:@"separatorInset" type:ZZPropertyTypeObject defaultValue:@"NSEdgeInsetsZero"];
        ZZProperty *editing = [[ZZProperty alloc] initWithPropertyName:@"editing" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITableView" properties:@[rowHeight, sectionHeaderHeight, sectionFooterHeight, separatorInset, editing] privateProperties:@[dataSource]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
