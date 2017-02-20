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

@interface ZZControlAreaViewController () <NSCollectionViewDataSource, NSCollectionViewDelegate, ZZControlItemDelegate>

@property (weak) IBOutlet NSSearchField *searchBar;

@property (weak) IBOutlet NSCollectionView *collectionView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation ZZControlAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    [layout setItemSize:CGSizeMake(105, 100)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];

    self.data = [ZZControlHelper sharedInstance].controls;
    [self.collectionView registerClass:[ZZControlItem class] forItemWithIdentifier:@"ZZControlItem"];
    self.collectionView.content = self.data;
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
