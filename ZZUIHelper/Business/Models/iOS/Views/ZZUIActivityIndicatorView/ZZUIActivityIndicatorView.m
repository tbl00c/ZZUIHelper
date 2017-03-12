//
//  ZZUIActivityIndicatorView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIActivityIndicatorView.h"

@implementation ZZUIActivityIndicatorView
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        ZZProperty *activityIndicatorViewStyle = [[ZZProperty alloc] initWithPropertyName:@"activityIndicatorViewStyle" selectionData:[ZZUIHelperConfig sharedInstance].activityIndicatorViewStyle andDefaultSelectIndex:1];
     
        ZZProperty *hidesWhenStopped = [[ZZProperty alloc] initWithPropertyName:@"hidesWhenStopped" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
    
        ZZProperty *color = [[ZZProperty alloc] initWithPropertyName:@"color" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"whiteColor" editable:YES];
        [color setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setColor:[UIColor %@]", value];
        }];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIActivityIndicatorView" properties:@[activityIndicatorViewStyle, color, hidesWhenStopped]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
