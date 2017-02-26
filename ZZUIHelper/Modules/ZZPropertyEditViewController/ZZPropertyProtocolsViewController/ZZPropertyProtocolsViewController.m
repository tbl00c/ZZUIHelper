//
//  ZZPropertyProtocolsViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyProtocolsViewController.h"

@interface ZZPropertyProtocolsViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ZZPropertyProtocolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
}


- (void)setProtocol:(ZZProtocol *)protocol
{
    _protocol = protocol;
    [self.tableView reloadData];
}

#pragma mark - # Delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.protocol.protocolMethods.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (row >= 0 && row < self.protocol.protocolMethods.count) {
        ZZMethod *method = self.protocol.protocolMethods[row];
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
    if (row >= 0 && row < self.protocol.protocolMethods.count) {
        ZZMethod *method = self.protocol.protocolMethods[row];
        method.selected = !method.selected;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:self.object];
    }
}

@end
