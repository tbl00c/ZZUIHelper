//
//  ZZControlAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlAreaViewController.h"
#import "ZZNewPropertyViewController.h"
#import "ZZControlItem.h"

#define     MAX_CELL_WIDTH      130

@interface ZZControlAreaViewController () <NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout, ZZControlItemDelegate>

@property (weak) IBOutlet NSSearchField *searchBar;

@property (weak) IBOutlet NSCollectionView *collectionView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation ZZControlAreaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [ZZControlHelper sharedInstance].controls;
    [self.collectionView registerClass:[ZZControlItem class] forItemWithIdentifier:@"ZZControlItem"];
    self.collectionView.content = self.data;
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.collectionView reloadData];
}

#pragma mark - # Delegate
//MARK: NSCollectionViewDataSource
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    ZZControlItem *item = [collectionView makeItemWithIdentifier:@"ZZControlItem" forIndexPath:indexPath];
    item.buttonTitle = self.data[indexPath.item];
    item.delegate = self;
    return item;
}

//MARK: NSCollectionViewDelegate
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(nonnull NSSet<NSIndexPath *> *)indexPaths
{
    for (NSIndexPath *indexPath in indexPaths) {
        NSLog(@"%ld", indexPath.item);
    }
}

//MARK: NSCollectionViewDelegateFlowLayout
- (CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger line = 2;
    CGFloat width = (self.view.frame.size.width - line * 10) / line;
    while (width > MAX_CELL_WIDTH) {
        line ++;
        width = (self.view.frame.size.width - line * 10) / line;
    }
   
    CGFloat height = width * 20 / 21;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6.0f;
}

- (CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 6.0f;
}

- (NSEdgeInsets)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return NSEdgeInsetsMake(6, 6, 6, 6);
}

//MARK: ZZControlItemDelegate
- (void)didSelectItemWithClassName:(NSString *)className
{
    ZZNewPropertyViewController *vc = [[ZZNewPropertyViewController alloc] initWithNibName:@"ZZNewPropertyViewController" bundle:nil];
    [vc setClassName:className];
    [self presentViewControllerAsSheet:vc];
}

#pragma mark - # Event Reponse
- (IBAction)addButtonClick:(id)sender {
}

@end
