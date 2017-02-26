//
//  ZZUIScrollViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUIScrollViewDelegate : ZZProtocol

@property (nonatomic, strong) ZZMethod *scrollViewDidScroll;

@property (nonatomic, strong) ZZMethod *scrollViewWillBeginDragging;

@property (nonatomic, strong) ZZMethod *scrollViewDidEndDragging_willDecelerate;

@property (nonatomic, strong) ZZMethod *scrollViewWillBeginDecelerating;

@property (nonatomic, strong) ZZMethod *scrollViewDidEndDecelerating;

@property (nonatomic, strong) ZZMethod *scrollViewDidEndScrollingAnimation;

@end
