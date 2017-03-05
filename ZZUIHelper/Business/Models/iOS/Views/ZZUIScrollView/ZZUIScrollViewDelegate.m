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
@synthesize scrollViewDidScroll = _scrollViewDidScroll;
@synthesize scrollViewWillBeginDragging = _scrollViewWillBeginDragging;
@synthesize scrollViewDidEndDragging_willDecelerate = _scrollViewDidEndDragging_willDecelerate;
@synthesize scrollViewWillBeginDecelerating = _scrollViewWillBeginDecelerating;
@synthesize scrollViewDidEndDecelerating = _scrollViewDidEndDecelerating;
@synthesize scrollViewDidEndScrollingAnimation = _scrollViewDidEndScrollingAnimation;

- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *methods = [[NSMutableArray alloc] init];
        [methods addObject:self.scrollViewDidScroll];
        [methods addObject:self.scrollViewWillBeginDragging];
        [methods addObject:self.scrollViewDidEndDragging_willDecelerate];
        [methods addObject:self.scrollViewWillBeginDecelerating];
        [methods addObject:self.scrollViewDidEndDecelerating];
        [methods addObject:self.scrollViewDidEndScrollingAnimation];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [methods addObjectsFromArray:superProtocolMethods];
        _protocolMethods = methods;
    }
    return _protocolMethods;
}

#pragma mark - # Getter
- (ZZMethod *)scrollViewDidScroll
{
    if (!_scrollViewDidScroll) {
        _scrollViewDidScroll = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewDidScroll:(UIScrollView *)scrollView" selected:YES];
    }
    return _scrollViewDidScroll;
}

- (ZZMethod *)scrollViewWillBeginDragging
{
    if (!_scrollViewWillBeginDragging) {
        _scrollViewWillBeginDragging = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView" selected:YES];
    }
    return _scrollViewWillBeginDragging;
}

- (ZZMethod *)scrollViewDidEndDragging_willDecelerate
{
    if (!_scrollViewDidEndDragging_willDecelerate) {
        _scrollViewDidEndDragging_willDecelerate = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate" selected:YES];
    }
    return _scrollViewDidEndDragging_willDecelerate;
}

- (ZZMethod *)scrollViewWillBeginDecelerating
{
    if (!_scrollViewWillBeginDecelerating) {
        _scrollViewWillBeginDecelerating = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;" selected:NO];
    }
    return _scrollViewWillBeginDecelerating;
}

- (ZZMethod *)scrollViewDidEndDecelerating
{
    if (!_scrollViewDidEndDecelerating) {
        _scrollViewDidEndDecelerating = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView" selected:YES];
    }
    return _scrollViewDidEndDecelerating;
}

- (ZZMethod *)scrollViewDidEndScrollingAnimation
{
    if (!_scrollViewDidEndScrollingAnimation) {
        _scrollViewDidEndScrollingAnimation = [[ZZMethod alloc] initWithMethodName:@"- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView" selected:YES];
    }
    return _scrollViewDidEndScrollingAnimation;
}

@end
