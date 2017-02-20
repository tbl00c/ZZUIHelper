//
//  ZZUITableViewCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewCell.h"

@implementation ZZUITableViewCell

- (NSString *)implementationInitCode
{
    NSString *initCode = @"";
    NSArray *childViewArray = self.childViewsArray;
    
    // initWithFrame
    if (childViewArray.count > 0) {
        for (ZZUIView *view in childViewArray) {
            initCode = [initCode stringByAppendingFormat:@"\t\t[%@ addSubView:self.%@];\n", self.curView, view.propertyName];
        }
        initCode = M_INIT_CELL(initCode);
    }
    
    return initCode;
}

- (NSString *)curView
{
    return @"self.contentView";
}

@end
