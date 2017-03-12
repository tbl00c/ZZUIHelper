//
//  ZZMasonryAttribute.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZLayoutRelation) {
    ZZLayoutRelationEqual = 0,
    ZZLayoutRelationLessThanEqual,
    ZZLayoutRelationGreaterThanEqual,
};

typedef NS_ENUM(NSInteger, ZZLayoutConstantRelation) {
    ZZLayoutConstantRelationOffset = 0,
    ZZLayoutConstantRelationMutipliedBy,
    ZZLayoutConstantRelationDevidedBy,
};


typedef NS_ENUM(NSInteger, ZZLayoutAttributeType) {
    ZZLayoutAttributeTypeLeft = 0,
    ZZLayoutAttributeTypeRight,
    ZZLayoutAttributeTypeTop,
    ZZLayoutAttributeTypeBottom,
    ZZLayoutAttributeTypeEdge,
    
    ZZLayoutAttributeTypeLeading,
    ZZLayoutAttributeTypeTrailing,
    
    ZZLayoutAttributeTypeWidth,
    ZZLayoutAttributeTypeHeight,
    ZZLayoutAttributeTypeSize,
    
    ZZLayoutAttributeTypeCenterX,
    ZZLayoutAttributeTypeCenterY,
    ZZLayoutAttributeTypeCenter,
};

@interface ZZMasonryAttribute : NSObject

@property (nonatomic, assign) ZZLayoutAttributeType attributeType;
@property (nonatomic, strong, readonly) NSString *attributeName;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) ZZLayoutRelation relation;
@property (nonatomic, strong) NSString *relationName;

@property (nonatomic, strong) NSString *object;

@property (nonatomic, assign) ZZLayoutAttributeType objectAttributeType;
@property (nonatomic, strong, readonly) NSString *objectAttributeName;

@property (nonatomic, assign) ZZLayoutConstantRelation constantRelation;
@property (nonatomic, strong) NSString *constantRelationName;

@property (nonatomic, strong) NSString *constant;

@property (nonatomic, strong) NSString *priority;

@property (nonatomic, strong) NSArray *allAttributes;
@property (nonatomic, strong) NSArray *selectedAttributes;

+ (NSString *)attributeNameForType:(ZZLayoutAttributeType)attributeType;

- (id)initWithAttribute:(ZZLayoutAttributeType)attribute;

@end
