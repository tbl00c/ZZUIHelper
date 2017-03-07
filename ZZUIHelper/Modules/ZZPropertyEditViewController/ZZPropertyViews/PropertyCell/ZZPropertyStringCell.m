//
//  ZZPropertyStringCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyStringCell.h"

@interface ZZPropertyStringCell () <NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *valuteTextFiled;

@end

@implementation ZZPropertyStringCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    [self.valuteTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setProperty:(ZZProperty *)property
{
    _property = property;
    [self.titleLabel setStringValue:[property.propertyName stringByAppendingString:@":"]];
    [self.valuteTextFiled setStringValue:property.value];
    [self.valuteTextFiled setPlaceholderString:property.placeholder];
}

#pragma mark - # NSTextFieldDelegate
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSString *value = [obj.object stringValue];
    self.property.value = value;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}

@end
