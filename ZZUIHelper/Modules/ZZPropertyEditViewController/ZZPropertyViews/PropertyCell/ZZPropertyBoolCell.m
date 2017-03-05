//
//  ZZPropertyBoolCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyBoolCell.h"

@interface ZZPropertyBoolCell ()

@property (weak) IBOutlet NSButton *checkButton;

@end

@implementation ZZPropertyBoolCell

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
    }];
}

- (void)setProperty:(ZZProperty *)property
{
    _property = property;
    [self.checkButton setTitle:property.propertyName];
    [self.checkButton setState:[property.value boolValue]];
}

- (IBAction)checkButtonClick:(NSButton *)sender {
    self.property.value = @(sender.state);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}


@end
