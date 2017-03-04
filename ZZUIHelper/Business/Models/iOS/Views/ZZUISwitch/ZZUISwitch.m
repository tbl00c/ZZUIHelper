
//
//  ZZUISwitch.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUISwitch.h"

@implementation ZZUISwitch
@synthesize actionValueChanged = _actionValueChanged;

- (NSArray *)actionMethods
{
    return @[self.actionValueChanged];
}

#pragma mark - # Getter
- (ZZMethod *)actionValueChanged
{
    if (!_actionValueChanged) {
        _actionValueChanged = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (void)%@ValueChanged:(UISwitch *)sender", self.propertyName] selected:YES];
        _actionValueChanged.eventsType = @"UIControlEventValueChanged";
    }
    return _actionValueChanged;
}

@end
