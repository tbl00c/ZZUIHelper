//
//  ZZFLEXCreator.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2019/4/16.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCreatorProtocol.h"
#import "ZZCreatorCodeBlock.h"

@interface ZZFLEXCreator : NSObject <ZZCreatorProtocol>

@property (nonatomic, strong) ZZCreatorCodeBlock *protocolCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *lifeCycleCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *delegateCodeBlock;
@property (nonatomic, strong) ZZCreatorCodeBlock *uiCodeBlock;

@end
