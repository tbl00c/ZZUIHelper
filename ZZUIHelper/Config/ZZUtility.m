//
//  ZZUtility.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/25.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUtility.h"

@implementation ZZUtility

+ (BOOL)isObjectType:(NSString *)typeString
{
    if ([typeString containsString:@"<"]) {
        return YES;
    }
    Class cls = NSClassFromString(typeString);
    BOOL isObjectType = (cls && [cls isSubclassOfClass:[NSObject class]]);
    return isObjectType;
}

@end
