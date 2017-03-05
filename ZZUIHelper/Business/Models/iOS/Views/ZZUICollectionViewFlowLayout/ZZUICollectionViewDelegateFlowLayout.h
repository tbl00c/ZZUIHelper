//
//  ZZUICollectionViewDelegateFlowLayout.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUICollectionViewDelegateFlowLayout : ZZProtocol

@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_sizeForItemAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_insetForSectionAtIndex;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_minimumLineSpacingForSectionAtIndex;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_minimumInteritemSpacingForSectionAtIndex;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_referenceSizeForHeaderInSection;
@property (nonatomic, strong, readonly) ZZMethod *collectionView_layout_referenceSizeForFooterInSection;

@end
