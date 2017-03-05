//
//  ZZUITextViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollViewDelegate.h"

@interface ZZUITextViewDelegate : ZZUIScrollViewDelegate

@property (nonatomic, strong, readonly) ZZMethod *textViewShouldBeginEditing;
@property (nonatomic, strong, readonly) ZZMethod *textViewDidBeginEditing;
@property (nonatomic, strong, readonly) ZZMethod *textViewShouldEndEditing;
@property (nonatomic, strong, readonly) ZZMethod *textViewDidEndEditing;
@property (nonatomic, strong, readonly) ZZMethod *textView_shouldChangeCharactersInRange_replacementText;
@property (nonatomic, strong, readonly) ZZMethod *textViewDidChange;
@property (nonatomic, strong, readonly) ZZMethod *textViewDidChangeSelection;

@end
