//
//  ZZUITableViewDataSource.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUITableViewDataSource : ZZProtocol

@property (nonatomic, strong, readonly) ZZMethod *numberOfSectionsInTableView;
@property (nonatomic, strong, readonly) ZZMethod *tableView_numberOfRowsInSection;
@property (nonatomic, strong, readonly) ZZMethod *tableView_cellForRowAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *tableView_canEditRowAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *tableView_canMoveRowAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *tableView_commitEditingStyle_forRowAtIndexPath;
@property (nonatomic, strong, readonly) ZZMethod *tableView_moveRowAtIndexPath_toIndexPath;

@end
