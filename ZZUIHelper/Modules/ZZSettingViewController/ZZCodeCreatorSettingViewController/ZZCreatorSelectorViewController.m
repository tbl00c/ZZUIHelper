//
//  ZZCreatorSelectorViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorSelectorViewController.h"

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

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZCreatorModel *model = self.data[row];
    
    return model.name;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 20.0f;
}

@end
