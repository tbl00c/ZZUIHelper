//
//  ZZUITableViewDataSource.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewDataSource.h"

@implementation ZZUITableViewDataSource

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
    return @"UITableViewDataSource";
}

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"numberOfSectionsInTableView:"];
    [array addObject:@"tableView:numberOfRowsInSection:"];
    [array addObject:@"tableView:cellForRowAtIndexPath:"];
    [array addObject:@"tableView:canEditRowAtIndexPath:"];
    [array addObject:@"tableView:canMoveRowAtIndexPath:"];
    [array addObject:@"tableView:commitEditingStyle:forRowAtIndexPath:"];
    [array addObject:@"tableView:moveRowAtIndexPath:toIndexPath:"];
    return array;
}

- (NSArray *)protocolMethodsCode
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[self numberOfSectionsInTableView]];
    [array addObject:[self tableViewnumberOfRowsInSection]];
    [array addObject:[self tableViewcellForRowAtIndexPath]];
//    [array addObject:[self tableViewcanEditRowAtIndexPath]];
//    [array addObject:[self tableViewcanMoveRowAtIndexPath]];
//    [array addObject:[self tableViewcommitEditingStyleforRowAtIndexPath]];
//    [array addObject:[self tableViewmoveRowAtIndexPathtoIndexPath]];
    return array;
}

- (NSString *)numberOfSectionsInTableView
{
    NSString *code = [NSString stringWithFormat:@"- (NSInteger)numberOfSectionsInTableView:(%@ *)%@%@\n\treturn 1;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewnumberOfRowsInSection
{
    NSString *code = [NSString stringWithFormat:@"- (NSInteger)tableView:(%@ *)%@ numberOfRowsInSection:(NSInteger *)section%@\n\treturn self.data.count;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewcellForRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (UITableViewCell *)tableView:(%@ *)%@ cellForRowAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn nil;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewcanEditRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (BOOL)tableView:(%@ *)%@ canEditRowAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn YES;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewcanMoveRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (BOOL)tableView:(%@ *)%@ canMoveRowAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn YES;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)tableViewcommitEditingStyleforRowAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (void)tableView:(%@ *)%@ commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}
- (NSString *)tableViewmoveRowAtIndexPathtoIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (void)tableView:(%@ *)%@ moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}




@end
