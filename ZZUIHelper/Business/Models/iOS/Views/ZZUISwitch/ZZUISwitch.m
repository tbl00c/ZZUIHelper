
//
//  ZZUISwitch.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUISwitch.h"

@implementation ZZUISwitch
@synthesize events = _events;

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *valueChanged = [[ZZEvent alloc] initWithEventType:@"UIControlEventValueChanged" selected:YES];
        _events = @[valueChanged];
    }
    return _events;
}

@end
