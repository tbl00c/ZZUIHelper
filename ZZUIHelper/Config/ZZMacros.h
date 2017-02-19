
//
//  ZZMacros.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef ZZMacros_h
#define ZZMacros_h

#define     PMARK                   @"#pragma mark"
#define     PMARK_                  @"#pragma mark -"

#define     NEWLINE                 ([ZZUIHelperConfig sharedInstance].newLineLeftParenthesis

// loadView
#define     M_LOADVIEW(code)        [NSString stringWithFormat:@"\
- (void)loadView\
%@{\n\
\t[super loadView];\n\n\
%@\
%@\
}\n\n\
",\
([ZZUIHelperConfig sharedInstance].newLineLeftParenthesis ? @"\n" : @" "), /*是否换行*/\
code, /*自定义代码*/\
([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry ? @"\t[self p_addMasonry];\n" : @"")] /*是否使用了Masonry*/


// viewDidLoad
#define     M_VIEWDIDLOAD(code)     [NSString stringWithFormat:@"\
- (void)viewDidLoad%@{\n\
\t[super viewDidLoad];\n\n\
%@\
}\n\n\
",\
NEWLINE ? @"\n" : @" "),/*是否换行*/\
code] /*自定义代码*/

// initWithFrame
#define     M_INITWITHFRAME(code)        [NSString stringWithFormat:@"\
- (id)initWithFrame:(CGRect)frame\
%@{\n\
\tif(self = [super initWithFrame:frame])%@{\n\
%@\
%@\
\t}\n\
\treturn self;\n\
}\n\n\
",\
NEWLINE ? @"\n" : @" "), /*是否换行*/\
NEWLINE ? @"\n\t" : @" "), /*是否换行*/\
code, /*自定义代码*/\
([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry ? @"\t\t[self p_addMasonry];\n" : @"")] /*是否使用了Masonry*/

// getter
#define     M_GETTER(class, name, code)              [NSString stringWithFormat:@"\
- (%@ *)%@\
%@{\n\
\tif(!_%@)\
%@{\n\
\t\t_%@ = [[%@ alloc] init];\n\
%@\
\t}\n\
\treturn _%@;\n\
}\n\n\
",\
class, name,\
NEWLINE ? @"\n" : @" "), /*是否换行*/\
name,\
NEWLINE ? @"\t\n" : @" "), /*是否换行*/\
name, class,\
code,\
name]

// action
#define     M_ACTION(class, name, code)             [NSString stringWithFormat:@"\
- (void)%@(%@ *)sender\
%@{\n\
%@\
}\n\n\
",\
name, class,\
NEWLINE ? @"\n" : @" "), /*是否换行*/\
code]

// Masonry
#define     M_P_ADDMASONRY(code)                    [NSString stringWithFormat:@"\
- (void)p_addMasonry\
%@{\n\
%@\
}\n\n\
",\
NEWLINE ? @"\n" : @" "), /*是否换行*/\
code]

#define     M_MASONRY(name, code)                   [NSString stringWithFormat:@"\
\t[self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n\
%@\
\t];\n\
",\
name,\
code]


#endif /* ZZMacros_h */
