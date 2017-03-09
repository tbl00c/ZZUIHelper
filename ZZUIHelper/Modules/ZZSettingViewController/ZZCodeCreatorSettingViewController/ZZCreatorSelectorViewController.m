//
//  ZZCreatorSelectorViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorSelectorViewController.h"

@interface ZZCreatorSelectorViewController () <NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ZZCreatorSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - # Delegate
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 1;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *title = @"Normal - Getter";
    return title;
}

@end
