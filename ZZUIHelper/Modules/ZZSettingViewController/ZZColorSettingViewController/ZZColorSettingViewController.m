//
//  ZZColorSettingViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZColorSettingViewController.h"
#import "ZZSettingItemsAddViewController.h"

@interface ZZColorSettingViewController ()

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZColorSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData
{
    self.data = [ZZUIHelperConfig sharedInstance].colors.mutableCopy;
    [self.tableView reloadData];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SETTING_EDIT object:nil userInfo:nil];
}

#pragma mark - # Delegate
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.data.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *title = self.data[row];
    return title;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (row < self.data.count) {
        [self.data replaceObjectAtIndex:row withObject:object];
        [ZZUIHelperConfig sharedInstance].colors = self.data;
    }
}

#pragma mark - # Event Response
- (IBAction)addButtonClick:(id)sender {
    [self.view.window makeFirstResponder:self.view];
    [self.view.window makeFirstResponder:self.tableView];
    [self.data insertObject:@"New Item" atIndex:0];
    [self.tableView reloadData];
    [self.tableView deselectRow:self.tableView.selectedRow];
    [self.tableView editColumn:0 row:0 withEvent:nil select:YES];
}

- (IBAction)deleteButtonClick:(id)sender {
    [self.view.window makeFirstResponder:self.view];
    [self.view.window makeFirstResponder:self.tableView];
    NSInteger selectIndex = self.tableView.selectedRow;
    if (selectIndex >= 0 && selectIndex < self.data.count) {
        [self.data removeObjectAtIndex:selectIndex];
        [ZZUIHelperConfig sharedInstance].colors = self.data;
        [self.tableView reloadData];
    }
}

- (IBAction)addLotButtonClick:(id)sender {
    ZZSettingItemsAddViewController *addVC = [[ZZSettingItemsAddViewController alloc] initWithNibName:@"ZZSettingItemsAddViewController" bundle:nil];
    __weak typeof(self) weakSelf = self;
    [addVC setOkButtonClickAction:^(NSArray *data) {
        if (data.count > 0 && weakSelf) {
            [weakSelf.data addObjectsFromArray:data];
            [ZZUIHelperConfig sharedInstance].colors = weakSelf.data;
            [weakSelf.tableView reloadData];
        }
    }];
    [self presentViewControllerAsSheet:addVC];
}

- (IBAction)resetButtonClick:(id)sender {
    [self.view.window makeFirstResponder:self.view];
    [self.view.window makeFirstResponder:self.tableView];
    [[ZZUIHelperConfig sharedInstance] resetToDefaultColors];
    [self loadData];
}

@end
