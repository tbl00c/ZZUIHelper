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

@interface ZZControlAreaViewController () <NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (weak) IBOutlet NSSearchField *searchBar;

@property (weak) IBOutlet NSCollectionView *collectionView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation ZZControlAreaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSCollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
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
    return item;
}

//MARK: NSCollectionViewDelegate
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    NSInteger index = [[indexPaths allObjects][0] item];
    if (index >= 0 && index < self.data.count) {
        NSString *className = [@"ZZ" stringByAppendingString:self.data[index]];
        ZZNewPropertyViewController *vc = [[ZZNewPropertyViewController alloc] initWithNibName:@"ZZNewPropertyViewController" bundle:nil];
        [vc setClassName:className];
        [self presentViewControllerAsSheet:vc];
    }
}

//MARK: NSCollectionViewDelegateFlowLayout
- (CGSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger line = 2;
    CGFloat width = (self.view.frame.size.width - 2) / line;
    while (width > MAX_CELL_WIDTH) {
        line ++;
        width = (self.view.frame.size.width - 2) / line;
    }
   
    CGFloat height = width * 20 / 21;
    return CGSizeMake(width, height);
}

#pragma mark - # Event Reponse
- (IBAction)addButtonClick:(id)sender {
}

@end
