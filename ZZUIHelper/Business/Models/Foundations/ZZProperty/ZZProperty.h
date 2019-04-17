//
//  ZZProperty.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZZ_PROPERTY_LINE       [ZZProperty seperatorLine]

typedef NS_ENUM(NSInteger, ZZPropertyType) {
    ZZPropertyTypeObject,
    ZZPropertyTypeNumber,
    ZZPropertyTypeSelection,
    ZZPropertyTypeSelectionAndEdit,
    ZZPropertyTypeBOOL,
    ZZPropertyTypeString,
    ZZPropertyTypeSize,
    ZZPropertyTypePoint,
    ZZPropertyTypeEdgeInsets,
    ZZPropertyTypeRect,
    ZZPropertyTypeLine,
    ZZPropertyTypeFont,
    ZZPropertyTypeColor,
    ZZPropertyTypeCGColor,
    ZZPropertyTypeImage,
    ZZPropertyTypeEvent,
};

@interface ZZProperty : NSObject

@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) id propertyValue;

@property (nonatomic, assign) ZZPropertyType type;

@property (nonatomic, strong) id value;

@property (nonatomic, strong) id defaultValue;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong, readonly) NSString *propertyCode;

@property (nonatomic, strong) NSString *(^propertyCodeByValue)(id Value);

@property (nonatomic, strong) NSString *placeholder;

#pragma mark - 选择模式
@property (nonatomic, strong) NSArray *selectionData;

@property (nonatomic, assign) NSInteger selectIndex;

/// 直接插入代码，选中
- (id)initWithPropertyCode:(NSString *)propertyCode selected:(BOOL)selected;

- (id)initWithPropertyName:(NSString *)propertyName type:(ZZPropertyType)type defaultValue:(id)defaultValue;
- (id)initWithPropertyName:(NSString *)propertyName type:(ZZPropertyType)type defaultValue:(id)defaultValue selecetd:(BOOL)selected;
- (id)initWithPropertyName:(NSString *)propertyName selectionData:(NSArray *)selectionData andDefaultSelectIndex:(NSInteger)selectIndex;
- (id)initWithPropertyName:(NSString *)propertyName selectionData:(NSArray *)selectionData defaultValue:(NSString *)defaultValue editable:(BOOL)editable;

+ (ZZProperty *)seperatorLine;

@end

@interface ZZPropertyGroup : NSObject

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSArray *properties;

@property (nonatomic, strong) NSArray *privateProperties;

- (id)initWithGroupName:(NSString *)groupName properties:(NSArray *)properties;

- (id)initWithGroupName:(NSString *)groupName properties:(NSArray *)properties privateProperties:(NSArray *)privateProperties;

- (void)removePropertiy:(ZZProperty *)property;

@end
