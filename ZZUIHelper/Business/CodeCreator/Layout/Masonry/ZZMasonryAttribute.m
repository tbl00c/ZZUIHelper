//
//  ZZMasonryAttribute.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZMasonryAttribute.h"

@implementation ZZMasonryAttribute

- (id)initWithAttribute:(ZZLayoutAttributeType)attributeType
{
    if (self = [super init]) {
        self.attributeType = attributeType;
        self.objectAttributeType = attributeType;
    }
    return self;
}

- (NSString *)attributeName
{
    return [ZZMasonryAttribute attributeNameForType:self.attributeType];
}

- (NSString *)objectAttributeName
{
    return [ZZMasonryAttribute attributeNameForType:self.objectAttributeType];
}

- (NSString *)relationName
{
    switch (self.relation) {
        case ZZLayoutRelationEqual:
            return @"mas_equalTo";
            break;
        case ZZLayoutRelationLessThanEqual:
            return @"mas_lessThanOrEqualTo";
            break;
        case ZZLayoutRelationGreaterThanEqual:
            return @"mas_greaterThanOrEqualTo";
            break;
            
        default:
            break;
    }
    return @"";
}

- (NSString *)constantRelationName
{
    switch (self.constantRelation) {
        case ZZLayoutConstantRelationOffset:
            return @"mas_offset";
            break;
        case ZZLayoutConstantRelationMutipliedBy:
            return @"mutipliedBy";
            break;
        case ZZLayoutConstantRelationDevidedBy:
            return @"devidedBy";
            break;
            
        default:
            break;
    }
    return @"";
}

- (NSArray *)allAttributes
{
    if (!_allAttributes) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (int i = 0; i < 13; i++) {
            [data addObject:[ZZMasonryAttribute attributeNameForType:i]];
        }
        _allAttributes = data;
    }
    return _allAttributes;
}

- (NSArray *)selectedAttributes
{
    if (!_selectedAttributes) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        switch (self.attributeType) {
            case ZZLayoutAttributeTypeLeft:
            case ZZLayoutAttributeTypeRight:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeLeft],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeRight],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeCenterX]]];
                break;
            case ZZLayoutAttributeTypeTop:
            case ZZLayoutAttributeTypeBottom:
            case ZZLayoutAttributeTypeCenterY:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeTop],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeBottom],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeCenterY]]];
                break;
            case ZZLayoutAttributeTypeEdge:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeEdge]]];
                break;
            case ZZLayoutAttributeTypeWidth:
            case ZZLayoutAttributeTypeHeight:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeWidth],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeHeight]]];
                break;
            case ZZLayoutAttributeTypeSize:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeSize]]];
                break;
            case ZZLayoutAttributeTypeLeading:
            case ZZLayoutAttributeTypeTrailing:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeLeading],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeTrailing],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeCenterX]]];
                break;
            case ZZLayoutAttributeTypeCenterX:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeLeft],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeRight],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeCenterX],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeLeading],
                                            [ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeTrailing]]];
                break;
            case ZZLayoutAttributeTypeCenter:
                [data addObjectsFromArray:@[[ZZMasonryAttribute attributeNameForType:ZZLayoutAttributeTypeCenter]]];
                break;
            default:
                break;
        }
        _selectedAttributes = data;
    }
    return _selectedAttributes;
}

+ (NSString *)attributeNameForType:(ZZLayoutAttributeType)attributeType
{
    NSString *attrbuteName;
    switch (attributeType) {
        case ZZLayoutAttributeTypeLeft:
            attrbuteName = @"left";
            break;
        case ZZLayoutAttributeTypeRight:
            attrbuteName = @"right";
            break;
        case ZZLayoutAttributeTypeTop:
            attrbuteName = @"top";
            break;
        case ZZLayoutAttributeTypeBottom:
            attrbuteName = @"bottom";
            break;
        case ZZLayoutAttributeTypeEdge:
            attrbuteName = @"edges";
            break;
        case ZZLayoutAttributeTypeWidth:
            attrbuteName = @"width";
            break;
        case ZZLayoutAttributeTypeHeight:
            attrbuteName = @"height";
            break;
        case ZZLayoutAttributeTypeSize:
            attrbuteName = @"size";
            break;
        case ZZLayoutAttributeTypeLeading:
            attrbuteName = @"leading";
            break;
        case ZZLayoutAttributeTypeTrailing:
            attrbuteName = @"trailing";
            break;
        case ZZLayoutAttributeTypeCenterX:
            attrbuteName = @"centerX";
            break;
        case ZZLayoutAttributeTypeCenterY:
            attrbuteName = @"centerY";
            break;
        case ZZLayoutAttributeTypeCenter:
            attrbuteName = @"center";
            break;
        default:
            break;
    }
    return attrbuteName;
}

- (NSString *)object
{
    if (!_object) {
        _object = @"";
    }
    return _object;
}

@end
