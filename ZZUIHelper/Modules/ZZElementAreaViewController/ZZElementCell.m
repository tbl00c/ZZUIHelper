//
//  ZZElementCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZElementCell.h"

@interface ZZElementCell ()

@property (weak) IBOutlet NSTextField *classNameLabel;
@property (weak) IBOutlet NSTextField *propertyNameLabel;
@property (weak) IBOutlet NSTextField *remarksLabel;

@end

@implementation ZZElementCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
    }];
    [self.propertyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.classNameLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.classNameLabel);
        make.right.mas_lessThanOrEqualTo(self);
    }];
}

- (void)setObject:(ZZNSObject *)object
{
    _object = object;
    self.classNameLabel.stringValue = [object.className stringByAppendingString:@" -"];
    self.propertyNameLabel.stringValue = object.propertyName;
    NSString *remark = [@"备注:  " stringByAppendingString:object.remarks ? object.remarks : @""];
    self.remarksLabel.stringValue = remark;
}

- (IBAction)deleteButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(elementCellDeleteButtonClick:)]) {
        [self.delegate elementCellDeleteButtonClick:self.object];
    }
}

@end
