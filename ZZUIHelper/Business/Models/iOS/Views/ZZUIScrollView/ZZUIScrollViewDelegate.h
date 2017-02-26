//
//  ZZUIScrollViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUIScrollViewDelegate : ZZProtocol

@property (nonatomic, strong, readonly) ZZMethod *scrollViewDidScroll;
@property (nonatomic, strong, readonly) ZZMethod *scrollViewWillBeginDragging;
@property (nonatomic, strong, readonly) ZZMethod *scrollViewDidEndDragging_willDecelerate;
@property (nonatomic, strong, readonly) ZZMethod *scrollViewWillBeginDecelerating;
@property (nonatomic, strong, readonly) ZZMethod *scrollViewDidEndDecelerating;
@property (nonatomic, strong, readonly) ZZMethod *scrollViewDidEndScrollingAnimation;

@end
