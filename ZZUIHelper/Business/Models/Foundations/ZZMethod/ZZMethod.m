//
//  ZZMethod.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/24.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZMethod.h"

@interface ZZMethod ()

/// 是不是类方法
@property (nonatomic, assign, readonly) BOOL isClassMethod;

/// 参数
@property (nonatomic, strong, readonly) NSArray *params;

/// 方法体代码行
@property (nonatomic, strong, readonly) NSMutableArray *methodContentArray;

@end

@implementation ZZMethod
@synthesize methodName = _methodName;
@synthesize methodContent = _methodContent;
@synthesize methodContentArray = _methodContentArray;

- (id)initWithMethodName:(NSString *)methodName
{
    return [self initWithMethodName:methodName selected:YES];
}

- (id)initWithMethodName:(NSString *)methodName selected:(BOOL)selected
{
    if (self = [super init]) {
        self.methodName = methodName;
        self.selected = selected;
    }
    return self;
}

- (NSString *)methodCode
{
    NSString *code = [self.methodName stringByAppendingString:self.methodContent ? self.methodContent : @""];
    return code;
}

#pragma mark - # Method Name
- (NSString *)methodName
{
    if (!_methodName) {
        NSArray *methodNameArray = [self.methodName componentsSeparatedByString:@":"];
        // 返回值
        NSString *name = [NSString stringWithFormat:@"- (%@)", self.returnType];
        // 分段处理
        for (int i = 0; i < methodNameArray.count; i++) {
            NSString *seg = methodNameArray[i];
            // 段名
            name = [name stringByAppendingString:seg];
            // 参数
            if (i < self.params.count){
                NSString *param = self.params[i];
                name = [name stringByAppendingFormat:@":%@", param];
            }
            // 段键空格
            if (i < methodNameArray.count - 1) {
                name = [name stringByAppendingString:@" "];
            }
        }
        _methodName = name;
    }
    return _methodName;
}
- (void)setMethodName:(NSString *)methodName
{
    NSString *code = methodName.copy;
    code = [code strip];    // 去掉两边空格
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@""];    // 去掉换行
    code = [code stringByReplacingOccurrencesOfString:@"\t" withString:@""];    // 去掉制表符
    while ([code containsString:@"  "]) {       // 去掉多余的空格
        code = [code stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    if ([code hasSuffix:@";"]) {        // 去掉结尾分号
        code = [[code stringByReplacingOccurrencesOfString:@";" withString:@""] strip];
    }
    _methodName = code;
    
    // 方法类型
    _actionName = @"";
    if ([code hasPrefix:@"-"]) {
        code = [[code stringByReplacingOccurrencesOfString:@"-" withString:@""] strip];
        _methodNameWithoutParams = @"- ";
    }
    if ([code hasPrefix:@"+"]) {
        _isClassMethod = YES;
        code = [[code stringByReplacingOccurrencesOfString:@"+" withString:@""] strip];
        _methodNameWithoutParams = @"+ ";
    }
    
    // 返回值
    NSArray *codeArray = [code componentsSeparatedByString:@")"];
    if (codeArray.count == 0 || [codeArray[0] length] == 0) {
        NSLog(@"方法名解析失败");
        return;
    }
    _returnType = [codeArray[0] substringFromIndex:1];
    code = [[code substringFromIndex:_returnType.length + 2] strip];
    _returnType = [_returnType strip];
//    NSLog(@"返回值类型：(%@)", self.returnType);
    
    // 方法名和参数
    if (![code containsString:@"("]) {   // 无参数
        _actionName = [_actionName stringByAppendingString:code];
        _params = nil;
    }
    else {      // 有参数
        // 获取所有参数的类型
        codeArray = [code componentsSeparatedByString:@"("];
        codeArray = [codeArray subarrayWithRange:NSMakeRange(1, codeArray.count - 1)];  // 去除第0个
        NSMutableArray *types = [[NSMutableArray alloc] init];
        for (NSString *str in codeArray) {
            NSString *type = [str componentsSeparatedByString:@")"][0];
            code = [code stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"(%@)", type] withString:@""];
            type = type.strip;
            [types addObject:type];
        }
        
        NSMutableArray *params = [[NSMutableArray alloc] init];
        codeArray = [code componentsSeparatedByString:@" "];
        for (NSString *str in codeArray) {
            NSArray *k_n = [str componentsSeparatedByString:@":"];
            if (k_n.count != 2) {
                NSLog(@"方法名解析失败");
                return;
            }
            NSString *title = k_n[0];
            _actionName = [_actionName stringByAppendingFormat:@"%@:", title];
            
            NSString *param = k_n[1];
            [params addObject:param];
        }
        _methodNameWithoutParams = [_methodNameWithoutParams stringByAppendingString:_actionName];
//        NSLog(@"方法名-无参数：(%@)", self.methodNameWithoutParams);
        
        // 参数
        if (types.count > 0 || params.count > 0) {
            if (types.count != params.count) {
                NSLog(@"参数解析失败");
                return;
            }
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (int i = 0; i < types.count; i++) {
                NSString *type = types[i];
                NSString *name = params[i];
                ZZParam *param = [[ZZParam alloc] initWithType:type andName:name];
                [data addObject:param];
//                NSLog(@"参数：(%@)", param.param);
            }
            _params = data;
        }
    }
    self.superMethodName = code;
    
//    NSLog(@"方法名：(%@)", self.methodName);
}

