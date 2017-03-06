//
//  ZZUITextView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextView.h"
#import "ZZUITextViewDelegate.h"

@implementation ZZUITextView
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITextViewDelegate *delegate = [[ZZUITextViewDelegate alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *fontSize = [[ZZProperty alloc] initWithPropertyName:@"fontSize" type:ZZPropertyTypeString defaultValue:@"17"];
        [fontSize setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setFont:[UIFont systemFontOfSize:%@]", value];
        }];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeObject defaultValue:@"blackColor"];
        [textColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTextColor:[UIColor %@]", value];
        }];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZControlHelper sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *editable = [[ZZProperty alloc] initWithPropertyName:@"editable" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *selectable = [[ZZProperty alloc] initWithPropertyName:@"selectable" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITextField" properties:@[text, fontSize, textColor, textAlignment, editable, selectable]];
        [_properties addObject:group];
    }
    return _properties;
}


@end
