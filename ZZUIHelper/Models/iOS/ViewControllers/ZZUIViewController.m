
//
//  ZZUIViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIViewController.h"

@implementation ZZUIViewController

- (NSString *)implementationInitCode
{
    NSString *initCode = [NSString stringWithFormat:@"%@ Life Cycle\n", PMARK_];
    
    NSArray *childViewArray = self.childViewsArray;
    
    // loadView
    if (childViewArray.count > 0) {
        NSString *loadViewCode = @"";
        for (ZZUIView *view in childViewArray) {
            loadViewCode = [loadViewCode stringByAppendingFormat:@"\t[%@ addSubView:self.%@];\n", self.curView, view.propertyName];
        }
        loadViewCode = M_LOADVIEW(loadViewCode);
        initCode = [initCode stringByAppendingString:loadViewCode];
    }
    
    // viewDidLoad
    NSString *viewDidLoadCode = M_VIEWDIDLOAD(@"");
    initCode = [initCode stringByAppendingString:viewDidLoadCode];

    return initCode;
}

- (NSString *)curView
{
    return @"self.view";
}

@end
