//
//  ZZUIViewController.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"
#import "ZZUIView.h"

@interface ZZUIViewController : ZZUIResponder

#pragma mark - # .m实现代码
/// loadView方法代码
@property (nonatomic, strong, readonly) NSString *implementationLoadViewCode;

@property (nonatomic, strong, readonly) NSArray *methodArray;

@property (nonatomic, strong, readonly) ZZMethod *loadView;
@property (nonatomic, strong, readonly) ZZMethod *viewDidLoad;
@property (nonatomic, strong, readonly) ZZMethod *viewWillAppear;
@property (nonatomic, strong, readonly) ZZMethod *viewDidAppear;
@property (nonatomic, strong, readonly) ZZMethod *viewWillDisappear;
@property (nonatomic, strong, readonly) ZZMethod *viewDidDisappear;
@property (nonatomic, strong, readonly) ZZMethod *deallocMethod;

@end
