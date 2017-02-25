//
//  ZZUIScrollViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollViewDelegate.h"

@interface ZZUIScrollViewDelegate ()

@property (nonatomic, strong) NSMutableArray *delegates;

@end

@implementation ZZUIScrollViewDelegate
@synthesize protocolMethods = _protocolMethods;
@synthesize protocolMethodsCode = _protocolMethodsCode;

- (NSString *)className
{
    return @"UIScrollView";
}

- (NSString *)propertyName
{
    return @"scrollView";
}

- (NSString *)protocolName
{
    return @"UIScrollViewDelegate";
}

- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *methods = [[NSMutableArray alloc] init];
        [methods addObject:@"scrollViewDidScroll:"];
        [methods addObject:@"scrollViewWillBeginDragging:"];
        [methods addObject:@"scrollViewDidEndDragging:willDecelerate:"];
        [methods addObject:@"scrollViewDidEndDecelerating:"];
        [methods addObject:@"scrollViewDidEndScrollingAnimation:"];
        _protocolMethods = methods;
    }
    return _protocolMethods;
}

- (NSArray *)protocolMethodsCode
{
    if (!_protocolMethodsCode) {
        NSMutableArray *methods = [[NSMutableArray alloc] init];
        [methods addObject:[self scrollViewDidScroll]];
        [methods addObject:[self scrollViewWillBeginDragging]];
        [methods addObject:[self scrollViewDidEndDraggingwillDecelerate]];
        [methods addObject:[self scrollViewDidEndDecelerating]];
        [methods addObject:[self scrollViewDidEndScrollingAnimation]];
        _protocolMethodsCode = methods;
    }
    return _protocolMethodsCode;
}

- (NSString *)scrollViewDidScroll
{
    NSString *code = [NSString stringWithFormat:@"- (void)scrollViewDidScroll:(%@ *)%@%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)scrollViewWillBeginDragging
{
    NSString *code = [NSString stringWithFormat:@"- (void)scrollViewWillBeginDragging:(%@ *)%@%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)scrollViewDidEndDraggingwillDecelerate
{
    NSString *code = [NSString stringWithFormat:@"- (void)scrollViewDidEndDragging:(%@ *)%@ willDecelerate:(BOOL)decelerate%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)scrollViewDidEndDecelerating
{
    NSString *code = [NSString stringWithFormat:@"- (void)scrollViewDidEndDecelerating:(%@ *)%@%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)scrollViewDidEndScrollingAnimation
{
    NSString *code = [NSString stringWithFormat:@"- (void)scrollViewDidEndScrollingAnimation:(%@ *)%@%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

@end
