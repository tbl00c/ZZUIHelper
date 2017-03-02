//
//  ZZPropertySectionHeaderView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertySectionHeaderView.h"

@interface ZZPropertySectionHeaderView ()

@property (nonatomic, strong) NSTextField *titleLabel;

@end

@implementation ZZPropertySectionHeaderView

- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self setWantsLayer:YES];
        [self.layer setBackgroundColor:[NSColor windowBackgroundColor].CGColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(-10);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.stringValue = title;
}

- (NSTextField *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[NSTextField alloc] init];
        [_titleLabel setEditable:NO];
        [_titleLabel setBordered:NO];
        [_titleLabel setDrawsBackground:NO];
        [_titleLabel setFont:[NSFont boldSystemFontOfSize:13]];
    }
    return _titleLabel;
}

@end
