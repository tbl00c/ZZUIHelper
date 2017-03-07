//
//  ZZControlHelper.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZControlHelper : NSObject

@property (nonatomic, strong) NSArray *controls;

@property (nonatomic, strong) NSArray *contentMode;

@property (nonatomic, strong) NSArray *textAlignment;

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, strong) NSArray *fonts;

+ (ZZControlHelper *)sharedInstance;

@end
