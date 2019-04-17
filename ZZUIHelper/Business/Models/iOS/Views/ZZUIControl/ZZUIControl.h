//
//  ZZUIControl.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"
#import "ZZEvent.h"

#define     NOR_ZZUIControl             @"UIControlStateNormal"
#define     HL_ZZUIControl              @"UIControlStateHighlighted"
#define     SEL_ZZUIControl             @"UIControlStateSelected"
#define     DIS_ZZUIControl             @"UIControlStateDisabled"

@interface ZZUIControl : ZZUIView

@property (nonatomic, strong, readonly) NSArray<ZZEvent *> *events;

@property (nonatomic, strong, readonly) NSString *eventsCode;

@end
