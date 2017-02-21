//
//  ZZControlItem.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlItem.h"

@interface ZZControlItem ()

@property (weak) IBOutlet NSTextField *titleLabel;

@property (weak) IBOutlet NSBox *horizontalLine;
@property (weak) IBOutlet NSBox *verticalLine;

@end

@implementation ZZControlItem

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.view);
    }];
    
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.mas_equalTo(0);
    }];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    self.titleLabel.stringValue = buttonTitle;
}

@end
