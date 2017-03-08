//
//  NSString+MMBJ.m
//  ModelMakeByJSON
//
//  Created by 李伯坤 on 2017/2/16.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSString+MMBJ.h"

@implementation NSString (MMBJ)

- (NSString *)uppercaseFirstCharacter
{
    if (self.length > 0) {
        char c = [self characterAtIndex:0];
        if (c >= 'a' && c <= 'z') {
            return [NSString stringWithFormat:@"%c%@", toupper(c), [self substringFromIndex:1]];
        }
    }
    return self;
}

- (NSString *)lowerFirstCharacter
{
    char c = [self characterAtIndex:0];
    if (c >= 'A' && c <= 'Z') {
        return [NSString stringWithFormat:@"%c%@", tolower(c), [self substringFromIndex:1]];
    }
    return self;
}

- (NSString *)strip
{
    NSString *stripString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return stripString;
}

- (BOOL)isPureNumber
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int vInt;
    BOOL ok = [scan scanInt:&vInt] && [scan isAtEnd];
    if (!ok) {
        scan = [NSScanner scannerWithString:self];
        float vFloat;
        ok = [scan scanFloat:&vFloat] && [scan isAtEnd];
    }
    return ok;
}

@end
