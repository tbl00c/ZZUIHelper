//
//  ZZControlListItem.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/2.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlListItem.h"

@interface ZZControlListItem ()

@property (weak) IBOutlet NSView *bgView;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSBox *horizontalLine;
@property (weak) IBOutlet NSImageView *controlImageView;

@end

@implementation ZZControlListItem

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bgView setWantsLayer:YES];
    [self.bgView.layer setBackgroundColor:[NSColor colorWithRed:204.0/255.0 green:222.0/255.0 blue:238.0/255.0 alpha:0.7].CGColor];
    [self.bgView.layer setBorderWidth:1];
    [self.bgView.layer setBorderColor:[NSColor grayColor].CGColor];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(NSEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.controlImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.left.mas_equalTo(13);
        make.width.mas_equalTo(self.controlImageView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-1);
        make.left.mas_equalTo(self.controlImageView.mas_right).mas_offset(13);
        make.right.mas_lessThanOrEqualTo(-13);
    }];
    
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    
    [self.bgView setHidden:!self.selected];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    self.titleLabel.stringValue = buttonTitle;
    [self.controlImageView setImage:[NSImage imageNamed:buttonTitle]];
    [self.bgView setHidden:!self.selected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.bgView setHidden:!selected];
}

@end
