//
//  ZZLazyLoadCreator.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCreatorProtocol.h"

@interface ZZLazyLoadCreator : NSObject <ZZCreatorProtocol>

@property (nonatomic, strong) NSMutableArray *modules;

@end
