//
//  ZZElementAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZElementAreaViewController.h"

@interface ZZElementAreaViewController () <NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZElementAreaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reloadData];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    self.data = [ZZClassHelper sharedInstance].properties.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark - # Delegate
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.data.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZNSObject *object = self.data[row];
    return [NSString stringWithFormat:@"%@ - %@ (%@)", object.className, object.propertyName, object.remarks.length > 0 ? object.remarks : @""];
}

#pragma mark - # Event Response
- (IBAction)deleteButtonClick:(id)sender {
    NSInteger curIndex = self.tableView.selectedRow;
    if (curIndex >= 0 && curIndex < self.data.count) {
        ZZNSObject *object = self.data[curIndex];
        if ([[ZZClassHelper sharedInstance].curClass.interfaceProperties containsObject:object]) {
            [[ZZClassHelper sharedInstance].curClass removePublicProperty:object];
        }
        else if ([[ZZClassHelper sharedInstance].curClass.extensionProperties containsObject:object]) {
            [[ZZClassHelper sharedInstance].curClass removePrivateProperty:object];
        }
        [self reloadData];
    }
}


@end
