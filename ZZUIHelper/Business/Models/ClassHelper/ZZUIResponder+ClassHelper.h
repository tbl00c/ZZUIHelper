//
//  ZZUIResponder+ClassHelper.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"

@interface ZZUIResponder (ClassHelper)

- (void)addPublicProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks;

- (BOOL)removePublicProperty:(ZZNSObject *)property;

- (void)addPrivateProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks;

- (BOOL)removePrivateProperty:(ZZNSObject *)property;

- (BOOL)removePrivatePropertyAtIndex:(NSInteger)index;

- (BOOL)movePrivatePropertyAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex;

@end
