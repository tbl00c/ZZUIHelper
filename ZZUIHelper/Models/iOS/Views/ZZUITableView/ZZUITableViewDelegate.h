//
//  ZZUITableViewDelegate.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIScrollViewDelegate.h"

@interface ZZUITableViewDelegate : ZZUIScrollViewDelegate

- (NSString *)tableViewdidSelectRowAtIndexPath;

- (NSString *)tableViewheightForRowAtIndexPath;

- (NSString *)tableViewheightForHeaderInSection;

- (NSString *)tableViewheightForFooterInSection;

- (NSString *)tableViewviewForHeaderInSection;

- (NSString *)tableViewviewForFooterInSection;

@end
