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

        ZZProperty *progressTintColor = [[ZZProperty alloc] initWithPropertyName:@"progressTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"blueColor" editable:YES];
        [progressTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setProgressTintColor:[UIColor %@]", value];
        }];
        ZZProperty *trackTintColor = [[ZZProperty alloc] initWithPropertyName:@"trackTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"grayColor" editable:YES];
        [trackTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTrackTintColor:[UIColor %@]", value];
        }];
        
        ZZProperty *progressImage = [[ZZProperty alloc] initWithPropertyName:@"progressImage" type:ZZPropertyTypeObject defaultValue:@""];
        [progressImage setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setProgressImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        ZZProperty *trackImage = [[ZZProperty alloc] initWithPropertyName:@"trackImage" type:ZZPropertyTypeObject defaultValue:@""];
        [trackImage setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTrackImage:[UIImage imageNamed:@\"%@\"]",  value];
        }];
        
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIProgressView" properties:@[progress, ZZ_PROPERTY_LINE, progressTintColor, trackTintColor, ZZ_PROPERTY_LINE, progressImage, trackImage]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
