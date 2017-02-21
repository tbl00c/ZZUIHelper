//
//  ZZControlItem.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlItem.h"

@interface ZZControlItem ()

@property (weak) IBOutlet NSButton *button;

@end

@implementation ZZControlItem

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    [self.button setTitle:buttonTitle];
}

- (IBAction)buttonClicked:(id)sender {
    NSString *className = [@"ZZ" stringByAppendingString:self.buttonTitle];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithClassName:)]) {
        [self.delegate didSelectItemWithClassName:className];
    }
}
@end
