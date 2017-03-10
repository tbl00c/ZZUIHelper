//
//  ZZCreatorSelectorViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorSelectorViewController.h"
#import "ZZCreatorSelectorCell.h"

@interface ZZCreatorSelectorViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZCreatorSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [ZZCreatorManager sharedInstance].creatorList.mutableCopy;
}

#pragma mark - # Delegate
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.data.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZCreatorModel *model = self.data[row];
    ZZCreatorSelectorCell *cell = [tableView makeViewWithIdentifier:@"ZZCreatorSelectorCell" owner:self];
    [cell setModel:model];
    [cell setIsDefault:row == [ZZCreatorManager sharedInstance].curCreatorIndex];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 50.0f;
}

#pragma mark - # Delegate
- (IBAction)setDefault:(id)sender {
    NSInteger index = self.tableView.selectedRow;
    if (index >= 0 && index < self.data.count) {
        [[ZZCreatorManager sharedInstance] setCurCreatorIndex:index];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROJECT object:nil];
    }
}

@end
