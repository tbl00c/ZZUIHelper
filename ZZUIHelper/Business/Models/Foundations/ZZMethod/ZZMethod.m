//
//  ZZMethod.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/24.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZMethod.h"

@implementation ZZMethod
@synthesize methodNameWithParams = _methodNameWithParams;

- (NSString *)methodCode
{
    NSString *code = [self.methodNameWithParams stringByAppendingFormat:@"\n%@\n", self.methodCode];
    return code;
}

#pragma mark - # Method Name
- (NSString *)methodNameWithParams
{
    if (!_methodNameWithParams) {
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
        _methodNameWithParams = name;
    }
    return _methodNameWithParams;
}
- (void)setMethodNameWithParams:(NSString *)methodNameWithParams
{
    NSString *code = methodNameWithParams.copy;
    code = [code strip];    // 去掉两边空格
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@""];    // 去掉换行
    code = [code stringByReplacingOccurrencesOfString:@"\t" withString:@""];    // 去掉制表符
    while ([code containsString:@"  "]) {       // 去掉多余的空格
        code = [code stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    if ([code hasSuffix:@";"]) {        // 去掉结尾分号
        code = [[code stringByReplacingOccurrencesOfString:@";" withString:@""] strip];
    }
    _methodNameWithParams = code;
    
    // 方法类型
    if ([code hasPrefix:@"-"]) {
        code = [[code stringByReplacingOccurrencesOfString:@"-" withString:@""] strip];
        _methodName = @"-";
    }
    if ([code hasPrefix:@"+"]) {
        _isClassMethod = YES;
        code = [[code stringByReplacingOccurrencesOfString:@"+" withString:@""] strip];
        _methodName = @"+";
    }
    
    // 返回值
    NSArray *codeArray = [code componentsSeparatedByString:@")"];
    if (codeArray.count == 0) {
        NSLog(@"方法名解析失败");
    }
    _returnType = [codeArray[0] substringFromIndex:1];
    code = [[code substringFromIndex:_returnType.length + 2] strip];
    _returnType = [_returnType strip];
    NSLog(@"返回值类型：(%@)", self.returnType);
    
    // 方法名和参数
    if (![code containsString:@"("]) {   // 无参数
        _methodName = [_methodName stringByAppendingFormat:@" %@:", code];
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
            _methodName = [_methodName stringByAppendingFormat:@" %@:", title];
            
            NSString *param = k_n[1];
            [params addObject:param];
        }
        NSLog(@"方法名：(%@)", self.methodName);
        
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
                NSLog(@"参数：(%@)", param.param);
            }
            _params = data;
        }
    }
}

@end
