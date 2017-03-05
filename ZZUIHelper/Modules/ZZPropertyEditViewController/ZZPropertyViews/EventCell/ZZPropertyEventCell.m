//
//  ZZPropertyEventCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEventCell.h"

@interface ZZPropertyEventCell () <NSTextFieldDelegate>

@property (weak) IBOutlet NSButton *checkButton;
@property (weak) IBOutlet NSTextField *methodNameTF;
@property (weak) IBOutlet NSTextField *lineLabel;
@property (weak) IBOutlet NSBox *bottomLine;

@end

@implementation ZZPropertyEventCell

- (void)viewDidLoad
{
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(-15);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.centerY.mas_equalTo(self.methodNameTF);
    }];
    [self.methodNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineLabel.mas_right);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-15);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.and.bottom.mas_equalTo(0);
    }];
}

- (void)setEvent:(ZZEvent *)event
{
    _event = event;
    [self.checkButton setTitle:event.eventType];
    
    [self.methodNameTF setPlaceholderString:event.defaultActionName];
    if (![event.defaultActionName isEqualToString:event.actionName]) {
        [self.lineLabel setTextColor:[NSColor blackColor]];
        [self.methodNameTF setStringValue:event.actionName];
    }
    else {
        [self.lineLabel setTextColor:[NSColor lightGrayColor]];
        [self.methodNameTF setStringValue:@""];
    }
    [self.checkButton setState:event.selected];
}

#pragma mark - # NSTextFieldDelegate
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSString *actionName = [[obj.object stringValue] strip];
    self.event.actionName = actionName;
    if (![self.event.defaultActionName isEqualToString:actionName]) {
        [self.lineLabel setTextColor:[NSColor blackColor]];
        [self.methodNameTF setStringValue:self.event.actionName];
    }
    else {
        [self.lineLabel setTextColor:[NSColor lightGrayColor]];
        [self.methodNameTF setStringValue:@""];
    }
    if (self.event.selected && actionName.length > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
    }
}

#pragma mark - # Event Response
- (IBAction)checkButtonClick:(NSButton *)sender {
    self.event.selected = sender.state;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}

@end
