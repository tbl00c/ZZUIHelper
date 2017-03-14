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

@property (nonatomic, strong) NSImageView *statusImageView;

@property (nonatomic, strong) NSView *topLine;

@property (nonatomic, strong) NSView *bottomLine;

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
        
        [self addSubview:self.statusImageView];
        [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(20);
        }];
        
        [self addSubview:self.topLine];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        [self addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setModel:(ZZPropertySectionModel *)model
{
    _model = model;
    self.titleLabel.stringValue = model.sectionTitle ? model.sectionTitle : @"";
    [self.statusImageView setHidden:model.sectionTitle.length == 0];
    [self.topLine setHidden:model.sectionTitle.length == 0];
    [self.statusImageView setImage:model.showAllItems ? [NSImage imageNamed:@"section_selected"] : [NSImage imageNamed:@"section_deselected"]];
    [self setShowBottomLine:_showBottomLine];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    if (showBottomLine && self.model && !self.model.showAllItems) {
        [self.bottomLine setHidden:NO];
    }
    else {
        [self.bottomLine setHidden:YES];
    }
}

- (void)mouseUp:(NSEvent *)event
{
    if (self.model.sectionTitle.length > 0 && self.delegate && [self.delegate respondsToSelector:@selector(didClickedPropertySectionHeaderView:)]) {
        [self.delegate didClickedPropertySectionHeaderView:self.model];
    }
}

#pragma mark - # Getter
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

- (NSView *)topLine
{
    if (!_topLine) {
        _topLine = [[NSView alloc] init];
        [_topLine setWantsLayer:YES];
        [_topLine.layer setBackgroundColor:[NSColor lightGrayColor].CGColor];
    }
    return _topLine;
}

- (NSView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[NSView alloc] init];
        [_bottomLine setWantsLayer:YES];
        [_bottomLine.layer setBackgroundColor:[NSColor lightGrayColor].CGColor];
        [_bottomLine setHidden:YES];
    }
    return _bottomLine;
}

- (NSImageView *)statusImageView
{
    if (!_statusImageView) {
        _statusImageView = [[NSImageView alloc] init];
    }
    return _statusImageView;
}

@end
