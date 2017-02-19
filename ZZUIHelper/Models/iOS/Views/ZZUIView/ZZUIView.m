//
//  ZZUIView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"

@implementation ZZUIView

- (NSString *)implementationInitCode
{
    NSString *initCode = @"";
    NSArray *childViewArray = self.childViewsArray;
    
    // initWithFrame
    if (childViewArray.count > 0) {
        for (ZZUIView *view in childViewArray) {
            initCode = [initCode stringByAppendingFormat:@"\t\t[%@ addSubView:self.%@];\n", self.curView, view.propertyName];
        }
        initCode = M_INITWITHFRAME(initCode);
    }
    
    return initCode;
}


@end
