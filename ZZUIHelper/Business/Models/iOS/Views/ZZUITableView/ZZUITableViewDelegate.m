//
//  ZZUITableViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewDelegate.h"

@implementation ZZUITableViewDelegate

- (NSString *)className
{
    return @"UITableView";
}

- (NSString *)propertyName
{
    return @"tableView";
}

- (NSString *)protocolName
{
    return @"UITableViewDelegate";
}

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"tableView:didSelectRowAtIndexPath"];
    [array addObject:@"tableView:heightForRowAtIndexPath:"];
    [array addObject:@"tableView:heightForHeaderInSection"];
    [array addObject:@"tableView:heightForFooterInSection:"];
    [array addObject:@"tableView:viewForHeaderInSection:"];
    [array addObject:@"tableView:viewForFooterInSection:"];
    [array addObjectsFromArray:[super protocolMethods]];
    return array;
}

- (NSArray *)protocolMethodsCode
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[self tableViewdidSelectRowAtIndexPath]];
    [array addObject:[self tableViewheightForRowAtIndexPath]];
//    [array addObject:[self tableViewheightForHeaderInSection]];
//    [array addObject:[self tableViewheightForFooterInSection]];
//    [array addObject:[self tableViewviewForHeaderInSection]];
//    [array addObject:[self tableViewviewForFooterInSection]];
    return array;
}

- (NSString *)tableViewdidSelectRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (void)tableView:(%@ *)%@ didSelectRowAtIndexPath:(NSIndexPath *)indexPath%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewheightForRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (CGFloat)tableView:(%@ *)%@ heightForRowAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn 50.0f\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewheightForHeaderInSection
{
    NSString *code = [NSString stringWithFormat:@"- (CGFloat)tableView:(%@ *)%@ heightForHeaderInSection:(NSIndexPath *)indexPath%@\n\treturn 50.0f;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewheightForFooterInSection
{
    NSString *code = [NSString stringWithFormat:@"- (CGFloat)tableView:(%@ *)%@ heightForFooterInSection:(NSIndexPath *)indexPath%@\n\treturn 50.0f;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewviewForHeaderInSection
{
    NSString *code = [NSString stringWithFormat:@"- (UIView *)tableView:(%@ *)%@ viewForHeaderInSection:(NSInteger)section%@\n\treturn nil;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewviewForFooterInSection
{
    NSString *code = [NSString stringWithFormat:@"- (UIView *)tableView:(%@ *)%@ viewForFooterInSection:(NSInteger)section%@\n\treturn nil;\n}\n\n", self.className, self.propertyName,LEFT_PARENTHESIS];
    return code;
}

@end
