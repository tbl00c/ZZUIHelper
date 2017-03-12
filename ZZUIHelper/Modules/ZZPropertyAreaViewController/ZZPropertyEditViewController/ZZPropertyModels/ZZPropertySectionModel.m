//
//  ZZPropertySectionModel.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertySectionModel.h"

@implementation ZZPropertySectionModel

- (id)initWithSectionType:(ZZPropertySectionType)sectionType title:(NSString *)sectionTitle andData:(NSArray *)data;
{
    if (self = [super init]) {
        self.sectionType = sectionType;
        self.sectionTitle = sectionTitle;
        self.sectionData = data;
        self.showAllItems = YES;
    }
    return self;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return index < self.sectionData.count ? self.sectionData[index] : nil;
}

- (NSInteger)count
{
    return self.sectionData.count;
}

@end
