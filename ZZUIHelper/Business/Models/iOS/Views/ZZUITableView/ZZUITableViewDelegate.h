//
//  ZZUITableViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollViewDelegate.h"

@interface ZZUITableViewDelegate : ZZUIScrollViewDelegate

@property (nonatomic, strong) ZZMethod *tableView_didSelectRowAtIndexPath;

@property (nonatomic, strong) ZZMethod *tableView_didDeselectRowAtIndexPath;

@property (nonatomic, strong) ZZMethod *tableView_heightForRowAtIndexPath;

@property (nonatomic, strong) ZZMethod *tableView_heightForHeaderInSection;

@property (nonatomic, strong) ZZMethod *tableView_heightForFooterInSection;

@property (nonatomic, strong) ZZMethod *tableView_viewForHeaderInSection;

@property (nonatomic, strong) ZZMethod *tableView_viewForFooterInSection;

@end
