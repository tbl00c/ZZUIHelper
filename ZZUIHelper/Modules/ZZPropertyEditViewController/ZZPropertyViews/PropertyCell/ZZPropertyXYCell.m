//
//  ZZPropertyXYCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyXYCell.h"

@interface ZZPropertyXYCell ()

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *xLabel;
@property (weak) IBOutlet NSTextField *xTextField;
@property (weak) IBOutlet NSTextField *yLabel;
@property (weak) IBOutlet NSTextField *yTextField;

@end

@implementation ZZPropertyXYCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    [self.xLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(12);
    }];
    [self.xTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
    }];
    [self.yLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xTextField.mas_right).mas_offset(20);
        make.bottom.mas_equalTo(self.xLabel);
        make.height.mas_equalTo(12);
    }];
    [self.yTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(self.xTextField);
        make.right.mas_equalTo(-10);
    }];
    
    [self.yTextField setTag:1];
}

- (void)setProperty:(ZZProperty *)property
{
    _property = property;
    [self.titleLabel setStringValue:property.propertyName];
    NSDictionary *value = property.value;
    if (property.type == ZZPropertyTypePoint) {
        [self.xLabel setStringValue:@"x"];
        [self.xTextField setStringValue:value[@"x"] ? value[@"x"] : @"0"];
        [self.yLabel setStringValue:@"y"];
        [self.yTextField setStringValue:value[@"y"] ? value[@"y"] : @"0"];
    }
    else if (property.type == ZZPropertyTypeSize) {
        [self.xLabel setStringValue:@"w"];
        [self.xTextField setStringValue:value[@"w"] ? value[@"w"] : @"0"];
        [self.yLabel setStringValue:@"h"];
        [self.yTextField setStringValue:value[@"h"] ? value[@"h"] : @"0"];
    }
}

#pragma mark - # NSTextFieldDelegate
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSTextField *tf = obj.object;
    NSString *value = tf.stringValue.length > 0 ? tf.stringValue : @"0";
    NSMutableDictionary *dic = [self.property.value mutableCopy];
    if (self.property.type == ZZPropertyTypePoint) {
        if (tf.tag == 0) {
            [dic setObject:value forKey:@"x"];
        }
        else {
            [dic setObject:value forKey:@"y"];
        }
    }
    else if (self.property.type == ZZPropertyTypeSize) {
        if (tf.tag == 0) {
            [dic setObject:value forKey:@"w"];
        }
        else {
            [dic setObject:value forKey:@"h"];
        }
    }
    self.property.value = dic;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}


@end
