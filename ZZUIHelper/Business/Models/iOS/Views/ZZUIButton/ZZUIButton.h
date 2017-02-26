//
//  ZZUIButton.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIControl.h"

@interface ZZUIButton : ZZUIControl

@property (nonatomic, strong, readonly) ZZMethod *actionTouchDown;
@property (nonatomic, strong, readonly) ZZMethod *actionTouchDownRepeat;
@property (nonatomic, strong, readonly) ZZMethod *actionTouchUpInside;
@property (nonatomic, strong, readonly) ZZMethod *actionTouchUpOutside;
@property (nonatomic, strong, readonly) ZZMethod *actionTouchCancel;


@end
