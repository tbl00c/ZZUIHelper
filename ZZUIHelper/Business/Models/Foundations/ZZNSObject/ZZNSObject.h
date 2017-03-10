//
//  ZZNSObject.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMethod.h"
#import "ZZProperty.h"
#import "ZZProtocol.h"

@interface ZZNSObject : NSObject

#pragma mark - # 类名
/// 类名
@property (nonatomic, strong) NSString *className;

/// 父类类名
@property (nonatomic, strong) NSString *superClassName;

#pragma mark - # 属性代码
/// 属性名
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) ZZProperty *propertyNameProperty;

/// 备注
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) ZZProperty *remarksProperty;

/// 声明代码
@property (nonatomic, strong, readonly) NSString *propertyCode;

@property (nonatomic, strong, readonly) NSArray *delegates;

#pragma mark - # Getter
/// Getter方法
@property (nonatomic, strong, readonly) ZZMethod *getterMethod;
@property (nonatomic, strong, readonly) NSString *getterCode;
/// setup方法
@property (nonatomic, strong, readonly) ZZMethod *setupMethod;
@property (nonatomic, strong, readonly) NSString *setupCode;

@property (nonatomic, strong) NSString *getterCodeInitMethodName;

/// 属性
@property (nonatomic, strong, readonly) NSMutableArray *properties;

@end
