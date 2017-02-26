//
//  ZZUITableViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewDelegate.h"

@implementation ZZUITableViewDelegate

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:self.tableView_didSelectRowAtIndexPath];
    [array addObject:self.tableView_heightForRowAtIndexPath];
    [array addObject:self.tableView_heightForHeaderInSection];
    [array addObject:self.tableView_heightForFooterInSection];
    [array addObject:self.tableView_viewForHeaderInSection];
    [array addObject:self.tableView_viewForFooterInSection];
    NSArray *superProtocolMethods = [super protocolMethods];
    for (ZZMethod *method in superProtocolMethods) {
        [method setSelected:NO];
    }
    [array addObjectsFromArray:superProtocolMethods];
    return array;
}

- (ZZMethod *)tableView_didSelectRowAtIndexPath
{
    if (!_tableView_didSelectRowAtIndexPath) {
        _tableView_didSelectRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath" selected:YES];
    }
    return _tableView_didSelectRowAtIndexPath;
}

- (ZZMethod *)tableView_didDeselectRowAtIndexPath
{
    if (!_tableView_didDeselectRowAtIndexPath) {
        _tableView_didDeselectRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath" selected:YES];
    }
    return _tableView_didDeselectRowAtIndexPath;
}

- (ZZMethod *)tableView_heightForRowAtIndexPath
{
    if (!_tableView_heightForRowAtIndexPath) {
        _tableView_heightForRowAtIndexPath = [[ZZMethod alloc] initWithMethodName:@"- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath" selected:NO];
    }
    return _tableView_heightForRowAtIndexPath;
}

- (ZZMethod *)tableView_heightForHeaderInSection
{
    if (!_tableView_heightForHeaderInSection) {
        _tableView_heightForHeaderInSection = [[ZZMethod alloc] initWithMethodName:@"- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section" selected:NO];
    }
    return _tableView_heightForHeaderInSection;
}

- (ZZMethod *)tableView_heightForFooterInSection
{
    if (!_tableView_heightForFooterInSection) {
        _tableView_heightForFooterInSection = [[ZZMethod alloc] initWithMethodName:@"- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section" selected:NO];
    }
    return _tableView_heightForFooterInSection;
}

- (ZZMethod *)tableView_viewForHeaderInSection
{
    if (!_tableView_viewForHeaderInSection) {
        _tableView_viewForHeaderInSection = [[ZZMethod alloc] initWithMethodName:@"- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section" selected:NO];
    }
    return _tableView_viewForHeaderInSection;
}

- (ZZMethod *)tableView_viewForFooterInSection
{
    if (!_tableView_viewForFooterInSection) {
        _tableView_viewForFooterInSection = [[ZZMethod alloc] initWithMethodName:@"- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section" selected:NO];
    }
    return _tableView_viewForFooterInSection;
}

@end
