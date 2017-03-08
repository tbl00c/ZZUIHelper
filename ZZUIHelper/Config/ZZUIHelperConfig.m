//
//  ZZUIHelperConfig.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIHelperConfig.h"
#import "NSDate+Extension.h"

@implementation ZZUIHelperConfig

+ (ZZUIHelperConfig *)sharedInstance
{
    static ZZUIHelperConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[ZZUIHelperConfig alloc] init];
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstRun"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstRun"];
            // 默认设置
            [config setAuthorName:@"ZZUIHelper"];
            [config setProjectName:@"zhuanzhuan"];
            [config resetToDefaultConfig];
        }
    });
    return config;
}

- (void)resetToDefaultConfig
{
    [self setClassPrefix:@"ZZ"];
    [self setNewLineLeftParenthesis:NO];
    [self setLayoutLibrary:ZZUIHelperLayoutLibraryMasonry];
}

- (NSString *)copyrightCodeByFileName:(NSString *)fileName
{
    NSString *authorName = self.authorName;
    NSString *projectName = self.projectName;
    NSString *dateString = [NSString stringWithFormat:@"%d/%d/%d", (int)[[NSDate date] year], (int)[[NSDate date] month], (int)[[NSDate date] day]];
    NSString *codeString = [NSString stringWithFormat:@"//\n//  %@\n//  %@\n//\n//  Created by %@ on %@.\n//  Copyright © 2017年 %@. All rights reserved.\n//\n\n",
                            fileName,
                            projectName,
                            authorName, dateString,
                            authorName];
    return codeString;
}

//MARK: 用户名
- (NSString *)authorName
{
    NSString *authorName = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorName"];
    return authorName;
}
- (void)setAuthorName:(NSString *)authorName
{
    [[NSUserDefaults standardUserDefaults] setObject:authorName ? authorName : @"" forKey:@"authorName"];
}

//MARK: 项目名称
- (NSString *)projectName
{
    NSString *projectName = [[NSUserDefaults standardUserDefaults] objectForKey:@"projectName"];
    return projectName;
}
- (void)setProjectName:(NSString *)projectName
{
    [[NSUserDefaults standardUserDefaults] setObject:projectName ? projectName : @"" forKey:@"projectName"];
}

//MARK: 类前缀
- (NSString *)classPrefix
{
    NSString *classPrefix = [[NSUserDefaults standardUserDefaults] objectForKey:@"classPrefix"];
    return classPrefix;
}
- (void)setClassPrefix:(NSString *)classPrefix
{
    [[NSUserDefaults standardUserDefaults] setObject:classPrefix ? classPrefix : @"" forKey:@"classPrefix"];
}

//MARK: 风格
- (BOOL)newLineLeftParenthesis
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"newLineLeftParenthesis"];
    return number.boolValue;
}
- (void)setNewLineLeftParenthesis:(BOOL)newLineLeftParenthesis
{
    [[NSUserDefaults standardUserDefaults] setObject:@(newLineLeftParenthesis) forKey:@"newLineLeftParenthesis"];
}

//MARK: 布局
- (ZZUIHelperLayoutLibrary)layoutLibrary
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"layoutLibrary"];
    return number.integerValue;
}
- (void)setLayoutLibrary:(ZZUIHelperLayoutLibrary)layoutLibrary
{
    [[NSUserDefaults standardUserDefaults] setObject:@(layoutLibrary) forKey:@"layoutLibrary"];
}

#pragma mark - # 控件可配置属性
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
