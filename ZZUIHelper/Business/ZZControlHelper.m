//
//  ZZControlHelper.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlHelper.h"

@implementation ZZControlHelper

+ (ZZControlHelper *)sharedInstance
{
    static ZZControlHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ZZControlHelper alloc] init];
    });
    return helper;
}

- (NSArray *)controls
{
    return @[
             @"UIImageView",
             @"UILabel",
             @"UIButton",
             @"UIView",
             @"UITableView",
             @"UICollectionView",
             @"UITextField",
             @"UITextView",
             @"UIScrollView",
             @"UISwitch",
             @"NSMutableArray"];
}

- (NSArray *)contentMode
{
    return @[@"UIViewContentModeScaleToFill",
             @"UIViewContentModeScaleAspectFit",
             @"UIViewContentModeScaleAspectFill",
             @"UIViewContentModeRedraw",
             @"UIViewContentModeCenter",
             @"UIViewContentModeTop",
             @"UIViewContentModeBottom",
             @"UIViewContentModeLeft",
             @"UIViewContentModeRight",
             @"UIViewContentModeTopLeft",
             @"UIViewContentModeTopRight",
             @"UIViewContentModeBottomLeft",
             @"UIViewContentModeBottomRight"];
}

- (NSArray *)textAlignment
{
    return @[@"NSTextAlignmentLeft",
             @"NSTextAlignmentCenter",
             @"NSTextAlignmentRight"];
}

- (NSArray *)fonts
{
    if (!_fonts) {
        NSMutableArray *fonts = [[NSMutableArray alloc] init];
        for (int i = 18; i <= 42; i+=2) {
            [fonts addObject:[NSString stringWithFormat:@"zz%dpxFont", i]];
            [fonts addObject:[NSString stringWithFormat:@"zz%dpxBoldFont", i]];
        }
        
        _fonts = fonts;
    }
    return _fonts;
}

- (NSArray *)colors
{
    if (!_colors) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObjectsFromArray:@[@"clearColor",
                                      @"whiteColor",
                                      @"blackColor"]];
        [colors addObjectsFromArray:@[@"zzRedColor",
                                      @"zzRedColorWithAlpha",
                                      @"zzRedColorForZZ",
                                      @"zzRedColorForBackgroud",
                                      @"zzRedColorForButton",
                                      @"zzRedColorForButtonHighlighted",
                                      @"zzRedColorForButtonBorder",
                                      @"zzRedColorForButtonBorderHightlighted",
                                      @"zzRedColorForButtonTitle",
                                      @"zzRedColorForButtonTitleHightlighted",
                                      @"zzRedColorForButtonTitleDisable"]];
        [colors addObjectsFromArray:@[@"zzYellowColorForWarning",
                                      @"zzYellowColorForBackgroud",
                                      @"zzYellowColorForFriendComment",
                                      @"zzDarkYellocColorForFriendComment",
                                      @"zzYellocColorForFriendCommentText"]];
        [colors addObjectsFromArray:@[@"zzGreenColorForCertification",
                                      @"zzGreenColorForZhiMa",
                                      @"zzLightGreenForZhiMa",
                                      @"zzGreenColorForButton",
                                      @"zzGreenColorForButtonHL"]];
        [colors addObjectsFromArray:@[@"zzBlueColorForLink",
                                      @"zzBlueColorForGroup",
                                      @"zzBuleColorForMomentsHeader"]];
        [colors addObjectsFromArray:@[@"zzBlackColorForText",
                                      @"zzBlackColorForToast",
                                      @"zzBlackColorForButtonTitle",
                                      @"zzBlackColorForButtonTitleHightlighted",
                                      @"zzGrayColorSys"]];
        [colors addObjectsFromArray:@[@"zzWhiteColorForBackgroud",
                                      @"zzWhiteColorForPersonCentered",
                                      @"zzWhiteColorForButtonTitle"]];
        [colors addObjectsFromArray:@[@"zzDarkGrayColorForText",
                                      @"zzLightGrayColorForText",
                                      @"zzGrayColorForSeparatorLine",
                                      @"zzGrayColorForTag",
                                      @"zzGrayColorForBackgroud",
                                      @"zzGrayColorForButton",
                                      @"zzGrayColorForButtonHighlighted",
                                      @"zzGrayColorForButtonBorder",
                                      @"zzGrayColorForButtonBorderHightlighted",
                                      @"zzGrayColorForButtonBorderDisable",
                                      @"zzGrayColorForButtonTitleDisable"]];
        _colors = colors;
    }
    return _colors;
}

@end
