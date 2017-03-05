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

- (id)initWithPropertyCode:(NSString *)propertyCode
{
    if (self = [self init]) {
        _propertyCode = propertyCode;
        _selected = YES;
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

- (id)value
{
    id value = _value ? _value : self.defaultValue;
    return value;
}
- (void)setValue:(id)value
{
    _value = value;
    if (!self.alwaysSelected) {
        if (self.type == ZZPropertyTypeString || self.type == ZZPropertyTypeObject) {
            _selected = ![value isEqualToString:self.defaultValue];
        }
        else if (self.type == ZZPropertyTypeBOOL || self.type == ZZPropertyTypeNumber) {
            _selected = ([value doubleValue] != [self.defaultValue doubleValue]);
        }
    }
}

- (NSString *)codeValue
{
    if (self.type == ZZPropertyTypeBOOL) {
        return [self.value boolValue] ? @"YES" : @"NO";
    }
    else if (self.type == ZZPropertyTypeString) {
        return [NSString stringWithFormat:@"@\"%@\"", self.value];
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
