//
//  ZZCreatorCodeModuleCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorCodeModuleCell.h"

@interface ZZCreatorCodeModuleCell ()

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *desLabel;

@end

@implementation ZZCreatorCodeModuleCell

- (void)setModel:(ZZCreatorCodeBlock *)model
{
    _model = model;
    [self.titleLabel setStringValue:model.blockName];
    [self.desLabel setStringValue:model.remarks ? model.remarks : @""];
}

@end
