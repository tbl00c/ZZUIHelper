//
//  ZZEvent.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMethod.h"
#import "ZZProperty.h"

@interface ZZEvent : NSObject

@property (nonatomic, strong) NSString *className;

@property (nonatomic, strong) NSString *propertyName;

@property (nonatomic, strong) NSString *eventType;

@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) NSString *defaultActionName;

@property (nonatomic, strong, readonly) ZZMethod *method;

@property (nonatomic, strong) ZZProperty *property;

@property (nonatomic, assign) BOOL selected;

- (id)initWithEventType:(NSString *)eventType selected:(BOOL)selected;

@end
