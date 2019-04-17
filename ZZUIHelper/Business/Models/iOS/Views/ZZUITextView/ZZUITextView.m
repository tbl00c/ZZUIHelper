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
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" type:ZZPropertyTypeFont defaultValue:nil];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeColor defaultValue:@"blackColor" selecetd:YES];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZUIHelperConfig sharedInstance].textAlignment andDefaultSelectIndex:0];
        ZZProperty *editable = [[ZZProperty alloc] initWithPropertyName:@"editable" type:ZZPropertyTypeBOOL defaultValue:@(YES)];
        ZZProperty *selectable = [[ZZProperty alloc] initWithPropertyName:@"selectable" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        ZZProperty *borderStyle = [[ZZProperty alloc] initWithPropertyName:@"borderStyle" selectionData:[ZZUIHelperConfig sharedInstance].borderStyle andDefaultSelectIndex:0];
        
        ZZProperty *clearButtonMode = [[ZZProperty alloc] initWithPropertyName:@"clearButtonMode" selectionData:[ZZUIHelperConfig sharedInstance].clearButtonModel andDefaultSelectIndex:0];
        ZZProperty *clearsOnBeginEditing = [[ZZProperty alloc] initWithPropertyName:@"clearsOnBeginEditing" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        // 键盘
        ZZProperty *keyboardType = [[ZZProperty alloc] initWithPropertyName:@"keyboardType" selectionData:[ZZUIHelperConfig sharedInstance].keyboardType andDefaultSelectIndex:0];
        ZZProperty *returnKeyType = [[ZZProperty alloc] initWithPropertyName:@"returnKeyType" selectionData:[ZZUIHelperConfig sharedInstance].returnKeyType andDefaultSelectIndex:0];
        ZZProperty *keyboardAppearance = [[ZZProperty alloc] initWithPropertyName:@"keyboardAppearance" selectionData:[ZZUIHelperConfig sharedInstance].keyboardAppearance andDefaultSelectIndex:0];
        
        
        ZZProperty *enablesReturnKeyAutomatically = [[ZZProperty alloc] initWithPropertyName:@"enablesReturnKeyAutomatically" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *secureTextEntry = [[ZZProperty alloc] initWithPropertyName:@"secureTextEntry" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITextView" properties:@[text, font, textColor, textAlignment, ZZ_PROPERTY_LINE, editable, selectable, ZZ_PROPERTY_LINE, borderStyle, ZZ_PROPERTY_LINE, clearButtonMode, clearsOnBeginEditing, ZZ_PROPERTY_LINE, keyboardType, returnKeyType, keyboardAppearance, enablesReturnKeyAutomatically, secureTextEntry]];
        [_properties addObject:group];
    }
    return _properties;
}


@end
