//
//  ZZPropertyEventsViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEventsViewController.h"

@interface ZZPropertyEventsViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ZZPropertyEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
}


- (void)setEvents:(NSArray *)events
{
    _events = events;
    [self.tableView reloadData];
}

#pragma mark - # Delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.events.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (row >= 0 && row < self.events.count) {
        ZZMethod *method = self.events[row];
        NSButtonCell *cell = tableColumn.dataCell;
        [cell setTitle:method.methodNameWithoutParams];
        [cell setSelectable:YES];
        [cell setTarget:self];
        [cell setAction:@selector(buttonCellClick:)];
        return @(method.selected);
    }
    return nil;
}

#pragma mark - # Events Response
- (void)buttonCellClick:(NSTableView *)sender
{
    NSInteger row = sender.selectedRow;
    if (row >= 0 && row < self.events.count) {
        ZZMethod *method = self.events[row];
        method.selected = !method.selected;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:self.object];
    }
}

@end
