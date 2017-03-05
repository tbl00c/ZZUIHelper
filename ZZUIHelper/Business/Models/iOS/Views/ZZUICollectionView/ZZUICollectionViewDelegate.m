//
//  ZZUICollectionViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewDelegate.h"

@implementation ZZUICollectionViewDelegate
@synthesize protocolMethods = _protocolMethods;
@synthesize collectionView_didSelectItemAtIndexPath = _collectionView_didSelectItemAtIndexPath;
@synthesize collectionView_didDeselectItemAtIndexPath = _collectionView_didDeselectItemAtIndexPath;

- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:self.collectionView_didSelectItemAtIndexPath];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [array addObjectsFromArray:superProtocolMethods];
        _protocolMethods = array;
    }
    return _protocolMethods;
}


- (ZZMethod *)collectionView_didSelectItemAtIndexPath
{
    if (!_collectionView_didSelectItemAtIndexPath) {
        _collectionView_didSelectItemAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath" selected:YES];
    }
    return _collectionView_didSelectItemAtIndexPath;
}

- (ZZMethod *)collectionView_didDeselectItemAtIndexPath
{
    if (!_collectionView_didDeselectItemAtIndexPath) {
        _collectionView_didDeselectItemAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _collectionView_didDeselectItemAtIndexPath;
}

@end
