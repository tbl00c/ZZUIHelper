//
//  ZZEvent.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZEvent.h"

@implementation ZZEvent
@synthesize actionName = _actionName;

- (id)initWithEventType:(NSString *)eventType selected:(BOOL)selected
{
    if (self = [super init]) {
        self.eventType = eventType;
        self.selected = selected;
    }
    return self;
}

- (NSString *)actionName
{
    if (!_actionName) {
        return self.defaultActionName;
    }
    return _actionName;
}
- (void)setActionName:(NSString *)actionName
{
    _actionName = [actionName strip];
}

- (NSString *)defaultActionName
{
    NSRange range = [self.eventType rangeOfString:@"UIControlEvent"];
    NSString *eventName = [self.eventType substringFromIndex:range.length];
    NSString *actionName = [self.propertyName stringByAppendingFormat:@"%@:", eventName];
    return actionName;
}

- (ZZMethod *)method
{
    NSString *methodName = [NSString stringWithFormat:@"- (void)%@", self.actionName];
    if ([methodName hasSuffix:@":"]) {
        if (self.className) {
            methodName = [methodName stringByAppendingFormat:@"(%@ *)sender", self.className];
        }
        else {
            methodName = [methodName stringByAppendingString:@"(id)sender"];
        }
    }
    ZZMethod *method = [[ZZMethod alloc] initWithMethodName:methodName];
    return method;
}

@end
