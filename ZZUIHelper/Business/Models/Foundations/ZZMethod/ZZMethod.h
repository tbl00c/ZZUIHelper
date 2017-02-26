//
//  ZZMethod.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/24.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZParam.h"

@interface ZZMethod : NSObject

@property (nonatomic, strong, readonly) NSString *methodCode;

@property (nonatomic, assign, readonly) BOOL isClassMethod;

@property (nonatomic, assign) BOOL selected;

#pragma mark - # 方法名
/// 方法名
@property (nonatomic, strong) NSString *methodName;

/// 方法名（不包含返回值类型和参数）
@property (nonatomic, strong, readonly) NSString *methodNameWithoutParams;

/// 返回值类型
@property (nonatomic, strong, readonly) NSString *returnType;

@property (nonatomic, strong, readonly) NSArray *params;

#pragma mark - # 方法内容
@property (nonatomic, strong) NSString *methodContent;

@property (nonatomic, strong, readonly) NSArray *methodContentArray;

- (id)initWithMethodName:(NSString *)methodName;

- (id)initWithMethodName:(NSString *)methodName selected:(BOOL)selected;

@end
