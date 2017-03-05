//
//  ZZUIResponder.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"

@interface ZZUIResponder : ZZNSObject

@property (nonatomic, strong, readonly) NSArray *childViewsArray;

@property (nonatomic, strong, readonly) NSArray *childControlsArray;

@property (nonatomic, strong, readonly) NSArray *childDelegateViewsArray;

@property (nonatomic, strong, readonly) NSString *masonryCode;

@property (nonatomic, strong, readonly) NSString *curView;

#pragma mark - # .h 文件代码
/// h文件代码
@property (nonatomic, strong, readonly) NSString *hFileCode;

/// 接口代码
@property (nonatomic, strong, readonly) NSString *interfaceCode;
/// 接口中的属性列表
@property (nonatomic, strong, readonly) NSArray *interfaceProperties;

- (void)addPublicProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks;

- (BOOL)removePublicProperty:(ZZNSObject *)property;

#pragma mark - # .m 文件代码
/// m文件代码
@property (nonatomic, strong, readonly) NSString *mFileCode;

/// 类拓展代码
@property (nonatomic, strong, readonly) NSString *extensionCode;
/// 类拓展中的属性列表
@property (nonatomic, strong, readonly) NSArray *extensionProperties;

/// 类实现代码
@property (nonatomic, strong, readonly) NSString *implementationCode;
/// 类实现中的初始化（loadView）方法代码
@property (nonatomic, strong, readonly) NSString *implementationInitCode;
/// 类实现中的初Delegate方法代码
@property (nonatomic, strong, readonly) NSString *implementationDelegateCode;
/// 类实现中的初Event Reponse方法代码
@property (nonatomic, strong, readonly) NSString *implementationEventCode;
/// 类实现中的初Private方法代码
@property (nonatomic, strong, readonly) NSString *implementationPrivateCode;
/// 类实现中的初Getter方法代码
@property (nonatomic, strong, readonly) NSString *implementationGetterCode;

- (void)addPrivateProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks;

- (BOOL)removePrivateProperty:(ZZNSObject *)property;

- (BOOL)removePrivatePropertyAtIndex:(NSInteger)index;

- (BOOL)movePrivatePropertyAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex;


@end
