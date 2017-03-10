//
//  ZZCreatorSelectorCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorSelectorCell.h"

@interface ZZCreatorSelectorCell ()

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *defaultLabel;
@property (weak) IBOutlet NSTextField *desLabel;

@end

@implementation ZZCreatorSelectorCell

- (void)setModel:(ZZCreatorModel *)model
{
    [self.titleLabel setStringValue:model.name];
    [self.desLabel setStringValue:model.des];
}

- (void)setIsDefault:(BOOL)isDefault
{
    [self.defaultLabel setHidden:!isDefault];
}

@end
