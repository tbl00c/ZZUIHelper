//
//  ZZCreatorModel.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCreatorModel.h"

@implementation ZZCreatorModel

- (id)initWithName:(NSString *)name andCreator:(id<ZZCreatorProtocol>)creator
{
    if (self = [super init]) {
        self.name = name;
        self.creator = creator;
    }
    return self;
}

@end
