//
//  ZZUIButton.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIButton.h"

@implementation ZZUIButton
@synthesize events = _events;

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *touchDown = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDown" selected:NO];
        ZZEvent *touchDownRepeat = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDownRepeat" selected:NO];
        ZZEvent *touchUpInside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpInside" selected:YES];
        ZZEvent *touchUpOutside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpOutside" selected:NO];
        ZZEvent *touchCancel = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchCancel" selected:NO];
        _events = @[touchDown, touchDownRepeat, touchUpInside, touchUpOutside, touchCancel];
    }
    return _events;
}


@end
