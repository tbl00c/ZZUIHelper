//
//  ZZCreatorSelectorCell.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZZCreatorModel.h"

@interface ZZCreatorSelectorCell : NSTableCellView

@property (nonatomic, strong) ZZCreatorModel *model;

@property (nonatomic, assign) BOOL isDefault;

@end
