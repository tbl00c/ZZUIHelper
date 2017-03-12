//
//  ZZPropertyEditViewController+Delegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZPropertySectionHeaderView.h"

@interface ZZPropertyEditViewController (Delegate) <NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout, ZZPropertySectionHeaderViewDelegate>

- (void)registerViewsForCollectionView:(NSCollectionView *)collectionView;

@end
