//
//  ZZPropertyLayoutViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyLayoutViewController.h"
#import "ZZUIView+Masonry.h"
#import "ZZUIResponder+CodeCreator.h"

@interface ZZPropertyLayoutViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSArray *otherObjects;

@end

@implementation ZZPropertyLayoutViewController

- (void)setObject:(ZZUIView *)object
{
    _object = object;
    self.data = object.layouts;
    
    NSMutableArray *otherObjects = [[NSMutableArray alloc] init];
    NSArray *respArray = [ZZClassHelper sharedInstance].curClass.childViewsArray;
    [otherObjects addObject:@"superView"];
    for (ZZUIResponder *resp in respArray) {
        [otherObjects addObject:resp.propertyName];
    }
    self.otherObjects = otherObjects;
    
    [self.tableView reloadData];
}

#pragma mark - # Delegates
//MARK: NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.data.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZMasonryAttribute *attribute = self.data[row];
    if ([tableColumn.identifier isEqualToString:@"Attribute"]) {
        NSPopUpButtonCell *cell = tableColumn.dataCell;
        [cell setTitle:attribute.attributeName];
        return @(attribute.selected);
    }
    else if ([tableColumn.identifier isEqualToString:@"Relation"]) {
        return @(attribute.relation);
    }
    else if ([tableColumn.identifier isEqualToString:@"Object"]) {
        NSPopUpButtonCell *cell = tableColumn.dataCell;
        [cell removeAllItems];
        [cell addItemsWithTitles:self.otherObjects];
        return @([self.otherObjects indexOfObject:attribute.object]);
    }
    else if ([tableColumn.identifier isEqualToString:@"Object Attribute"]) {
        NSPopUpButtonCell *cell = tableColumn.dataCell;
        [cell removeAllItems];
        [cell addItemsWithTitles:attribute.selectedAttributes];
        return @([attribute.selectedAttributes indexOfObject:attribute.objectAttributeName]);
    }
    else if ([tableColumn.identifier isEqualToString:@"C-Relation"]) {
        return @(attribute.constantRelation);
    }
    else if ([tableColumn.identifier isEqualToString:@"Constant"]) {
        return attribute.constant;
    }
    else if ([tableColumn.identifier isEqualToString:@"Priority"]){
        return attribute.priority;
    }
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ZZMasonryAttribute *attribute = self.data[row];
    if ([tableColumn.identifier isEqualToString:@"Attribute"]) {
        attribute.selected = [object boolValue];
    }
    else if ([tableColumn.identifier isEqualToString:@"Relation"]) {
        attribute.relation = [object integerValue];
    }
    else if ([tableColumn.identifier isEqualToString:@"Object"]) {
        NSInteger index = [object integerValue];
        NSString *newObject;
        if (index >= 0 && index < self.otherObjects.count) {
            newObject = self.otherObjects[index];
        }
        else {
            newObject = nil;
        }
        if (!((newObject.length == 0 && attribute.object.length == 0) || [newObject isEqualToString:attribute.object])) {
            attribute.selected = YES;
        }
        attribute.object = newObject;
    }
    else if ([tableColumn.identifier isEqualToString:@"Object Attribute"]) {
        NSString *attrbuteName = attribute.selectedAttributes[[object integerValue]];
        attribute.objectAttributeType = [attribute.allAttributes indexOfObject:attrbuteName];
    }
    else if ([tableColumn.identifier isEqualToString:@"C-Relation"]) {
        attribute.constantRelation = [object integerValue];
    }
    else if ([tableColumn.identifier isEqualToString:@"Constant"]) {
        if (!(([object length] == 0 && attribute.object.length == 0) || [object isEqualToString:attribute.constant])) {
            attribute.selected = YES;
        }
        attribute.constant = object;
    }
    else if ([tableColumn.identifier isEqualToString:@"Priority"]){
        attribute.priority = object;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil];
}

@end
