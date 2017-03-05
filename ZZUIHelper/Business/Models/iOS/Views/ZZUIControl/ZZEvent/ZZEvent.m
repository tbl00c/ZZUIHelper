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
    if (_actionName.length == 0) {
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

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self.property setSelected:selected];
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

- (ZZProperty *)property
{
    if (!_property) {
        _property = [[ZZProperty alloc] initWithPropertyName:self.eventType type:ZZPropertyTypeObject defaultValue:nil selecetd:self.selected];
        __weak typeof(self) weakSelf = self;
        [_property setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"addTarget:self action:@selector(%@) forControlEvents:%@", weakSelf.actionName, weakSelf.eventType];
        }];
    }
    return _property;
}

@end
