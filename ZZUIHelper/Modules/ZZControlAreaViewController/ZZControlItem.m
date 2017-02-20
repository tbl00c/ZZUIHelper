//
//  ZZControlItem.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlItem.h"

@interface ZZControlItem ()
@property (weak) IBOutlet NSButtonCell *button;
@property (weak) IBOutlet NSTextField *titleLabel;

@end

@implementation ZZControlItem

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    self.titleLabel.stringValue = buttonTitle;
}

- (IBAction)buttonClicked:(id)sender {
    NSString *className = [@"ZZ" stringByAppendingString:self.buttonTitle];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithClassName:)]) {
        [self.delegate didSelectItemWithClassName:className];
    }
}
@end
