//
//  ZZUIControl.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"
#import "ZZEvent.h"

@interface ZZUIControl : ZZUIView

@property (nonatomic, strong, readonly) NSArray<ZZEvent *> *events;

@property (nonatomic, strong, readonly) NSString *eventsCode;

@end
