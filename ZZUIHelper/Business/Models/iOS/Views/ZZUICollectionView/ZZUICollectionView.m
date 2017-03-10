//
//  ZZUICollectionView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionView.h"
#import "ZZUICollectionViewDelegate.h"
#import "ZZUICollectionViewDataSource.h"

@implementation ZZUICollectionView
@synthesize delegates = _delegates;
@synthesize properties = _properties;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUICollectionViewDataSource *dataSource = [[ZZUICollectionViewDataSource alloc] init];
        ZZUICollectionViewDelegate *delegate = [[ZZUICollectionViewDelegate alloc] init];
        _delegates = @[dataSource, delegate];
    }
    return _delegates;
}

- (NSString *)curView
{
    return @"self.contentView";
}

- (NSString *)allocInitMethodName
{
    return [NSString stringWithFormat:@"[[%@ alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout]", self.className];
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        for (ZZPropertyGroup *group in _properties) {
            for (ZZProperty *property in group.properties) {
                if ([property.propertyName isEqualToString:@"backgroundColor"]) {
                    property.selected = YES;
                    property.value = @"whiteColor";
                }
            }
        }
        
        ZZProperty *dataSource = [[ZZProperty alloc] initWithPropertyName:@"dataSource" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZProperty *allowsSelection = [[ZZProperty alloc] initWithPropertyName:@"allowsSelection" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *allowsMultipleSelection = [[ZZProperty alloc] initWithPropertyName:@"allowsMultipleSelection" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UICollectionView" properties:@[allowsSelection, allowsMultipleSelection] privateProperties:@[dataSource]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
