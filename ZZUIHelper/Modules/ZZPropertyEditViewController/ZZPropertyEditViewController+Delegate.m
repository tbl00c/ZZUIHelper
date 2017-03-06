//
//  ZZPropertyEditViewController+Delegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController+Delegate.h"
#import "ZZPropertyBoolCell.h"
#import "ZZPropertyStringCell.h"
#import "ZZPropertyEventCell.h"
#import "ZZPropertyMethodCell.h"
#import "ZZPropertySelectionCell.h"
#import "ZZPropertyXYCell.h"
#import "ZZPropertyXYWHCell.h"

@implementation ZZPropertyEditViewController (Delegate)

- (void)registerViewsForCollectionView:(NSCollectionView *)collectionView
{
    NSCollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
    [self.collectionView registerClass:[ZZPropertySectionHeaderView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withIdentifier:@"ZZPropertySectionHeaderView"];
    [self.collectionView registerClass:[ZZPropertyBoolCell class] forItemWithIdentifier:@"ZZPropertyBoolCell"];
    [self.collectionView registerClass:[ZZPropertyStringCell class] forItemWithIdentifier:@"ZZPropertyStringCell"];
    [self.collectionView registerClass:[ZZPropertySelectionCell class] forItemWithIdentifier:@"ZZPropertySelectionCell"];
    [self.collectionView registerClass:[ZZPropertyEventCell class] forItemWithIdentifier:@"ZZPropertyEventCell"];
    [self.collectionView registerClass:[ZZPropertyMethodCell class] forItemWithIdentifier:@"ZZPropertyMethodCell"];
    [self.collectionView registerClass:[ZZPropertyXYCell class] forItemWithIdentifier:@"ZZPropertyXYCell"];
    [self.collectionView registerClass:[ZZPropertyXYWHCell class] forItemWithIdentifier:@"ZZPropertyXYWHCell"];
}

#pragma mark - # Delegate
//MARK: NSCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section < self.data.count) {
        ZZPropertySectionModel *model = self.data[section];
        return model.showAllItems ? model.count : 0;
    }
    return 0;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    ZZPropertySectionModel *model = self.data[indexPath.section];
    if (model.sectionType == ZZPropertySectionTypeProperty) {
        ZZProperty *property = [self.data[indexPath.section] objectAtIndex:indexPath.item];
        if (property.type == ZZPropertyTypeBOOL) {
            ZZPropertyBoolCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyBoolCell" forIndexPath:indexPath];
            [cell setProperty:property];
            return cell;
        }
        else if (property.type == ZZPropertyTypeNumber || property.type == ZZPropertyTypeString || property.type == ZZPropertyTypeObject) {
            ZZPropertyStringCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyStringCell" forIndexPath:indexPath];
            [cell setProperty:property];
            return cell;
        }
        else if (property.type == ZZPropertyTypeSelection) {
            ZZPropertySelectionCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertySelectionCell" forIndexPath:indexPath];
            [cell setProperty:property];
            return cell;
        }
        else if (property.type == ZZPropertyTypeSize || property.type == ZZPropertyTypePoint) {
            ZZPropertyXYCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyXYCell" forIndexPath:indexPath];
            [cell setProperty:property];
            return cell;
        }
        else if (property.type == ZZPropertyTypeEdgeInsets || property.type == ZZPropertyTypeRect) {
            ZZPropertyXYWHCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyXYWHCell" forIndexPath:indexPath];
            [cell setProperty:property];
            return cell;
        }
    }
    if (model.sectionType == ZZPropertySectionTypeEvent) {
        ZZPropertyEventCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyEventCell" forIndexPath:indexPath];
        ZZEvent *event = [self.data[indexPath.section] objectAtIndex:indexPath.item];
        [cell setEvent:event];
        return cell;
    }
    else if (model.sectionType == ZZPropertySectionTypeDelegate) {
        ZZPropertyMethodCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyMethodCell" forIndexPath:indexPath];
        ZZMethod *method = [self.data[indexPath.section] objectAtIndex:indexPath.item];
        [cell setMethod:method];
        return cell;
    }
    return nil;
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        ZZPropertySectionModel *sectionModel = indexPath.section < self.data.count ? self.data[indexPath.section] : nil;
        if (sectionModel.sectionTitle.length == 0) {
            return nil;
        }
        ZZPropertySectionHeaderView *headerView = [collectionView makeSupplementaryViewOfKind:kind withIdentifier:@"ZZPropertySectionHeaderView" forIndexPath:indexPath];
        [headerView setModel:sectionModel];
        [headerView setDelegate:self];
        [headerView setShowBottomLine:indexPath.section == self.data.count - 1];
        return headerView;
    }
    return nil;
}

//MARK: NSCollectionViewDelegateFlowLayout
- (CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZPropertySectionModel *model = self.data[indexPath.section];
    if (model.sectionType == ZZPropertySectionTypeProperty) {
        return CGSizeMake(collectionView.frame.size.width, 25);
    }
    else if (model.sectionType == ZZPropertySectionTypeEvent) {
        return CGSizeMake(collectionView.frame.size.width, 60);
    }
    else if (model.sectionType == ZZPropertySectionTypeDelegate) {
        return CGSizeMake(collectionView.frame.size.width, 25);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ZZPropertySectionModel *sectionModel = section < self.data.count ? self.data[section] : nil;
    if (!sectionModel || sectionModel.sectionTitle.length == 0) {
        return CGSizeMake(collectionView.frame.size.width, 10);
    }
    return CGSizeMake(collectionView.frame.size.width, 30);
}

- (NSEdgeInsets)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section < self.data.count) {
        ZZPropertySectionModel *model = self.data[section];
        return model.showAllItems ? NSEdgeInsetsMake(0, 0, 10, 0) : NSEdgeInsetsZero;
    }
    return NSEdgeInsetsZero;
}

//MARK: ZZPropertySectionHeaderViewDelegate
- (void)didClickedPropertySectionHeaderView:(ZZPropertySectionModel *)model
{
    model.showAllItems = !model.showAllItems;
    [self.collectionView reloadData];
}


@end
