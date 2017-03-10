//
//  ZZCreatorManager.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCreatorModel.h"

@interface ZZCreatorManager : NSObject <ZZCreatorProtocol>

@property (nonatomic, strong) NSArray *creatorList;

@property (nonatomic, assign) NSInteger curCreatorIndex;

@property (nonatomic, strong) id<ZZCreatorProtocol> curCreator;

+ (ZZCreatorManager *)sharedInstance;

@end
