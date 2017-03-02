//
//  ZZUIResponder.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"
#import "ZZUIControl.h"
#import "ZZUIScrollView.h"
#import "ZZUITableView.h"
#import "ZZUICollectionView.h"
#import "ZZProtocol.h"
#import "ZZNSMutableArray.h"

@implementation ZZUIResponder

#pragma mark - # .h 文件代码
- (NSString *)hFileCode
{
    NSString *fileName = [self.className stringByAppendingString:@".h"];
    NSString *copyrightCode = [[ZZUIHelperConfig sharedInstance] copyrightCodeByFileName:fileName];
    NSString *code = [NSString stringWithFormat:@"%@#import <UIKit/UIKit.h>\n\n%@", copyrightCode, self.interfaceCode];
    return code;
}

- (NSString *)interfaceCode
{
    NSString *interfaceCode = [NSString stringWithFormat:@"@interface %@ : %@\n\n", self.className, self.superClassName];
    
    for (ZZNSObject *object in self.interfaceProperties) {
        if (object.propertyCode.length > 0) {
            interfaceCode = [interfaceCode stringByAppendingFormat:@"%@\n", object.propertyCode];
        }
    }
    
    interfaceCode = [interfaceCode stringByAppendingString:@"@end\n"];
    return interfaceCode;
}

- (void)addPublicProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:@"data"]) {
        ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
        [self addPublicProperty:data withName:@"data" andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
    }
    NSMutableArray *array = self.interfaceProperties ? self.interfaceProperties.mutableCopy : @[].mutableCopy;
    [array addObject:property];
    _interfaceProperties = array;
}

- (BOOL)removePublicProperty:(ZZNSObject *)property
{
    if ([self.interfaceProperties containsObject:property]) {
        NSMutableArray *array = self.interfaceProperties.mutableCopy;
        [array removeObject:property];
        _interfaceProperties = array;
        return YES;
    }
    return NO;
}

#pragma mark - # .m 文件代码
- (NSString *)mFileCode
{
    NSString *fileName = [self.className stringByAppendingString:@".m"];
    NSString *copyrightCode = [[ZZUIHelperConfig sharedInstance] copyrightCodeByFileName:fileName];
    NSString *code = [copyrightCode stringByAppendingFormat:@"#import \"%@.h\"\n\n", self.className];
    if (self.extensionCode.length > 0) {        // 类拓展
        code = [code stringByAppendingString:self.extensionCode];
    }
    code = [code stringByAppendingString:self.implementationCode];
    return code;
}

/// 类拓展
- (NSString *)extensionCode
{
    NSArray *delegatesArray = self.childDelegateViewsArray;
    if (self.extensionProperties.count > 0 || delegatesArray.count > 0) {
        NSString *extensionCode = [NSString stringWithFormat:@"@interface %@ ()", self.className];
        if (delegatesArray.count > 0) {    // 协议
            NSString *delegateCode = @"";
            for (ZZProtocol *protocol in delegatesArray) {
                if (delegateCode.length > 0) {
                    delegateCode = [delegateCode stringByAppendingString:@",\n"];
                }
                delegateCode = [delegateCode stringByAppendingString:protocol.protocolName];
            }
            extensionCode = [extensionCode stringByAppendingFormat:@" <\n%@\n>", delegateCode];
        }
        
        extensionCode = [extensionCode stringByAppendingString:@"\n\n"];
        for (ZZNSObject *object in self.extensionProperties) {
            if (object.propertyCode.length > 0) {
                extensionCode = [extensionCode stringByAppendingFormat:@"%@\n", object.propertyCode];
            }
        }
        extensionCode = [extensionCode stringByAppendingString:@"@end\n\n"];
        return extensionCode;
    }
    return nil;
}

/// 实现
- (NSString *)implementationCode
{
    NSString *implementationCode = [NSString stringWithFormat:@"@implementation %@\n\n", self.className];
    
    // 初始化代码
    NSString *initCode = self.implementationInitCode;
    if (initCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:initCode];
    }
    
    // Delegate代码
    NSString *delegateCode = self.implementationDelegateCode;
    if (delegateCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:delegateCode];
    }
    
    // Event Response代码
    NSString *eventCode = self.implementationEventCode;
    if (eventCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:eventCode];
    }
    
    // Private Methods代码
    NSString *privateCode = self.implementationPrivateCode;
    if (privateCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:privateCode];
    }
    
    // Getter 代码
    NSString *getterCode = self.implementationGetterCode;
    if (getterCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:getterCode];
    }
    
    implementationCode = [implementationCode stringByAppendingString:@"@end\n"];
    return implementationCode;
}

- (NSString *)implementationDelegateCode
{
    NSArray *delegateArray = self.childDelegateViewsArray;
    if (delegateArray.count > 0) {
        NSString *delegateCode = @"";
        for (ZZProtocol *protocol in delegateArray) {
            NSString *code = protocol.protocolCode;
            if (code.length > 0) {
                delegateCode = [delegateCode stringByAppendingFormat:@"%@ %@\n%@", PMARK, protocol.protocolName, code];
            }
        }
        if (delegateCode.length > 0) {
            delegateCode = [[NSString stringWithFormat:@"%@ Delegate\n", PMARK_] stringByAppendingString:delegateCode];
        }
        return delegateCode;
    }
    return nil;
}

- (NSString *)implementationEventCode
{
    NSArray *controlsArray = self.childControlsArray;
    if (controlsArray.count > 0) {
        NSString *eventCode = @"";
        for (ZZUIControl *control in controlsArray) {
            if (control.actionMethodsCode.length > 0) {
                eventCode = [eventCode stringByAppendingString:control.actionMethodsCode];
            }
        }
        if (eventCode.length > 0) {
            eventCode = [NSString stringWithFormat:@"%@ Event Response\n%@", PMARK_, eventCode];
        }
        return eventCode;
    }
    return nil;
}

