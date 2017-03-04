//
//  ZZUIView.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"

@interface ZZUIView : ZZUIResponder

/// 属性
@property (nonatomic, strong) NSArray *properties;

/// 类实现初始化代码
@property (nonatomic, strong, readonly) NSString *implementationInitCode;

@property (nonatomic, strong, readonly) ZZMethod *m_initWithFrame;

@end
