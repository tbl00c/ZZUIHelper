//
//  ZZSettingItemsAddViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZSettingItemsAddViewController.h"

@interface ZZSettingItemsAddViewController () <NSTableViewDataSource>
@property (weak) IBOutlet NSScrollView *textViewContainer;
@property (weak) IBOutlet NSTextField *desLabel;
@property (weak) IBOutlet NSButton *deleteButton;

@property (nonatomic, strong) NSMutableArray *data;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButton *cancelButton;
@property (weak) IBOutlet NSButton *okButton;

@end

@implementation ZZSettingItemsAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setHidden:YES];
    [self.deleteButton setHidden:YES];
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

#pragma mark - # Delegate
- (IBAction)okButtonClick:(NSButton *)sender {
    if (sender.tag == 0) {
        self.data = [self p_itemsByCode:self.textView.string];
        [self.desLabel setStringValue:@"提示：双击可编辑"];
        [self.textViewContainer setHidden:YES];
        [self.tableView setHidden:NO];
        [self.cancelButton setTitle:@"上一步"];
        [self.cancelButton setTag:1];
        [self.deleteButton setHidden:NO];
        [sender setTitle:@"确定"];
        [sender setTag:1];
        [self.tableView reloadData];
    }
    else {
        [self.view.window makeFirstResponder:self.view];
        [self.view.window makeFirstResponder:self.tableView];
        if (self.okButtonClickAction) {
            self.okButtonClickAction(self.data);
        }
        [self dismissViewController:self];
    }
}

- (IBAction)cancelButtonClick:(NSButton *)sender {
    if (sender.tag == 0) {
        [self dismissViewController:self];
    }
    else if (sender.tag == 1) {
        [self.desLabel setStringValue:@"提示：可解析属性名和方法名，过滤无关字符"];
        [self.deleteButton setHidden:YES];
        [self.okButton setTitle:@"下一步"];
        [self.okButton setTag:0];
        [sender setTitle:@"取消"];
        [sender setTag:0];
        [self.textViewContainer setHidden:NO];
        [self.tableView setHidden:YES];
    }
}

- (IBAction)deleteButtonClick:(id)sender {
    [self.view.window makeFirstResponder:self.view];
    [self.view.window makeFirstResponder:self.tableView];
    NSInteger selectIndex = self.tableView.selectedRow;
    if (selectIndex >= 0 && selectIndex < self.data.count) {
        [self.data removeObjectAtIndex:selectIndex];
        [self.tableView reloadData];
    }
}

#pragma mark - # Private Methods
- (NSMutableArray *)p_itemsByCode:(NSString *)code
{
    NSArray *lineItems = [code componentsSeparatedByString:@"\n"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSString *line in lineItems) {
        NSString *lineStr = [line strip];
        if ([lineStr hasPrefix:@"@property"]) {
            NSArray *items = [lineStr componentsSeparatedByString:@"*"];
            if (items.count == 2) {
                NSString *name = [items[1] strip];
                if ([name containsString:@";"]) {
                    name = [name componentsSeparatedByString:@";"][0];
                }
                [data addObject:name];
            }
        }
        else if ([lineStr hasPrefix:@"+"]) {
            NSArray *items = [lineStr componentsSeparatedByString:@")"];
            if (items.count == 2) {
                NSString *name = [items[1] strip];
                if ([name containsString:@";"]) {
                    name = [name componentsSeparatedByString:@";"][0];
                }
                [data addObject:name];
            }
        }
        else if ([lineStr hasPrefix:@"//"] || [line hasPrefix:@"#"]) {
            continue;
        }
        else {
            NSArray *items = [lineStr componentsSeparatedByString:@" "];
            for (NSString *item in items) {
                NSString *itemString = [item strip];
                if (itemString.length > 0) {
                    [data addObject:itemString];
                }
            }
        }
    }
    return data;
}

@end
