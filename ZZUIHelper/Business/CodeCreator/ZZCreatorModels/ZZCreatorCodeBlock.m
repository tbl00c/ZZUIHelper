//
//  ZZCreatorCodeBlock.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorCodeBlock.h"

@implementation ZZCreatorCodeBlock

- (id)initWithBlockName:(NSString *)blockName action:(NSString *(^)(ZZUIResponder *))action
{
    if (self = [super init]) {
        self.blockName = blockName;
        self.action = action;
    }
    return self;
}

@end
