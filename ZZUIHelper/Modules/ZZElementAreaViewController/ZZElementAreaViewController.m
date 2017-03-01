//
//  ZZElementAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZElementAreaViewController.h"
#import "ZZElementCell.h"

@interface ZZElementAreaViewController () <NSTableViewDataSource, NSTableViewDelegate, ZZElementCellDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZElementAreaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    
    [self reloadData];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_NEW_PROJECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectAllCells) name:NOTI_NEW_PROPERTY_VC_CLOSE object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    self.data = [ZZClassHelper sharedInstance].properties.mutableCopy;
    [self.tableView reloadData];
    [self.tableView deselectRow:self.tableView.selectedRow];
    if (self.data.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:self.data.count - 1] byExtendingSelection:YES];
        });
    }
}

#pragma mark - # Delegate
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.data.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZNSObject *object = self.data[row];
    ZZElementCell *cell = [tableView makeViewWithIdentifier:@"ZZElementCell" owner:tableView];
    [cell setObject:object];
    [cell setDelegate:self];
    return cell;
}

//MARK: NSTableViewDelegate
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [notification.object selectedRow];
    if (row >= 0 && row < self.data.count) {
        ZZNSObject *object = self.data[row];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_SELECTED object:object];
    }
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 70;
}

//MARK: ZZElementCellDelegate
- (void)elementCellDeleteButtonClick:(ZZNSObject *)object
{
    if (object) {
        if ([[ZZClassHelper sharedInstance].curClass.interfaceProperties containsObject:object]) {
            [[ZZClassHelper sharedInstance].curClass removePublicProperty:object];
        }
        else if ([[ZZClassHelper sharedInstance].curClass.extensionProperties containsObject:object]) {
            [[ZZClassHelper sharedInstance].curClass removePrivateProperty:object];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    }
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
    [tableView deselectRow:tableView.selectedRow];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:@"NSFilenamesPboardType"] owner:self];
    [pboard setData:data forType:@"ZZElementCell"];
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
    return NSDragOperationMove;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
{
    NSPasteboard *pboard = [info draggingPasteboard];
    NSData *rowData = [pboard dataForType:@"ZZElementCell"];
    NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
    NSInteger dragRow = [rowIndexes firstIndex];
    
    if (dragRow < row) {
        [self.data insertObject:[self.data objectAtIndex:dragRow] atIndex:row];
        [self.data removeObjectAtIndex:dragRow];
    }
    else {
        NSString * zData = [self.data objectAtIndex:dragRow];
        [self.data removeObjectAtIndex:dragRow];
        [self.data insertObject:zData atIndex:row];
    }
    
    [[ZZClassHelper sharedInstance].curClass movePrivatePropertyAtIndex:dragRow toIndex:row];
    
    [self.tableView noteNumberOfRowsChanged];
    [self.tableView reloadData];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    });
    
    return YES;
}

#pragma mark - # Event Response
- (void)deselectAllCells
{
    [self.tableView deselectRow:self.tableView.selectedRow];
}

@end
