//
//  ZZProperty.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/4.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZProperty.h"

@interface ZZProperty ()

@property (nonatomic, assign) BOOL alwaysSelected;

@end

@implementation ZZProperty
@synthesize value = _value;
@synthesize propertyCode = _propertyCode;

+ (ZZProperty *)seperatorLine
{
    ZZProperty *line = [[ZZProperty alloc] init];
    [line setType:ZZPropertyTypeLine];
    return line;
}

- (id)init
{
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        [self setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"set%@:%@", [weakSelf.propertyName uppercaseFirstCharacter], value];
        }];
    }
    return self;
}

- (id)initWithPropertyCode:(NSString *)propertyCode selected:(BOOL)selected
{
    if (self = [self init]) {
        _propertyCode = propertyCode;
        _selected = selected;
    }
    return self;
}

- (id)initWithPropertyName:(NSString *)propertyName type:(ZZPropertyType)type defaultValue:(id)defaultValue
{
    return [self initWithPropertyName:propertyName type:type defaultValue:defaultValue selecetd:NO];
}

- (id)initWithPropertyName:(NSString *)propertyName type:(ZZPropertyType)type defaultValue:(id)defaultValue selecetd:(BOOL)selected
{
    if (self = [self init]) {
        _propertyName = propertyName;
        _defaultValue = defaultValue;
        _selected = selected;
        _type = type;
        _alwaysSelected = selected;
    }
    return self;
}

- (id)initWithPropertyName:(NSString *)propertyName selectionData:(NSArray *)selectionData andDefaultSelectIndex:(NSInteger)selectIndex
{
    if (self = [self initWithPropertyName:propertyName selectionData:selectionData defaultValue:selectionData[selectIndex] editable:NO]){
        self.selectIndex = selectIndex;
    }
    return self;
}

- (id)initWithPropertyName:(NSString *)propertyName selectionData:(NSArray *)selectionData defaultValue:(NSString *)defaultValue editable:(BOOL)editable
{
    if (self = [self init]) {
        _type = editable ? ZZPropertyTypeSelectionAndEdit : ZZPropertyTypeSelection;
        _propertyName = propertyName;
        _selectionData = selectionData;
        _selectIndex = 0;
        _defaultValue = defaultValue;
    }
    return self;
}


- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    if (selectIndex >= 0 && selectIndex < self.selectionData.count) {
        self.value = self.selectionData[selectIndex];
    }
}

- (id)value
{
    id value = _value ? _value : self.defaultValue;
    return value;
}
- (void)setValue:(id)value
{
    _value = value;
    if (!self.alwaysSelected) {
        CGFloat (^getCGFloatValueFormDic)(NSDictionary *dic, NSString *key) = ^CGFloat(NSDictionary *dic, NSString *key) {
            NSString *value = [dic objectForKey:key];
            return [value doubleValue];
        };
        
        if (self.type == ZZPropertyTypeString || self.type == ZZPropertyTypeObject || self.type == ZZPropertyTypeSelection || self.type == ZZPropertyTypeSelectionAndEdit) {
            _selected = ![value isEqualToString:self.defaultValue];
        }
        else if (self.type == ZZPropertyTypeBOOL) {
            _selected = ([value integerValue] != [self.defaultValue integerValue]);
        }
        else if (self.type == ZZPropertyTypeNumber) {
            _selected = ([value doubleValue] != [self.defaultValue doubleValue]);
        }
        else if (self.type == ZZPropertyTypePoint) {
            _selected = !(getCGFloatValueFormDic(value, @"x") == getCGFloatValueFormDic(self.defaultValue, @"x") &&
                         getCGFloatValueFormDic(value, @"y") == getCGFloatValueFormDic(self.defaultValue, @"y"));
        }
        else if (self.type == ZZPropertyTypeSize) {
            _selected = !(getCGFloatValueFormDic(value, @"w") == getCGFloatValueFormDic(self.defaultValue, @"w") &&
                         getCGFloatValueFormDic(value, @"h") == getCGFloatValueFormDic(self.defaultValue, @"h"));
        }
        else if (self.type == ZZPropertyTypeRect) {
            _selected = !(getCGFloatValueFormDic(value, @"x") == getCGFloatValueFormDic(self.defaultValue, @"x") &&
                          getCGFloatValueFormDic(value, @"y") == getCGFloatValueFormDic(self.defaultValue, @"y") &&
                          getCGFloatValueFormDic(value, @"w") == getCGFloatValueFormDic(self.defaultValue, @"w") &&
                          getCGFloatValueFormDic(value, @"h") == getCGFloatValueFormDic(self.defaultValue, @"h"));
        }
        else if (self.type == ZZPropertyTypeEdgeInsets) {
            _selected = !(getCGFloatValueFormDic(value, @"t") == getCGFloatValueFormDic(self.defaultValue, @"t") &&
                          getCGFloatValueFormDic(value, @"l") == getCGFloatValueFormDic(self.defaultValue, @"l") &&
                          getCGFloatValueFormDic(value, @"b") == getCGFloatValueFormDic(self.defaultValue, @"b") &&
                          getCGFloatValueFormDic(value, @"r") == getCGFloatValueFormDic(self.defaultValue, @"t"));
        }
    }
}

