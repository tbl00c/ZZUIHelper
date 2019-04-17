//
//  ZZUIButton.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIButton.h"

@implementation ZZUIButton
@synthesize events = _events;
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        ZZProperty *(^createButtonProperty)(NSString *name, ZZPropertyType pType, NSString *paramName, NSString *eventType) = ^ZZProperty *(NSString *name, ZZPropertyType pType, NSString *paramName, NSString *eventType){
            ZZProperty *property = [[ZZProperty alloc] initWithPropertyName:name type:pType defaultValue:@""];
            [property setPropertyCodeByValue:^NSString *(id value) {
                return [NSString stringWithFormat:@"set%@:%@ forState:%@", paramName, value, eventType];
            }];
            return property;
        };

        // title
        ZZProperty *(^createTitleProperty)(NSString *name, NSString *type) = ^ZZProperty *(NSString *name, NSString *type){
            return createButtonProperty(name, ZZPropertyTypeString, @"Title", type);
        };
        ZZProperty *title = createTitleProperty(@"title", NOR_ZZUIControl);
        ZZProperty *titleHL = createTitleProperty(@"titleHL", HL_ZZUIControl);
        ZZProperty *titleSelected = createTitleProperty(@"titleSelected", SEL_ZZUIControl);
        ZZProperty *titleDisabled = createTitleProperty(@"titleDisabled", DIS_ZZUIControl);
        
        // titleColor
        ZZProperty *(^createTitleColorProperty)(NSString *name, NSString *type) = ^ZZProperty *(NSString *name, NSString *type){
            return createButtonProperty(name, ZZPropertyTypeColor, @"TitleColor", type);
        };
        ZZProperty *titleColor = createTitleColorProperty(@"titleColor", NOR_ZZUIControl);
        ZZProperty *titleColorHL = createTitleColorProperty(@"titleColorHL", HL_ZZUIControl);
        ZZProperty *titleColorSelected = createTitleColorProperty(@"titleColorSelected", SEL_ZZUIControl);
        ZZProperty *titleColorDisabled = createTitleColorProperty(@"titleColorDisabled", DIS_ZZUIControl);
        
        // image
        ZZProperty *(^createImageProperty)(NSString *name, NSString *type) = ^ZZProperty *(NSString *name, NSString *type){
            return createButtonProperty(name, ZZPropertyTypeImage, @"Image", type);
        };
        ZZProperty *image = createImageProperty(@"image", NOR_ZZUIControl);
        ZZProperty *imageHL = createImageProperty(@"imageHL", HL_ZZUIControl);
        ZZProperty *imageSelected = createImageProperty(@"imageSelected", SEL_ZZUIControl);
        ZZProperty *imageDisabled = createImageProperty(@"imageDisabled", DIS_ZZUIControl);
        
        // backgroundImage
        ZZProperty *(^createBackgroundImageProperty)(NSString *name, NSString *type) = ^ZZProperty *(NSString *name, NSString *type){
            return createButtonProperty(name, ZZPropertyTypeImage, @"BackgroundImage", type);
        };
        ZZProperty *backgroundImage = createBackgroundImageProperty(@"backgroundImage", NOR_ZZUIControl);
        ZZProperty *backgroundImageHL = createBackgroundImageProperty(@"backgroundImageHL", HL_ZZUIControl);
        ZZProperty *backgroundImageSelected = createBackgroundImageProperty(@"backgroundImageSelected", SEL_ZZUIControl);
        ZZProperty *backgroundImageDisabled = createBackgroundImageProperty(@"backgroundImageDisabled", DIS_ZZUIControl);
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIButton" properties:@[title, titleHL, titleSelected, titleDisabled,
                                                                                                     titleColor, titleColorHL, titleColorSelected, titleColorDisabled,
                                                                                                     image, imageHL, imageSelected, imageDisabled,
                                                                                                     backgroundImage, backgroundImageHL, backgroundImageSelected, backgroundImageDisabled]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *touchDown = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDown" selected:NO];
        ZZEvent *touchDownRepeat = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDownRepeat" selected:NO];
        ZZEvent *touchUpInside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpInside" selected:YES];
        ZZEvent *touchUpOutside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpOutside" selected:NO];
        ZZEvent *touchCancel = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchCancel" selected:NO];
        _events = @[touchDown, touchDownRepeat, touchUpInside, touchUpOutside, touchCancel];
    }
    return _events;
}


@end
