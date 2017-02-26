//
//  ZZUIButton.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIButton.h"

@implementation ZZUIButton
@synthesize actionTouchDown = _actionTouchDown;
@synthesize actionTouchDownRepeat = _actionTouchDownRepeat;
@synthesize actionTouchUpInside = _actionTouchUpInside;
@synthesize actionTouchUpOutside = _actionTouchUpOutside;
@synthesize actionTouchCancel = _actionTouchCancel;

- (NSArray *)actionMethods
{
    return @[self.actionTouchDown,
             self.actionTouchDownRepeat,
             self.actionTouchUpInside,
             self.actionTouchUpOutside,
             self.actionTouchCancel];
}

#pragma mark - # Getter
- (ZZMethod *)actionTouchDown
{
    if (!_actionTouchDown) {
        _actionTouchDown = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@TouchDown:(UIButton *)sender", self.propertyName] selected:NO];
    }
    return _actionTouchDown;
}

- (ZZMethod *)actionTouchDownRepeat
{
    if (!_actionTouchDownRepeat) {
        _actionTouchDownRepeat = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@TouchDownRepeat:(UIButton *)sender", self.propertyName] selected:NO];
    }
    return _actionTouchDownRepeat;
}

- (ZZMethod *)actionTouchUpInside
{
    if (!_actionTouchUpInside) {
        _actionTouchUpInside = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@Clicked:(UIButton *)sender", self.propertyName] selected:YES];
    }
    return _actionTouchUpInside;
}

- (ZZMethod *)actionTouchUpOutside
{
    if (!_actionTouchUpOutside) {
        _actionTouchUpOutside = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@TouchUpOutside:(UIButton *)sender", self.propertyName] selected:NO];
    }
    return _actionTouchUpOutside;
}

- (ZZMethod *)actionTouchCancel
{
    if (!_actionTouchCancel) {
        _actionTouchCancel = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@TouchCancel:(UIButton *)sender", self.propertyName] selected:NO];
    }
    return _actionTouchCancel;
}

@end
