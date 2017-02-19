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
            [config setProjectName:@"ZZUIHelperProject"];
            [config resetToDefaultConfig];
        }
    });
    config.layoutLibrary = ZZUIHelperLayoutLibraryMasonry;
//    config.newLineLeftParenthesis = YES;
    return config;
}

- (void)resetToDefaultConfig
{
    [self setClassPrefix:@"ZZ"];
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


@end
