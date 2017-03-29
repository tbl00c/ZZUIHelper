
//
//  ZZMacros.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef ZZMacros_h
#define ZZMacros_h

#define     PMARK                   @"//MARK:"
#define     PMARK_                  @"#pragma mark - #"

#define     NEW_LINE                [ZZUIHelperConfig sharedInstance].newLineLeftParenthesis
#define     LEFT_PARENTHESIS        (NEW_LINE ? @"\n{" : @" {")

#endif /* ZZMacros_h */
