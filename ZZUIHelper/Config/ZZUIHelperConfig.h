//
//  ZZUIHelperConfig.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZUIHelperLayoutLibrary) {
    ZZUIHelperLayoutLibraryNone,
    ZZUIHelperLayoutLibraryMasonry,
};

@interface ZZUIHelperConfig : NSObject

/// 作者姓名
@property (nonatomic, strong) NSString *authorName;

/// 项目名称
@property (nonatomic, strong) NSString *projectName;

/// 类前缀
@property (nonatomic, strong) NSString *classPrefix;

/// 左括号是否换行
@property (nonatomic, assign) BOOL newLineLeftParenthesis;

/// 布局第三方库
@property (nonatomic, assign) ZZUIHelperLayoutLibrary layoutLibrary;

+ (ZZUIHelperConfig *)sharedInstance;

- (void)resetToDefaultConfig;

- (NSString *)copyrightCodeByFileName:(NSString *)fileName;

#pragma mark - # 控件可配置属性

@property (nonatomic, strong) NSArray *controls;

@property (nonatomic, strong) NSArray *contentMode;

@property (nonatomic, strong) NSArray *textAlignment;

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) NSArray *fonts;

@end
