//
//  ZZUITextField.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextField.h"
#import "ZZUITextFieldDelegate.h"

@implementation ZZUITextField
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITextFieldDelegate *delegate = [[ZZUITextFieldDelegate alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *placeholder = [[ZZProperty alloc] initWithPropertyName:@"placeholder" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" selectionData:[ZZUIHelperConfig sharedInstance].fonts defaultSelectIndex:7 editable:YES];
        [font setSelected:YES];
        [font setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setFont:[UIFont %@]", value];
        }];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" selectionData:[ZZUIHelperConfig sharedInstance].colors defaultSelectIndex:2 editable:YES];
        [textColor setSelected:YES];
        [textColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTextColor:[UIColor %@]", value];
        }];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZUIHelperConfig sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *delegate = [[ZZProperty alloc] initWithPropertyName:@"delegate" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITextField" properties:@[text, placeholder, font, textColor, textAlignment] privateProperties:@[delegate]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
