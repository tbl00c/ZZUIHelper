//
//  ZZPropertyMViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyMViewController.h"
#import "ZZPropertyMethodCell.h"
#import "ZZPropertySectionHeaderView.h"

@interface ZZPropertyMViewController () <NSCollectionViewDelegate, NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout, ZZPropertySectionHeaderViewDelegate>

@property (weak) IBOutlet NSCollectionView *collectionView;

@end

@implementation ZZPropertyMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setWantsLayer:YES];
    [self.collectionView.layer setBackgroundColor:[NSColor windowBackgroundColor].CGColor];
    
    NSCollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    [self.collectionView registerClass:[ZZPropertyMethodCell class] forItemWithIdentifier:@"ZZPropertyMethodCell"];
    [self.collectionView registerClass:[ZZPropertySectionHeaderView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withIdentifier:@"ZZPropertySectionHeaderView"];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.collectionView reloadData];
}

- (void)setData:(NSArray *)data
{
    _data = data;
    
    [self.collectionView reloadData];
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
    ZZPropertyMethodCell *cell = [collectionView makeItemWithIdentifier:@"ZZPropertyMethodCell" forIndexPath:indexPath];
    if (indexPath.section > self.data.count || indexPath.item > [self.data[indexPath.section] count]) {
        [cell setMethod:nil];
    }
    else {
        ZZMethod *method = [self.data[indexPath.section] objectAtIndex:indexPath.item];
        [cell setMethod:method];
    }
    return cell;
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        ZZPropertySectionModel *sectionModel = indexPath.section < self.data.count ? self.data[indexPath.section] : nil;
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
    return CGSizeMake(collectionView.frame.size.width, 25);
}

- (CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
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
