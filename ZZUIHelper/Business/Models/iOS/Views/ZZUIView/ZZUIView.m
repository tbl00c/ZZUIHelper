//
//  ZZUIView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"

@implementation ZZUIView
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        _delegates = @[];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        [_properties addObjectsFromArray:self.layer.properties];
        ZZProperty *tag = [[ZZProperty alloc] initWithPropertyName:@"tag" type:ZZPropertyTypeNumber defaultValue:@(0)];
        ZZProperty *color = [[ZZProperty alloc] initWithPropertyName:@"backgroundColor" type:ZZPropertyTypeObject defaultValue:@"[UIColor clearColor]"];
        ZZProperty *alpha = [[ZZProperty alloc] initWithPropertyName:@"alpha" type:ZZPropertyTypeNumber defaultValue:@(1)];
        ZZProperty *hidden = [[ZZProperty alloc] initWithPropertyName:@"hidden" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *userInteractionEnabled = [[ZZProperty alloc] initWithPropertyName:@"userInteractionEnabled" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *contentMode = [[ZZProperty alloc] initWithPropertyName:@"contentMode" selectionData:[ZZControlHelper sharedInstance].contentMode andDefaultSelectIndex:0];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIView" properties:@[tag, color, alpha, hidden, userInteractionEnabled, contentMode]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSString *)implementationInitCode
{
    NSString *code = @"";
    NSArray *childViewArray = self.childViewsArray;
    if (childViewArray.count > 0) {
        ZZMethod *initMethod = [[ZZMethod alloc] initWithMethodName:self.m_initMethodName];
        NSMutableString *initCode = [NSMutableString stringWithFormat:@"if (self = [super %@]) {", initMethod.superMethodName];
        for (ZZUIView *view in childViewArray) {
            [initCode appendFormat:@"[%@ addSubview:self.%@];\n", self.curView, view.propertyName];
        }
        
        if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
            [initCode appendString:@"[self p_addMasonry];\n"];
        }
        
        [initCode appendString:@"}\nreturn self;\n"];
        
        [initMethod addMethodContentCode:initCode];
        code = [initMethod methodCode];
    }

    return [code stringByAppendingString:@"\n"];
}

- (NSString *)m_initMethodName
{
    return @"- (id)initWithFrame:(CGRect)frame";
}

- (ZZCALayer *)layer
{
    if (!_layer) {
        _layer = [[ZZCALayer alloc] init];
    }
    return _layer;
}

@end