- (NSString *)implementationPrivateCode
{
    NSArray *childViews = self.childViewsArray;
    if (childViews.count > 0 && [ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
        NSString *privateCode = [NSString stringWithFormat:@"%@ Private Methods\n", PMARK_];
        
        ZZMethod *method = [[ZZMethod alloc] initWithMethodName:@"- (void)p_addMasonry"];
        NSMutableString *code = [[NSMutableString alloc] init];
        for (ZZUIResponder *view in childViews) {
            [code appendString:view.masonryCode];
        }
        [method addMethodContentCode:code];
        
        privateCode = [privateCode stringByAppendingFormat:@"%@\n", method.methodCode];
        return privateCode;
    }
    return nil;
}

- (NSString *)implementationGetterCode
{
    if (self.interfaceProperties.count + self.extensionProperties.count > 0) {
        NSString *getterCode = [NSString stringWithFormat:@"%@ Getter\n", PMARK_];
        for (ZZNSObject *resp in self.interfaceProperties) {
            if (resp.getterCode.length > 0) {
                getterCode = [getterCode stringByAppendingString:resp.getterCode];
            }
        }
        for (ZZNSObject *resp in self.extensionProperties) {
            if (resp.getterCode.length > 0) {
                getterCode = [getterCode stringByAppendingString:resp.getterCode];
            }
        }
        return getterCode;
    }
    return nil;
}

/// 添加私有属性
- (void)addPrivateProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:@"data"]) {
        ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
        [self addPrivateProperty:data withName:@"data" andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
    }
    NSMutableArray *array = self.extensionProperties ? self.extensionProperties.mutableCopy : @[].mutableCopy;
    [array addObject:property];
    _extensionProperties = array;
}

- (BOOL)removePrivateProperty:(ZZNSObject *)property
{
    if ([self.extensionProperties containsObject:property]) {
        NSMutableArray *array = self.extensionProperties.mutableCopy;
        [array removeObject:property];
        _extensionProperties = array;
        return YES;
    }
    return NO;
}

- (BOOL)removePrivatePropertyAtIndex:(NSInteger)index
{
    if (index < self.extensionProperties.count) {
        NSMutableArray *array = self.extensionProperties.mutableCopy;
        [array removeObjectAtIndex:index];
        _extensionProperties = array;
        return YES;
    }
    return NO;
}

- (BOOL)movePrivatePropertyAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex
{
    if (index >= self.extensionProperties.count || toIndex > self.extensionProperties.count) {
        return NO;
    }
    NSMutableArray *array = self.extensionProperties.mutableCopy;
    id data = array[index];
    if (index > toIndex) {
        [array removeObjectAtIndex:index];
        [array insertObject:data atIndex:toIndex];
    }
    else if (index < toIndex) {
        [array insertObject:data atIndex:toIndex];
        [array removeObjectAtIndex:index];
    }
    _extensionProperties = array;
 
    return YES;
}

#pragma mark - # Getter
- (NSString *)masonryCode
{
    NSMutableString *masonryCode = [[NSMutableString alloc] init];;
    if (self.remarks.length > 0) {
        [masonryCode appendFormat:@"// %@\n", self.remarks];
    }
    [masonryCode appendFormat:@"[self.%@ mas_makeConstraints:^(MASConstraintMaker *make) {\n\n}];\n", self.propertyName];
    return masonryCode;
}

- (NSArray *)childViewsArray
{
    NSMutableArray *childViewsArray = [[NSMutableArray alloc] init];
    for (ZZNSObject *object in self.interfaceProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIResponder class]]) {
            [childViewsArray addObject:object];
        }
    }
    for (ZZNSObject *object in self.extensionProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIResponder class]]) {
            [childViewsArray addObject:object];
        }
    }
    return childViewsArray;
}

- (NSArray *)childControlsArray
{
    NSMutableArray *childControlsArray = [[NSMutableArray alloc] init];
    for (ZZNSObject *object in self.interfaceProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIControl class]]) {
            [childControlsArray addObject:object];
        }
    }
    for (ZZNSObject *object in self.extensionProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIControl class]]) {
            [childControlsArray addObject:object];
        }
    }
    return childControlsArray;
}

- (NSArray *)childDelegateViewsArray
{
    NSMutableArray *delegateArray = [[NSMutableArray alloc] init];
    
    BOOL (^containDelegate)(NSArray *array, NSString *delegateName) = ^BOOL (NSArray *array, NSString *delegateName) {
        for (ZZProtocol *protocol in array) {
            if ([protocol.protocolName isEqualToString:delegateName]) {
                return YES;
            }
        }
        return NO;
    };
    for (ZZUIScrollView *object in self.interfaceProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIScrollView class]] && object.delegates.count > 0) {
            for (ZZProtocol *protocol in object.delegates) {
                if (!containDelegate(delegateArray, protocol.protocolName)) {
                    [delegateArray addObject:protocol];
                }
            }
        }
    }
    for (ZZUIScrollView *object in self.extensionProperties) {
        if ([[object class] isSubclassOfClass:[ZZUIScrollView class]] && object.delegates.count > 0) {
            for (ZZProtocol *protocol in object.delegates) {
                if (!containDelegate(delegateArray, protocol.protocolName)) {
                    [delegateArray addObject:protocol];
                }
            }
        }
    }
    return delegateArray;
}

- (NSString *)curView
{
    return @"self";
}

@end
