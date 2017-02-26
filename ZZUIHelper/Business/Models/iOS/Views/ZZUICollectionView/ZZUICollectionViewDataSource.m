//
//  ZZUICollectionViewDataSource.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewDataSource.h"

@implementation ZZUICollectionViewDataSource

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:self.numberOfSectionsInCollectionView];
    [array addObject:self.collectionView_numberOfItemsInSection];
    [array addObject:self.collectionView_cellForItemAtIndexPath];
    [array addObject:self.collectionView_viewForSupplementaryElementOfKind_atIndexPath];
    [array addObject:self.collectionView_canMoveItemAtIndexPath];
    [array addObject:self.collectionView_moveItemAtIndexPath_toIndexPath];
    NSArray *superProtocolMethods = [super protocolMethods];
    for (ZZMethod *method in superProtocolMethods) {
        [method setSelected:NO];
    }
    [array addObjectsFromArray:superProtocolMethods];
    return array;
}

- (ZZMethod *)numberOfSectionsInCollectionView
{
    if (!_numberOfSectionsInCollectionView) {
        _numberOfSectionsInCollectionView = [[ZZMethod alloc] initWithMethodName:@"- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView" selected:YES];
    }
    return _numberOfSectionsInCollectionView;
}

- (ZZMethod *)collectionView_numberOfItemsInSection
{
    if (!_collectionView_numberOfItemsInSection) {
        _collectionView_numberOfItemsInSection = [[ZZMethod alloc] initWithMethodName:@"- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section" selected:YES];
    }
    return _collectionView_numberOfItemsInSection;
}

- (ZZMethod *)collectionView_cellForItemAtIndexPath
{
    if (!_collectionView_cellForItemAtIndexPath) {
        _collectionView_cellForItemAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath" selected:YES];
    }
    return _collectionView_cellForItemAtIndexPath;
}

- (ZZMethod *)collectionView_viewForSupplementaryElementOfKind_atIndexPath
{
    if (!_collectionView_viewForSupplementaryElementOfKind_atIndexPath) {
        _collectionView_viewForSupplementaryElementOfKind_atIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _collectionView_viewForSupplementaryElementOfKind_atIndexPath;
}

- (ZZMethod *)collectionView_canMoveItemAtIndexPath
{
    if (!_collectionView_canMoveItemAtIndexPath) {
        _collectionView_canMoveItemAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _collectionView_canMoveItemAtIndexPath;
}

- (ZZMethod *)collectionView_moveItemAtIndexPath_toIndexPath
{
    if (!_collectionView_moveItemAtIndexPath_toIndexPath) {
        _collectionView_moveItemAtIndexPath_toIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath" selected:NO];
    }
    return _collectionView_moveItemAtIndexPath_toIndexPath;
}

@end
