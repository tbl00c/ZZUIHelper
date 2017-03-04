//
//  ZZProperty.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZProperty : NSObject

@property (nonatomic, strong) NSString *propertyName;

@property (nonatomic, strong) id value;

@property (nonatomic, strong) id defaultValue;

@property (nonatomic, assign) BOOL selected;

@end
