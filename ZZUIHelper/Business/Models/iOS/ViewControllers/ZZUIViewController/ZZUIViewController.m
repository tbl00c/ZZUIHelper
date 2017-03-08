
//
//  ZZUIViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIViewController.h"

@implementation ZZUIViewController
@synthesize methodArray = _methodArray;
@synthesize loadView = _loadView;
@synthesize viewDidLoad = _viewDidLoad;
@synthesize viewWillAppear = _viewWillAppear;
@synthesize viewDidAppear = _viewDidAppear;
@synthesize viewWillDisappear = _viewWillDisappear;
@synthesize viewDidDisappear = _viewDidDisappear;
@synthesize deallocMethod = _deallocMethod;

- (NSString *)curView
{
    return @"self.view";
}

#pragma mark - # Getter
- (NSArray *)methodArray
{
    if (!_methodArray) {
        _methodArray = @[self.loadView,
                         self.viewDidLoad,
                         self.viewWillAppear,
                         self.viewDidAppear,
                         self.viewWillDisappear,
                         self.viewDidDisappear,
                         self.deallocMethod];
    }
    return _methodArray;
}

- (ZZMethod *)loadView
{
    if (!_loadView) {
        _loadView = [[ZZMethod alloc] initWithMethodName:@"- (void)loadView" selected:NO];
    }
    return _loadView;
}

- (ZZMethod *)viewDidLoad
{
    if (!_viewDidLoad) {
        _viewDidLoad = [[ZZMethod alloc] initWithMethodName:@"- (void)viewDidLoad" selected:YES];
        [_viewDidLoad addMethodContentCode:@"[super viewDidLoad];"];
    }
    return _viewDidLoad;
}

- (ZZMethod *)viewWillAppear
{
    if (!_viewWillAppear) {
        _viewWillAppear = [[ZZMethod alloc] initWithMethodName:@"- (void)viewWillAppear:(BOOL)animated" selected:NO];
        [_viewWillAppear addMethodContentCode:@"[super viewWillAppear:animated];"];
    }
    return _viewWillAppear;
}

- (ZZMethod *)viewDidAppear
{
    if (!_viewDidAppear) {
        _viewDidAppear = [[ZZMethod alloc] initWithMethodName:@"- (void)viewDidAppear:(BOOL)animated" selected:NO];
        [_viewDidAppear addMethodContentCode:@"[super viewDidAppear:animated];"];
    }
    return _viewDidAppear;
}

- (ZZMethod *)viewWillDisappear
{
    if (!_viewWillDisappear) {
        _viewWillDisappear = [[ZZMethod alloc] initWithMethodName:@"- (void)viewWillDisappear:(BOOL)animated" selected:NO];
        [_viewWillDisappear addMethodContentCode:@"[super viewWillDisappear:animated];"];
    }
    return _viewWillDisappear;
}

- (ZZMethod *)viewDidDisappear
{
    if (!_viewDidDisappear) {
        _viewDidDisappear = [[ZZMethod alloc] initWithMethodName:@"- (void)viewDidDisappear:(BOOL)animated" selected:NO];
        [_viewDidDisappear addMethodContentCode:@"[super viewDidDisappear:animated];"];
    }
    return _viewDidDisappear;
}

- (ZZMethod *)deallocMethod
{
    if (!_deallocMethod) {
        _deallocMethod = [[ZZMethod alloc] initWithMethodName:@"- (void)dealloc" selected:NO];
    }
    return _deallocMethod;
}

@end
