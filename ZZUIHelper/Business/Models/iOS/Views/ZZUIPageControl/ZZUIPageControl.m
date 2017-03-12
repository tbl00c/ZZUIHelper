//
//  ZZUIPageControl.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIPageControl.h"

@implementation ZZUIPageControl
@synthesize events = _events;
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        ZZProperty *numberOfPages = [[ZZProperty alloc] initWithPropertyName:@"numberOfPages" type:ZZPropertyTypeNumber defaultValue:0];
        ZZProperty *currentPage = [[ZZProperty alloc] initWithPropertyName:@"currentPage" type:ZZPropertyTypeNumber defaultValue:0];

        ZZProperty *hidesForSinglePage = [[ZZProperty alloc] initWithPropertyName:@"hidesForSinglePage" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *defersCurrentPageDisplay = [[ZZProperty alloc] initWithPropertyName:@"defersCurrentPageDisplay" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        ZZProperty *pageIndicatorTintColor = [[ZZProperty alloc] initWithPropertyName:@"pageTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"whiteColor" editable:YES];
        [pageIndicatorTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setPageIndicatorTintColor:[UIColor %@]", value];
        }];
        ZZProperty *currentPageIndicatorTintColor = [[ZZProperty alloc] initWithPropertyName:@"currentPageTintColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultValue:@"whiteColor" editable:YES];
        [currentPageIndicatorTintColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setCurrentPageIndicatorTintColor:[UIColor %@]", value];
        }];
        
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIButton" properties:@[numberOfPages, currentPage, hidesForSinglePage, defersCurrentPageDisplay, pageIndicatorTintColor, currentPageIndicatorTintColor]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *valueChanged = [[ZZEvent alloc] initWithEventType:@"UIControlEventValueChanged" selected:YES];
        _events = @[valueChanged];
    }
    return _events;
}

@end
