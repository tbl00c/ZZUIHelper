//
//  ZZUIView+Masonry.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView+Masonry.h"

@implementation ZZUIView (Masonry)

- (id)init
{
    if (self = [super init]) {
        [self.layouts addObjectsFromArray:[self masonryLayouts]];
    }
    return self;
}

- (NSString *)masonryCode
{
    NSMutableString *masonryCode = [[NSMutableString alloc] init];;
    if (self.remarks.length > 0) {
        [masonryCode appendFormat:@"// %@\n", self.remarks];
    }
    [masonryCode appendFormat:@"[self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n", self.propertyName];
    for (ZZMasonryAttribute *attribute in self.layouts) {
        if (attribute.selected) {
            [masonryCode appendFormat:@"make.%@.mas_%@(", attribute.attributeName, attribute.relationName];
            
            // 约束
            if (attribute.object.length > 0 && ![attribute.object isEqualToString:@"superView"]) {
                [masonryCode appendFormat:@"self.%@", attribute.object];
            }
            else {
                [masonryCode appendString:self.superView.curView];
            }
            if (attribute.objectAttributeType != attribute.attributeType) {
                [masonryCode appendFormat:@".mas_%@", attribute.objectAttributeName];
            }
            [masonryCode appendString:@")"];
            
            // 相对偏移量
            if (attribute.constant.length > 0) {
                NSString *constant;
                if ([attribute.constant isPureNumber]) {
                    constant = attribute.constant;
                }
                else if (attribute.attributeType == ZZLayoutAttributeTypeSize) {
                    constant = [NSString stringWithFormat:@"CGSizeMake(%@)", attribute.object];
                }
                else if (attribute.attributeType == ZZLayoutAttributeTypeCenter) {
                    constant = [NSString stringWithFormat:@"CGPointMake(%@)", attribute.object];
                }
                else if (attribute.attributeType == ZZLayoutAttributeTypeEdge) {
                    constant = [NSString stringWithFormat:@"UIEdgeInsetsMake(%@)", attribute.object];
                }
                [masonryCode appendFormat:@".mas_%@(%@)", attribute.constantRelationName, constant];
            }
            
            // 优先级
            if (attribute.priority.length > 0) {
                if ([attribute.priority isPureNumber]) {
                    [masonryCode appendFormat:@".priority(%@)", attribute.priority];
                }
                else {
                    [masonryCode appendFormat:@".priority%@()", [attribute.priority uppercaseFirstCharacter]];
                }
            }
            [masonryCode appendString:@";\n"];
        }
    }
    [masonryCode appendString:@"\n}];\n"];
    return masonryCode;
}

- (NSArray *)masonryLayouts
{
    NSMutableArray *masonryLayouts = [[NSMutableArray alloc] init];
    for (int i = 0; i < 13; i++) {
        ZZMasonryAttribute *attribute = [[ZZMasonryAttribute alloc] initWithAttribute:i];
        [masonryLayouts addObject:attribute];
    }
    return masonryLayouts;
}

@end
