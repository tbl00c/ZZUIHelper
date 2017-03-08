//
//  ZZPropertySelectionAndEditCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertySelectionAndEditCell.h"

@interface ZZPropertySelectionAndEditCell () <NSComboBoxDelegate>

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSComboBox *comboBox;

@end

@implementation ZZPropertySelectionAndEditCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    [self.comboBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(22);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setProperty:(ZZProperty *)property
{
    _property = property;
    [self.titleLabel setStringValue:property.propertyName];
    [self.comboBox removeAllItems];
    [self.comboBox addItemsWithObjectValues:property.selectionData];
    [self.comboBox setStringValue:property.value];
}

- (IBAction)textDidChanged:(id)sender {
    self.property.selectIndex = -1;
    self.property.value = self.comboBox.stringValue;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:self.property.propertyName];
}

#pragma mark - # Delegate
//MARK: NSComboBoxDelegate
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    if (notification.object == self.comboBox && self.comboBox.indexOfSelectedItem > 0 && self.comboBox.indexOfSelectedItem < self.property.selectionData.count) {
        self.property.selectIndex = self.comboBox.indexOfSelectedItem;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:self.property.propertyName];
    }
}




@end
