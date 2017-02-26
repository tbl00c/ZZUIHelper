//
//  ZZUITableViewDataSource.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProtocol.h"

@interface ZZUITableViewDataSource : ZZProtocol

@property (nonatomic, strong) ZZMethod *numberOfSectionsInTableView;
@property (nonatomic, strong) ZZMethod *tableView_numberOfRowsInSection;
@property (nonatomic, strong) ZZMethod *tableView_cellForRowAtIndexPath;
@property (nonatomic, strong) ZZMethod *tableView_canEditRowAtIndexPath;
@property (nonatomic, strong) ZZMethod *tableView_canMoveRowAtIndexPath;
@property (nonatomic, strong) ZZMethod *tableView_commitEditingStyle_forRowAtIndexPath;
@property (nonatomic, strong) ZZMethod *tableView_moveRowAtIndexPath_toIndexPath;

@end
