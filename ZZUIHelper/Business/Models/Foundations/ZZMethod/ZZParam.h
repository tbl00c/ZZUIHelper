//
//  ZZParam.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/25.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZParam : NSObject

@property (nonatomic, strong, readonly) NSString *param;

@property (nonatomic, strong, readonly) NSString *paramType;

@property (nonatomic, strong, readonly) NSString *paramName;

- (id)initWithParamString:(NSString *)paramString;

- (id)initWithType:(NSString *)type andName:(NSString *)name;

@end