#pragma mark - # 方法内容
- (NSString *)methodContent
{
    NSMutableString *content = [[NSMutableString alloc] init];
    if (self.methodContentArray.count > 0) {        // 有代码
        NSString *code = [self p_methodContentByArray:self.methodContentArray space:1];
        [content appendFormat:@"%@\n", code];
    }
    else {                                          // 无代码，自动加入return语句
        [content appendFormat:@"%@\t",(NEW_LINE ? @"\n{\n" : @" {\n")];
        if ([self.returnType hasSuffix:@"*"]) {
            [content appendString:@"return nil;"];
        }
        else if ([self.returnType isEqualToString:@"BOOL"]) {
            [content appendString:@"return YES;"];
        }
        else if ([self.returnType isEqualToString:@"CGSize"]){
            [content appendString:@"return CGSizeZero;"];
        }
        else if ([self.returnType isEqualToString:@"CGRect"]){
            [content appendString:@"return CGRectZero;"];
        }
        else if ([self.returnType isEqualToString:@"UIEdgeInsets"]){
            [content appendString:@"return UIEdgeInsetsZero;"];
        }
        else if (![self.returnType isEqualToString:@"void"]){
            [content appendString:@"return 0;"];
        }
        [content appendString:@"\n}\n"];
    }
    return content;
}

- (NSMutableArray *)methodContentArray
{
    if (!_methodContentArray) {
        _methodContentArray = [[NSMutableArray alloc] init];
    }
    return _methodContentArray;
}

- (void)addMethodContentCode:(NSString *)code
{
    NSArray *codeArray = [self p_formatMethodContentCode:code.mutableCopy];
    [self.methodContentArray addObjectsFromArray:codeArray];
}

- (BOOL)clearMethodContent
{
    _methodContent = nil;
    _methodContentArray = nil;
    return YES;
}

#pragma mark - # Private Methods
- (NSMutableArray *)p_formatMethodContentCode:(NSMutableString *)code
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    while (code.length > 0) {
        NSString *left = [code componentsSeparatedByString:@"{"][0];
        NSString *right = [code componentsSeparatedByString:@"}"][0];
        if (left.length < right.length) {       // {
            [code deleteCharactersInRange:NSMakeRange(0, left.length + 1)];
            NSArray *lineArray = [left componentsSeparatedByString:@"\n"];
            for (NSString *line in lineArray) {
                NSString *lineCode = [line strip];
                if (lineCode.length > 0) {
                    [data addObject:lineCode];
                }
            }
            if (code.length > 0) {
                NSArray *subCode = [self p_formatMethodContentCode:code];
                [data addObject:subCode];
            }
        }
        else if (left.length > right.length){   // }
            [code deleteCharactersInRange:NSMakeRange(0, right.length + 1)];
            NSArray *lineArray = [right componentsSeparatedByString:@"\n"];
            for (NSString *line in lineArray) {
                NSString *lineCode = [line strip];
                if (lineCode.length > 0) {
                    [data addObject:lineCode];
                }
            }
            return data;
        }
        else {
            NSArray *lineArray = [right componentsSeparatedByString:@"\n"];
            for (NSString *line in lineArray) {
                NSString *lineCode = [line strip];
                if (lineCode.length > 0) {
                    [data addObject:lineCode];
                }
            }
            return data;
        }
    }
    
    return data;
}

- (NSString *)p_methodContentByArray:(NSArray *)array space:(NSInteger)space
{
    NSMutableString *code = [[NSMutableString alloc] init];
    if (!NEW_LINE) {
        [code appendString:@" {\n"];
    }
    else {
        [code appendFormat:@"\n%@{\n", [self tabSpace:space - 1]];
        
    }
    for (int i = 0; i < array.count; i++) {
        id item = array[i];
        if ([item isKindOfClass:[NSString class]]) {
            [code appendFormat:@"%@%@", [self tabSpace:space], item];
            if (i == array.count - 1 || ![array[i + 1] isKindOfClass:[NSArray class]]) {
                [code appendString:@"\n"];
            }
        }
        else if ([item isKindOfClass:[NSArray class]]){
            NSString *subString = [self p_methodContentByArray:item space:space + 1];
            [code appendString:subString];
            if (i < array.count - 1 && [array[i + 1] isKindOfClass:[NSString class]] && [array[i + 1] hasPrefix:@"]"]) {        // )];
                [code appendFormat:@"%@\n", array[++i]];
            }
            else {
                [code appendString:@"\n"];
            }
        }
    }
    [code appendFormat:@"%@}", [self tabSpace:space - 1]];
    return code;
}

- (NSString *)tabSpace:(NSInteger)space
{
    NSMutableString *code = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < space; i++) {
        [code appendString:@"\t"];
    }
    return code;
}

@end
