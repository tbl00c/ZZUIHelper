//
//  ZZUICollectionViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollViewDelegate.h"

@interface ZZUICollectionViewDelegate : ZZUIScrollViewDelegate

@property (nonatomic, strong, readonly) ZZMethod *collectionView_didSelectItemAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_didDeselectItemAtIndexPath;

@end
