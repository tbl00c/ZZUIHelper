//
//  ZZPropertySectionModel.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPropertySectionModel : NSObject

@property (nonatomic, strong) NSString *sectionTitle;

@property (nonatomic, strong) NSArray *sectionData;

@property (nonatomic, assign, readonly) NSInteger count;

- (id)initWithSectionTitle:(NSString *)sectionTitle andData:(NSArray *)data;

- (id)objectAtIndex:(NSUInteger)index;

@end