- (NSString *)codeValue
{
    CGFloat (^getCGFloatValueFormDic)(NSDictionary *dic, NSString *key) = ^CGFloat(NSDictionary *dic, NSString *key) {
        NSString *value = [dic objectForKey:key];
        return [value doubleValue];
    };
    if (self.type == ZZPropertyTypeBOOL) {
        return [self.value boolValue] ? @"YES" : @"NO";
    }
    else if (self.type == ZZPropertyTypeString) {
        return [NSString stringWithFormat:@"@\"%@\"", self.value];
    }
    else if (self.type == ZZPropertyTypePoint) {
        CGFloat x = getCGFloatValueFormDic(self.value, @"x");
        CGFloat y = getCGFloatValueFormDic(self.value, @"y");
        return [NSString stringWithFormat:@"CGPointMake(%.0lf, %.0lf)", x, y];
    }
    else if (self.type == ZZPropertyTypeSize) {
        CGFloat w = getCGFloatValueFormDic(self.value, @"w");
        CGFloat h = getCGFloatValueFormDic(self.value, @"h");
        return [NSString stringWithFormat:@"CGSizeMake(%.0lf, %.0lf)", w, h];
    }
    else if (self.type == ZZPropertyTypeRect) {
        CGFloat x = getCGFloatValueFormDic(self.value, @"x");
        CGFloat y = getCGFloatValueFormDic(self.value, @"y");
        CGFloat w = getCGFloatValueFormDic(self.value, @"w");
        CGFloat h = getCGFloatValueFormDic(self.value, @"h");
        return [NSString stringWithFormat:@"CGRectMake(%.0lf, %.0lf, %.0lf, %.0lf)", x, y, w, h];
    }
    else if (self.type == ZZPropertyTypeEdgeInsets) {
        CGFloat t = getCGFloatValueFormDic(self.value, @"t");
        CGFloat l = getCGFloatValueFormDic(self.value, @"l");
        CGFloat b = getCGFloatValueFormDic(self.value, @"b");
        CGFloat r = getCGFloatValueFormDic(self.value, @"r");
        return [NSString stringWithFormat:@"UIEdgeInsetsMake(%.0lf, %.0lf, %.0lf, %.0lf)", t, l, b, r];
    }
    return self.value;
}

- (NSString *)propertyCode
{
    if (!_propertyCode) {
        return self.propertyCodeByValue(self.codeValue);
    }
    return _propertyCode;
}

- (id)defaultValue
{
    if (!_defaultValue) {
        if (self.type == ZZPropertyTypePoint) {
            _defaultValue = @{@"x" : @(0),
                              @"y" : @(0)};
        }
        else if (self.type == ZZPropertyTypeSize) {
            _defaultValue = @{@"w" : @(0),
                              @"h" : @(0)};
        }
        else if (self.type == ZZPropertyTypeRect) {
            _defaultValue = @{@"x" : @(0),
                              @"y" : @(0),
                              @"w" : @(0),
                              @"h" : @(0)};
        }
        else if (self.type == ZZPropertyTypeEdgeInsets) {
            _defaultValue = @{@"t" : @(0),
                              @"l" : @(0),
                              @"b" : @(0),
                              @"r" : @(0)};
        }
        else if (self.type == ZZPropertyTypeNumber) {
            _defaultValue = @(0);
        }
        else {
            _defaultValue = @"";
        }
    }
    return _defaultValue;
}

- (NSString *)placeholder
{
    if (!_placeholder) {
        return self.propertyName;
    }
    return _placeholder;
}

@end

@implementation ZZPropertyGroup

- (id)initWithGroupName:(NSString *)groupName properties:(NSArray *)properties
{
    return [self initWithGroupName:groupName properties:properties privateProperties:nil];
}

- (id)initWithGroupName:(NSString *)groupName properties:(NSArray *)properties privateProperties:(NSArray *)privateProperties
{
    if (self = [super init]) {
        self.groupName = groupName;
        self.properties = properties;
        self.privateProperties = privateProperties;
    }
    return self;
}

- (void)removePropertiy:(ZZProperty *)property
{
    if ([self.properties containsObject:property]) {
        NSMutableArray *data = self.properties.mutableCopy;
        [data removeObject:property];
        _properties = data;
    }
}

@end
