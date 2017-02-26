//
//  ZZUICollectionViewDataSource.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUICollectionViewDataSource : ZZProtocol

@property (nonatomic, strong, readonly) ZZMethod *numberOfSectionsInCollectionView;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_numberOfItemsInSection;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_cellForItemAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_viewForSupplementaryElementOfKind_atIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_canMoveItemAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_moveItemAtIndexPath_toIndexPath;

@end
