//
//  ZZPropertySelectionCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertySelectionCell.h"

@interface ZZPropertySelectionCell ()

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSPopUpButton *selectionButton;

@end

@implementation ZZPropertySelectionCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    [self.selectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(23);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setProperty:(ZZProperty *)property
{
    _property = property;
    [self.titleLabel setStringValue:property.propertyName];
    [self.selectionButton removeAllItems];
    [self.selectionButton addItemsWithTitles:property.selectionData];
    [self.selectionButton selectItemAtIndex:property.selectIndex];
}

- (IBAction)selectionButtonClick:(NSPopUpButton *)sender {
    self.property.selectIndex = sender.indexOfSelectedItem;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:self.property.propertyName];
}

@end
