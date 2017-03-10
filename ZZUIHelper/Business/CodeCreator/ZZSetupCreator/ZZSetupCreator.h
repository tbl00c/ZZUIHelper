//
//  ZZSetupCreator.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCreatorProtocol.h"
#import "ZZCreatorCodeBlock.h"

@interface ZZSetupCreator : NSObject <ZZCreatorProtocol>

@property (nonatomic, strong) ZZCreatorCodeBlock *lifeCycleCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *delegateCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *eventCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *setupCodeBlock;

@end
