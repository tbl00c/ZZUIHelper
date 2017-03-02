//
//  ZZPropertyMethodCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyMethodCell.h"

@interface ZZPropertyMethodCell ()

@property (weak) IBOutlet NSButton *checkButton;

@end

@implementation ZZPropertyMethodCell

- (void)viewDidLoad
{
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setMethod:(ZZMethod *)method
{
    _method = method;
    [self.checkButton setTitle:method.methodNameWithoutParams];
    [self.checkButton setState:method.selected];
}

#pragma mark - # Event Response
- (IBAction)checkButtonClick:(NSButton *)sender {
    self.method.selected = sender.state;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}
@end
