//
//  ZZClassHelper.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZUIResponder+ClassHelper.h"

@interface ZZClassHelper : NSObject

+ (ZZClassHelper *)sharedInstance;

@property (nonatomic, strong) ZZUIResponder *curClass;

@property (nonatomic, strong, readonly) NSArray *properties;

@property (nonatomic, strong, readonly) NSArray *superClassArray;

- (BOOL)canNamed:(NSString *)name;

@end
