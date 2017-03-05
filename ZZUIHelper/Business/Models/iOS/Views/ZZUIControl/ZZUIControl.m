//
//  ZZUIControl.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIControl.h"

@implementation ZZUIControl
@synthesize events = _events;

- (void)setPropertyName:(NSString *)propertyName
{
    [super setPropertyName:propertyName];
    for (ZZEvent *event in self.events) {
        [event setPropertyName:propertyName];
        [event setClassName:self.className];
    }
}

- (NSArray *)events
{
    if (!_events) {
        _events = @[];
    }
    return _events;
}

- (NSString *)eventsCode
{
    if (self.events.count > 0) {
        NSMutableString *code = [[NSMutableString alloc] init];
        for (ZZEvent *event in self.events) {
            if (event.selected) {
                if (event.method.remarks) {
                    [code appendFormat:@"%@\n", event.method.remarks];
                }
                [code appendFormat:@"%@\n", event.method.methodCode];
            }
        }
        return code;
    }
    
    return @"";
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = [super getterCodeExtCode].mutableCopy;
    for (ZZEvent *event in self.events) {
        if (event.selected) {
            [extCode addObject:[NSString stringWithFormat:@"[_%@ addTarget:self action:@selector(%@) forControlEvents:%@]", self.propertyName, event.actionName, event.eventType]];
        }
    }
    return extCode;
}


@end
