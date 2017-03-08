//
//  ZZUIResponder.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"

@interface ZZUIResponder : ZZNSObject

/// 当期类的容器
@property (nonatomic, strong, readonly) NSString *curView;

/// 接口中的属性列表
@property (nonatomic, strong, readonly) NSMutableArray *interfaceProperties;

/// 类拓展中的属性列表
@property (nonatomic, strong, readonly) NSMutableArray *extensionProperties;

@end
