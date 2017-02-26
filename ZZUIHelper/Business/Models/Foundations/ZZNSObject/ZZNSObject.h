//
//  ZZNSObject.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMethod.h"

@interface ZZNSObject : NSObject

#pragma mark - # 类名
/// 类名
@property (nonatomic, strong) NSString *className;
/// 父类类名
@property (nonatomic, strong) NSString *superClassName;

#pragma mark - # 属性代码
/// 属性名
@property (nonatomic, strong) NSString *propertyName;

/// 备注
@property (nonatomic, strong) NSString *remarks;

/// 声明代码
@property (nonatomic, strong, readonly) NSString *propertyCode;

/// Getter方法代码
@property (nonatomic, strong, readonly) NSString *getterCode;
- (NSArray *)getterCodeExtCode;

/// Delegate代码
@property (nonatomic, strong, readonly) NSString *delegateCode;

@end
