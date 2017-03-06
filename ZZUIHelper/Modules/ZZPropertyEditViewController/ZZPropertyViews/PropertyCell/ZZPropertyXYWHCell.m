//
//  ZZPropertyXYWHCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyXYWHCell.h"

@interface ZZPropertyXYWHCell ()

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *xLabel;
@property (weak) IBOutlet NSTextField *yLabel;
@property (weak) IBOutlet NSTextField *wLabel;
@property (weak) IBOutlet NSTextField *hLabel;
@property (weak) IBOutlet NSTextField *xTextField;
@property (weak) IBOutlet NSTextField *yTextField;
@property (weak) IBOutlet NSTextField *wTextField;
@property (weak) IBOutlet NSTextField *hTextField;

@end

@implementation ZZPropertyXYWHCell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_addMasonry];
    [self.yTextField setTag:1];
    [self.wTextField setTag:2];
    [self.hTextField setTag:3];
}

- (void)setProperty:(ZZProperty *)property
{
    CGFloat (^getCGFloatValueFormDic)(NSDictionary *dic, NSString *key) = ^CGFloat(NSDictionary *dic, NSString *key) {
        NSString *value = [dic objectForKey:key];
        return [value doubleValue];
    };
    _property = property;
    [self.titleLabel setStringValue:property.propertyName];
    if (property.type == ZZPropertyTypeRect) {
        CGFloat x = getCGFloatValueFormDic(property.value, @"x");
        CGFloat y = getCGFloatValueFormDic(property.value, @"y");
        CGFloat w = getCGFloatValueFormDic(property.value, @"w");
        CGFloat h = getCGFloatValueFormDic(property.value, @"h");
        [self.xLabel setStringValue:@"x"];
        [self.yLabel setStringValue:@"y"];
        [self.wLabel setStringValue:@"w"];
        [self.hLabel setStringValue:@"h"];
        [self.xTextField setStringValue:@(x).stringValue];
        [self.yTextField setStringValue:@(y).stringValue];
        [self.wTextField setStringValue:@(w).stringValue];
        [self.hTextField setStringValue:@(h).stringValue];
    }
    else if (property.type == ZZPropertyTypeEdgeInsets) {
        CGFloat t = getCGFloatValueFormDic(property.value, @"t");
        CGFloat l = getCGFloatValueFormDic(property.value, @"l");
        CGFloat b = getCGFloatValueFormDic(property.value, @"b");
        CGFloat r = getCGFloatValueFormDic(property.value, @"r");
        [self.xLabel setStringValue:@"top      "];
        [self.yLabel setStringValue:@"left    "];
        [self.wLabel setStringValue:@"bottom"];
        [self.hLabel setStringValue:@"right  "];
        [self.xTextField setStringValue:@(t).stringValue];
        [self.yTextField setStringValue:@(l).stringValue];
        [self.wTextField setStringValue:@(b).stringValue];
        [self.hTextField setStringValue:@(r).stringValue];
    }
}

#pragma mark - # NSTextFieldDelegate
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSTextField *tf = obj.object;
    NSString *value = tf.stringValue.length > 0 ? tf.stringValue : @"0";
    NSMutableDictionary *dic = [self.property.value mutableCopy];
    if (self.property.type == ZZPropertyTypeRect) {
        if (tf.tag == 0) {
            [dic setObject:value forKey:@"x"];
        }
        else if (tf.tag == 1){
            [dic setObject:value forKey:@"y"];
        }
        else if (tf.tag == 2) {
            [dic setObject:value forKey:@"w"];
        }
        else {
            [dic setObject:value forKey:@"h"];
        }
    }
    else if (self.property.type == ZZPropertyTypeEdgeInsets) {
        if (tf.tag == 0) {
            [dic setObject:value forKey:@"t"];
        }
        else if (tf.tag == 1){
            [dic setObject:value forKey:@"l"];
        }
        else if (tf.tag == 2) {
            [dic setObject:value forKey:@"b"];
        }
        else {
            [dic setObject:value forKey:@"r"];
        }
    }
    self.property.value = dic;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(7);
        make.width.mas_equalTo(100);
    }];
    [self.xLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(3);
        make.bottom.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(12);
    }];
    [self.xTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xLabel.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
    }];
    [self.yLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xTextField.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.xLabel);
        make.height.mas_equalTo(12);
    }];
    [self.yTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yLabel.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(self.xTextField);
        make.right.mas_equalTo(-10);
    }];
    
    [self.wLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.xLabel);
        make.bottom.mas_equalTo(self.wTextField);
        make.height.mas_equalTo(12);
    }];
    [self.wTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wLabel.mas_right).mas_offset(3);
        make.height.mas_equalTo(23);
        make.top.mas_equalTo(self.xTextField.mas_bottom).mas_offset(3);
    }];
    [self.hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wTextField.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.wLabel);
        make.height.mas_equalTo(12);
    }];
    [self.hTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hLabel.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(self.wTextField);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(self.wTextField);
        make.right.mas_equalTo(-10);
    }];
}

@end
