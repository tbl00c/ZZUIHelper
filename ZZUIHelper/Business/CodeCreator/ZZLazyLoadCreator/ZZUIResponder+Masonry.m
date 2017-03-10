//
//  ZZUIResponder+Masonry.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder+Masonry.h"

@implementation ZZUIResponder (Masonry)

- (NSString *)masonryCode
{
    NSMutableString *masonryCode = [[NSMutableString alloc] init];;
    if (self.remarks.length > 0) {
        [masonryCode appendFormat:@"// %@\n", self.remarks];
    }
    [masonryCode appendFormat:@"[self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n\n}];\n", self.propertyName];
    return masonryCode;
}

@end
