//
//  ZZUIControl.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"

@interface ZZUIControl : ZZUIView

@property (nonatomic, strong, readonly) NSString *actionMethodName;

@property (nonatomic, strong, readonly) NSString *actionMethodRemarks;

@property (nonatomic, strong, readonly) NSString *eventType;

@property (nonatomic, strong, readonly) NSString *actionMethod;

@property (nonatomic, strong, readonly) NSArray *actionMethodExtCode;

@end
