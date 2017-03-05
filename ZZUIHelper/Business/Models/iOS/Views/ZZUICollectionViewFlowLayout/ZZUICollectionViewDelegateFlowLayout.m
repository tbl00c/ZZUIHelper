//
//  ZZUICollectionViewDelegateFlowLayout.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewDelegateFlowLayout.h"

@implementation ZZUICollectionViewDelegateFlowLayout
@synthesize protocolMethods = _protocolMethods;
@synthesize collectionView_layout_sizeForItemAtIndexPath = _collectionView_layout_sizeForItemAtIndexPath;
@synthesize collectionView_layout_insetForSectionAtIndex = _collectionView_layout_insetForSectionAtIndex;
@synthesize collectionView_layout_minimumLineSpacingForSectionAtIndex = _collectionView_layout_minimumLineSpacingForSectionAtIndex;
@synthesize collectionView_layout_minimumInteritemSpacingForSectionAtIndex = _collectionView_layout_minimumInteritemSpacingForSectionAtIndex;
@synthesize collectionView_layout_referenceSizeForHeaderInSection = _collectionView_layout_referenceSizeForHeaderInSection;
@synthesize collectionView_layout_referenceSizeForFooterInSection = _collectionView_layout_referenceSizeForFooterInSection;

- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:self.collectionView_layout_sizeForItemAtIndexPath];
        [array addObject:self.collectionView_layout_insetForSectionAtIndex];
        [array addObject:self.collectionView_layout_minimumLineSpacingForSectionAtIndex];
        [array addObject:self.collectionView_layout_minimumInteritemSpacingForSectionAtIndex];
        [array addObject:self.collectionView_layout_referenceSizeForHeaderInSection];
        [array addObject:self.collectionView_layout_referenceSizeForFooterInSection];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [array addObjectsFromArray:superProtocolMethods];
        _protocolMethods = array;
    }
    return _protocolMethods;
}

- (ZZMethod *)collectionView_layout_sizeForItemAtIndexPath
{
    if (!_collectionView_layout_sizeForItemAtIndexPath) {
        _collectionView_layout_sizeForItemAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _collectionView_layout_sizeForItemAtIndexPath;
}

- (ZZMethod *)collectionView_layout_insetForSectionAtIndex
{
    if (!_collectionView_layout_insetForSectionAtIndex) {
        _collectionView_layout_insetForSectionAtIndex = [[ZZMethod alloc] initWithMethodName:@"- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section" selected:NO];
    }
    return _collectionView_layout_insetForSectionAtIndex;
}

- (ZZMethod *)collectionView_layout_minimumLineSpacingForSectionAtIndex
{
    if (!_collectionView_layout_minimumLineSpacingForSectionAtIndex) {
        _collectionView_layout_minimumLineSpacingForSectionAtIndex = [[ZZMethod alloc] initWithMethodName:@"- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section" selected:NO];
    }
    return _collectionView_layout_minimumLineSpacingForSectionAtIndex;
}

- (ZZMethod *)collectionView_layout_minimumInteritemSpacingForSectionAtIndex
{
    if (!_collectionView_layout_minimumInteritemSpacingForSectionAtIndex) {
        _collectionView_layout_minimumInteritemSpacingForSectionAtIndex = [[ZZMethod alloc] initWithMethodName:@"- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section" selected:NO];
    }
    return _collectionView_layout_minimumInteritemSpacingForSectionAtIndex;
}

- (ZZMethod *)collectionView_layout_referenceSizeForHeaderInSection
{
    if (!_collectionView_layout_referenceSizeForHeaderInSection) {
        _collectionView_layout_referenceSizeForHeaderInSection = [[ZZMethod alloc] initWithMethodName:@"- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section" selected:NO];
    }
    return _collectionView_layout_referenceSizeForHeaderInSection;
}

- (ZZMethod *)collectionView_layout_referenceSizeForFooterInSection
{
    if (!_collectionView_layout_referenceSizeForFooterInSection) {
        _collectionView_layout_referenceSizeForFooterInSection = [[ZZMethod alloc] initWithMethodName:@"- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section" selected:NO];
    }
    return _collectionView_layout_referenceSizeForFooterInSection;
}

@end
