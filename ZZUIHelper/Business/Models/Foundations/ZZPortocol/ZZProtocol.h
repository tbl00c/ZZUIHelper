//
//  ZZProtocol.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMethod.h"

@interface ZZProtocol : NSObject

@property (nonatomic, strong, readonly) NSString *className;

@property (nonatomic, strong, readonly) NSString *propertyName;

@property (nonatomic, strong, readonly) NSString *protocolName;

@property (nonatomic, strong, readonly) NSArray<ZZMethod *> *protocolMethods;

@property (nonatomic, strong, readonly) NSArray *protocolMethodsCode;

@end
