//
//  ZZUITableViewDataSource.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUITableViewDataSource : ZZProtocol

- (NSString *)numberOfSectionsInTableView;
- (NSString *)tableViewnumberOfRowsInSection;
- (NSString *)tableViewcellForRowAtIndexPath;
- (NSString *)tableViewcanEditRowAtIndexPath;
- (NSString *)tableViewcanMoveRowAtIndexPath;
- (NSString *)tableViewcommitEditingStyleforRowAtIndexPath;
- (NSString *)tableViewmoveRowAtIndexPathtoIndexPath;

@end
