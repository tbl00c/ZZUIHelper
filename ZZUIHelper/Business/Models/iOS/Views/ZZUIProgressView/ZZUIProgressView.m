//
//  ZZUIProgressView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIProgressView.h"

@implementation ZZUIProgressView
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        ZZProperty *progress = [[ZZProperty alloc] initWithPropertyName:@"progress" type:ZZPropertyTypeNumber defaultValue:0];

        ZZProperty *progressTintColor = [[ZZProperty alloc] initWithPropertyName:@"progressTintColor" type:ZZPropertyTypeColor defaultValue:@"blueColor"];
        ZZProperty *trackTintColor = [[ZZProperty alloc] initWithPropertyName:@"trackTintColor" type:ZZPropertyTypeColor defaultValue:@"grayColor"];
    
        ZZProperty *progressImage = [[ZZProperty alloc] initWithPropertyName:@"progressImage" type:ZZPropertyTypeImage defaultValue:@""];
        ZZProperty *trackImage = [[ZZProperty alloc] initWithPropertyName:@"trackImage" type:ZZPropertyTypeImage defaultValue:@""];
        
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIProgressView" properties:@[progress, ZZ_PROPERTY_LINE, progressTintColor, trackTintColor, ZZ_PROPERTY_LINE, progressImage, trackImage]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
