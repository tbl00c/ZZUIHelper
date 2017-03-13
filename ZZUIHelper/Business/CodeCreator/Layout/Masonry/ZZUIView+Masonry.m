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
    NSString *(^getConstantValueFromAttribute)(ZZMasonryAttribute *attribute) = ^NSString *(ZZMasonryAttribute *attribute) {
        NSString *constant;
        if ([attribute.constant isPureNumber]) {
            constant = attribute.constant;
        }
        else if (attribute.attributeType == ZZLayoutAttributeTypeSize) {
            constant = [NSString stringWithFormat:@"CGSizeMake(%@)", attribute.constant];
        }
        else if (attribute.attributeType == ZZLayoutAttributeTypeCenter) {
            constant = [NSString stringWithFormat:@"CGPointMake(%@)", attribute.constant];
        }
        else if (attribute.attributeType == ZZLayoutAttributeTypeEdge) {
            constant = [NSString stringWithFormat:@"UIEdgeInsetsMake(%@)", attribute.constant];
        }
        return constant;
    };
    
    NSString *(^getObjectNameFromAttribute)(ZZMasonryAttribute *attribute) = ^NSString *(ZZMasonryAttribute *attribute) {
        // 约束对象不同
        if (attribute.object.length > 0 && ![attribute.object isEqualToString:@"superView"]) {
            NSString *object = [@"self." stringByAppendingString:attribute.object];
            if (attribute.attributeType != attribute.objectAttributeType) {
                object = [object stringByAppendingFormat:@".mas_%@", attribute.objectAttributeName];
            }
            return object;
        }
        
        // 约束条件不同
        if (attribute.attributeType != attribute.objectAttributeType) {
            return [self.superViewName stringByAppendingFormat:@".mas_%@", attribute.objectAttributeName];
        }
        
        // 设置了superView，且约束条件与大小有关
        if ([attribute.object isEqualToString:@"superView"]
            && (attribute.attributeType == ZZLayoutAttributeTypeWidth
                || attribute.attributeType == ZZLayoutAttributeTypeHeight
                || attribute.attributeType == ZZLayoutAttributeTypeSize)
            ) {
            return self.superViewName;
        }
        
        // 常量意义不是+
        if (attribute.constantRelation != ZZLayoutConstantRelationOffset) {
            return self.superViewName;
        }
        
        return nil;
    };
    
    NSMutableString *masonryCode = [[NSMutableString alloc] init];;
    if (self.remarks.length > 0) {
        [masonryCode appendFormat:@"// %@\n", self.remarks];
    }
    [masonryCode appendFormat:@"[self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n", self.propertyName];
    for (ZZMasonryAttribute *attribute in self.layouts) {
        if (attribute.selected) {
            [masonryCode appendFormat:@"make.%@.%@(", attribute.attributeName, attribute.relationName];
            
            // 约束
            NSString *object = getObjectNameFromAttribute(attribute);
            if (object) {
                [masonryCode appendFormat:@"%@)", object];
                if (attribute.constant.length > 0) {
                    NSString *constant = getConstantValueFromAttribute(attribute);
                    [masonryCode appendFormat:@".%@(%@)", attribute.constantRelationName, constant];
                }
            }
            else if (attribute.constant.length > 0) {
                NSString *constant = getConstantValueFromAttribute(attribute);
                [masonryCode appendFormat:@"%@)", constant];
            }
            else {
                [masonryCode appendString:@"0)"];
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
