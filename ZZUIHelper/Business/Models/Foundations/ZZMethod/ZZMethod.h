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

@property (nonatomic, assign) BOOL selected;

#pragma mark - # 方法名
/// 方法名
@property (nonatomic, strong) NSString *methodName;

/// 方法名（不包含返回值类型和参数）
@property (nonatomic, strong, readonly) NSString *methodNameWithoutParams;

/// 返回值类型
@property (nonatomic, strong, readonly) NSString *returnType;

/// 备注
@property (nonatomic, strong) NSString *remarks;

#pragma mark - # 方法内容
/// 方法体
@property (nonatomic, strong, readonly) NSString *methodContent;

- (id)initWithMethodName:(NSString *)methodName;

- (id)initWithMethodName:(NSString *)methodName selected:(BOOL)selected;

/**
 * 添加方法体代码块
 */
- (void)addMethodContentCode:(NSString *)code;

/**
 * 清空方法体代码
 */
- (BOOL)clearMethodContent;

@end
