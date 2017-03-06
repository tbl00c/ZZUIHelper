//
//  ZZUICollectionViewFlowLayout.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewFlowLayout.h"
#import "ZZUICollectionViewDelegateFlowLayout.h"

@implementation ZZUICollectionViewFlowLayout
@synthesize delegates = _delegates;
@synthesize properties = _properties;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUICollectionViewDelegateFlowLayout *delegate = [[ZZUICollectionViewDelegateFlowLayout alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *minimumLineSpacing = [[ZZProperty alloc] initWithPropertyName:@"minimumLineSpacing" type:ZZPropertyTypeNumber defaultValue:@(0) selecetd:YES];
        ZZProperty *minimumInteritemSpacing = [[ZZProperty alloc] initWithPropertyName:@"minimumInteritemSpacing" type:ZZPropertyTypeNumber defaultValue:@(0) selecetd:YES];
        ZZProperty *itemSize = [[ZZProperty alloc] initWithPropertyName:@"itemSize" type:ZZPropertyTypeSize defaultValue:nil selecetd:YES];
        ZZProperty *headerReferenceSize = [[ZZProperty alloc] initWithPropertyName:@"headerReferenceSize" type:ZZPropertyTypeSize defaultValue:nil selecetd:YES];
        ZZProperty *footerReferenceSize = [[ZZProperty alloc] initWithPropertyName:@"footerReferenceSize" type:ZZPropertyTypeSize defaultValue:nil selecetd:YES];
        ZZProperty *sectionInset = [[ZZProperty alloc] initWithPropertyName:@"sectionInset" type:ZZPropertyTypeEdgeInsets defaultValue:nil selecetd:YES];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UICollectionViewFlowLayout" properties:@[minimumLineSpacing, minimumInteritemSpacing, itemSize, headerReferenceSize, footerReferenceSize, sectionInset]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
