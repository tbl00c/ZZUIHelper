//
//  ZZUITableViewDataSource.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewDataSource.h"

@implementation ZZUITableViewDataSource
@synthesize protocolMethods = _protocolMethods;
@synthesize numberOfSectionsInTableView = _numberOfSectionsInTableView;
@synthesize tableView_numberOfRowsInSection = _tableView_numberOfRowsInSection;
@synthesize tableView_cellForRowAtIndexPath = _tableView_cellForRowAtIndexPath;
@synthesize tableView_canEditRowAtIndexPath = _tableView_canEditRowAtIndexPath;
@synthesize tableView_canMoveRowAtIndexPath = _tableView_canMoveRowAtIndexPath;
@synthesize tableView_commitEditingStyle_forRowAtIndexPath = _tableView_commitEditingStyle_forRowAtIndexPath;
@synthesize tableView_moveRowAtIndexPath_toIndexPath = _tableView_moveRowAtIndexPath_toIndexPath;

- (NSString *)protocolKey
{
    return @"dataSource";
}

- (NSArray *)protocolMethods
{
    if (!_protocolMethods) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:self.numberOfSectionsInTableView];
        [array addObject:self.tableView_numberOfRowsInSection];
        [array addObject:self.tableView_cellForRowAtIndexPath];
        [array addObject:self.tableView_canEditRowAtIndexPath];
        [array addObject:self.tableView_canMoveRowAtIndexPath];
        [array addObject:self.tableView_commitEditingStyle_forRowAtIndexPath];
        [array addObject:self.tableView_moveRowAtIndexPath_toIndexPath];
        NSArray *superProtocolMethods = [super protocolMethods];
        for (ZZMethod *method in superProtocolMethods) {
            [method setSelected:NO];
        }
        [array addObjectsFromArray:superProtocolMethods];
        _protocolMethods = array;
    }
    return _protocolMethods;
}

- (ZZMethod *)numberOfSectionsInTableView
{
    if (!_numberOfSectionsInTableView) {
        _numberOfSectionsInTableView = [[ZZMethod alloc] initWithMethodName:@"- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView" selected:YES];
        [_numberOfSectionsInTableView addMethodContentCode:@"return 1;"];
    }
    return _numberOfSectionsInTableView;
}

- (ZZMethod *)tableView_numberOfRowsInSection
{
    if (!_tableView_numberOfRowsInSection) {
        _tableView_numberOfRowsInSection = [[ZZMethod alloc] initWithMethodName:@"- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section" selected:YES];
        [_tableView_numberOfRowsInSection addMethodContentCode:@"return self.data.count;"];
    }
    return _tableView_numberOfRowsInSection;
}

- (ZZMethod *)tableView_cellForRowAtIndexPath
{
    if (!_tableView_cellForRowAtIndexPath) {
        _tableView_cellForRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath" selected:YES];
    }
    return _tableView_cellForRowAtIndexPath;
}

- (ZZMethod *)tableView_canEditRowAtIndexPath
{
    if (!_tableView_canEditRowAtIndexPath) {
        _tableView_canEditRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _tableView_canEditRowAtIndexPath;
}

- (ZZMethod *)tableView_canMoveRowAtIndexPath
{
    if (!_tableView_canMoveRowAtIndexPath) {
        _tableView_canMoveRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _tableView_canMoveRowAtIndexPath;
}

- (ZZMethod *)tableView_commitEditingStyle_forRowAtIndexPath
{
    if (!_tableView_commitEditingStyle_forRowAtIndexPath) {
        _tableView_commitEditingStyle_forRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _tableView_commitEditingStyle_forRowAtIndexPath;
}

- (ZZMethod *)tableView_moveRowAtIndexPath_toIndexPath
{
    if (!_tableView_moveRowAtIndexPath_toIndexPath) {
        _tableView_moveRowAtIndexPath_toIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath" selected:NO];
    }
    return _tableView_moveRowAtIndexPath_toIndexPath;
}


@end
