//
//  ZZUITextFieldDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUITextFieldDelegate : ZZProtocol

@property (nonatomic, strong, readonly) ZZMethod *textFieldShouldBeginEditing;
@property (nonatomic, strong, readonly) ZZMethod *textFieldDidBeginEditing;
@property (nonatomic, strong, readonly) ZZMethod *textFieldShouldEndEditing;
@property (nonatomic, strong, readonly) ZZMethod *textFieldDidEndEditing;
@property (nonatomic, strong, readonly) ZZMethod *textField_shouldChangeCharactersInRange_replacementString;
@property (nonatomic, strong, readonly) ZZMethod *textFieldShouldClear;
@property (nonatomic, strong, readonly) ZZMethod *textFieldShouldReturn;

@end
