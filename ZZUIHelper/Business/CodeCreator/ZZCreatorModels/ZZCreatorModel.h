//
//  ZZCreatorModel.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCreatorProtocol.h"

@interface ZZCreatorModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) id<ZZCreatorProtocol> creator;

- (id)initWithName:(NSString *)name andCreator:(id<ZZCreatorProtocol>)creator;

@end
