//
//  ZZPropertyLineCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyLineCell.h"

@interface ZZPropertyLineCell ()

@property (weak) IBOutlet NSBox *line;

@end

@implementation ZZPropertyLineCell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
    }];
}

@end
