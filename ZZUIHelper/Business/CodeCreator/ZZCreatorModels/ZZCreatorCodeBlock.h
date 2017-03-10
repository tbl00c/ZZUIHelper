//
//  ZZCreatorCodeBlock.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCreatorCodeBlock : NSObject

@property (nonatomic, strong) NSString *blockName;

@property (nonatomic, strong) NSString *(^action)(ZZUIResponder *object);

- (id)initWithBlockName:(NSString *)blockName action:(NSString *(^)(ZZUIResponder *))action;

@end
