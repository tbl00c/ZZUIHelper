//
//  ZZPropertySectionModel.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZPropertySectionType) {
    ZZPropertySectionTypeProperty,
    ZZPropertySectionTypeEvent,
    ZZPropertySectionTypeDelegate,
};

@interface ZZPropertySectionModel : NSObject

@property (nonatomic, assign) ZZPropertySectionType sectionType;

@property (nonatomic, strong) NSString *sectionTitle;

@property (nonatomic, strong) NSArray *sectionData;

@property (nonatomic, assign, readonly) NSInteger count;

/// 显示所有的元素，默认YES
@property (nonatomic, assign) BOOL showAllItems;

- (id)initWithSectionType:(ZZPropertySectionType)sectionType title:(NSString *)sectionTitle andData:(NSArray *)data;

- (id)objectAtIndex:(NSUInteger)index;

@end
