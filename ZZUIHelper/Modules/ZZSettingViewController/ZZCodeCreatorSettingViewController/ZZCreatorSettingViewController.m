//
//  ZZCreatorSettingViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorSettingViewController.h"
#import "ZZCreatorCodeModuleCell.h"
#import "ZZCreatorProtocol.h"

@interface ZZCreatorSettingViewController ()

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) id<ZZCreatorProtocol> creator;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ZZCreatorSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCreator:) name:NOTI_SETTING_SELECT_CREATOR object:nil];
}

- (void)didSelectCreator:(NSNotification *)noti
{
    self.creator = noti.object;
    if ([self.creator respondsToSelector:@selector(modules)]) {
        self.data = [self.creator modules];
        [self.tableView reloadData];
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
    ZZCreatorCodeBlock *model = self.data[row];
    ZZCreatorCodeModuleCell *cell = [tableView makeViewWithIdentifier:@"ZZCreatorCodeModuleCell" owner:self];
    [cell setModel:model];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 50.0f;
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [notification.object selectedRow];
    [self.tableView deselectRow:row];
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
    [pboard declareTypes:[NSArray arrayWithObject:@"NSFilenamesPboardType"] owner:self];
    [pboard setData:data forType:@"ZZCreatorCodeModuleCell"];
    return YES;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
    return NSDragOperationMove;
}

- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
{
    NSPasteboard *pboard = [info draggingPasteboard];
    NSData *rowData = [pboard dataForType:@"ZZCreatorCodeModuleCell"];
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
    if ([self.creator respondsToSelector:@selector(setModules:)]) {
        [self.creator setModules:self.data];
    }
    [self.tableView noteNumberOfRowsChanged];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROJECT object:nil];
    });
    
    return YES;
}


@end
