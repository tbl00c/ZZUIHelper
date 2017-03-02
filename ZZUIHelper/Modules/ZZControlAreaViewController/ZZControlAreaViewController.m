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
#import "ZZControlListItem.h"

#define     MAX_CELL_WIDTH      130

@interface ZZControlAreaViewController () <NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout, NSSearchFieldDelegate>

@property (weak) IBOutlet NSSearchField *searchBar;

@property (weak) IBOutlet NSCollectionView *collectionView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger listType;

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
    [self.collectionView registerClass:[ZZControlListItem class] forItemWithIdentifier:@"ZZControlListItem"];
    self.collectionView.content = self.data;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectAllCells) name:NOTI_NEW_PROPERTY_VC_CLOSE object:nil];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - # Delegate
//MARK: NSCollectionViewDataSource
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listType == 0) {
        ZZControlItem *item = [collectionView makeItemWithIdentifier:@"ZZControlItem" forIndexPath:indexPath];
        item.buttonTitle = self.data[indexPath.item];
        return item;
    }

    ZZControlListItem *item = [collectionView makeItemWithIdentifier:@"ZZControlListItem" forIndexPath:indexPath];
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
    if (self.listType == 0) {
        NSInteger line = 2;
        CGFloat width = (self.view.frame.size.width - 2) / line;
        while (width > MAX_CELL_WIDTH) {
            line ++;
            width = (self.view.frame.size.width - 2) / line;
        }
        
        CGFloat height = width * 20 / 21;
        return CGSizeMake(width, height);
    }
    return CGSizeMake(collectionView.frame.size.width, 60);
}

//MARK: NSSearchFieldDelegate
- (void)controlTextDidChange:(NSNotification *)obj
{
    NSString *searchString = [obj.object stringValue];
    if (searchString.length > 0) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSString *title in [ZZControlHelper sharedInstance].controls) {
            if ([[title lowercaseString] containsString:[searchString lowercaseString]]) {
                [data addObject:title];
            }
        }
        self.data = data;
    }
    else {
        self.data = [ZZControlHelper sharedInstance].controls;
    }
    [self.collectionView reloadData];
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender
{
    self.data = [ZZControlHelper sharedInstance].controls;
    [self.collectionView reloadData];
}

#pragma mark - # Event Reponse
- (void)deselectAllCells
{
    NSSet *selectIndexPaths = self.collectionView.selectionIndexPaths;
    [self.collectionView deselectItemsAtIndexPaths:selectIndexPaths];
}

- (IBAction)layoutButtonClick:(NSButton *)sender {
    if (sender.tag == 0) {
        sender.tag = 1;
        [sender setImage:[NSImage imageNamed:@"list_listing"]];
    }
    else {
        sender.tag = 0;
        [sender setImage:[NSImage imageNamed:@"list_waterfall"]];
    }
    self.listType = sender.tag;
    [self.collectionView reloadData];
}

@end
