//
//  ZZCodeCreator.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeCreator.h"
#import "ZZUIResponder+CodeCreator.h"
#import "ZZUIResponder+Masonry.h"
#import "ZZUIControl.h"
#import "ZZUIView.h"
#import "ZZUIViewController.h"

@implementation ZZCodeCreator

+ (ZZCodeCreator *)sharedInstance
{
    static ZZCodeCreator *creator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        creator = [[ZZCodeCreator alloc] init];
    });
    return creator;
}

#pragma mark - # m
/// .m文件代码
- (NSString *)mFileForViewClass:(ZZUIResponder *)viewClass
{
    NSString *fileName = [viewClass.className stringByAppendingString:@".m"];
    NSString *copyrightCode = [[ZZUIHelperConfig sharedInstance] copyrightCodeByFileName:fileName];
    NSString *code = [copyrightCode stringByAppendingFormat:@"#import \"%@.h\"\n\n", self.className];
    // 类拓展
    NSString *extensionCode = [self m_extensionCodeForViewClass:viewClass];
    if (extensionCode.length > 0) {
        code = [code stringByAppendingString:extensionCode];
    }
    // 类实现
    NSString *implementationCode = [self m_implementationCodeForViewClass:viewClass];
    code = [code stringByAppendingString:implementationCode];
    return code;
}

/// .m中，类拓展代码
- (NSString *)m_extensionCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSArray *delegatesArray = viewClass.childDelegateViewsArray;
    if (viewClass.extensionProperties.count > 0 || delegatesArray.count > 0) {
        NSString *extensionCode = [NSString stringWithFormat:@"@interface %@ ()", self.className];
        if (delegatesArray.count > 0) {    // 协议
            NSString *delegateCode = @"";
            for (ZZProtocol *protocol in delegatesArray) {
                if (delegateCode.length > 0) {
                    delegateCode = [delegateCode stringByAppendingString:@",\n"];
                }
                delegateCode = [delegateCode stringByAppendingString:protocol.protocolName];
            }
            if (delegateCode.length > 0) {
                extensionCode = [extensionCode stringByAppendingFormat:@" <\n%@\n>", delegateCode];
            }
        }
        
        extensionCode = [extensionCode stringByAppendingString:@"\n\n"];
        for (ZZNSObject *object in viewClass.extensionProperties) {
            if (object.propertyCode.length > 0) {
                extensionCode = [extensionCode stringByAppendingFormat:@"%@\n", object.propertyCode];
            }
        }
        extensionCode = [extensionCode stringByAppendingString:@"@end\n\n"];
        return extensionCode;
    }
    return nil;
}

/// .m中，类实现代码
- (NSString *)m_implementationCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSString *implementationCode = [NSString stringWithFormat:@"@implementation %@\n\n", self.className];
    
    // 初始化代码
    NSString *initCode = [self m_initCodeForViewClass:viewClass];
    if (initCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:initCode];
    }
    
    // Delegate代码
    NSString *delegateCode = [self m_delegateCodeForViewClass:viewClass];
    if (delegateCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:delegateCode];
    }
    
    // Event Response代码
    NSString *eventCode = [self m_eventResponseCodeForViewClass:viewClass];
    if (eventCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:eventCode];
    }
    
    // Private Methods代码
    NSString *privateCode = [self m_privateMethodCodeForViewClass:viewClass];
    if (privateCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:privateCode];
    }
    
    // Getter 代码
    NSString *getterCode = [self m_getterCodeForViewClass:viewClass];
    if (getterCode.length > 0) {
        implementationCode = [implementationCode stringByAppendingString:getterCode];
    }
    
    implementationCode = [implementationCode stringByAppendingString:@"@end\n"];
    return implementationCode;
}

- (NSString *)m_initCodeForViewClass:(ZZUIResponder *)viewClass
{
    if ([[viewClass class] isSubclassOfClass:[ZZUIView class]]) {
        return [self m_initViewCodeForViewClass:(ZZUIView *)viewClass];
    }
    return [self m_initViewControllerCodeForViewClass:(ZZUIViewController *)viewClass];
}

- (NSString *)m_initViewCodeForViewClass:(ZZUIView *)viewClass
{
    NSString *code = @"";
    NSArray *childViewArray = viewClass.childViewsArray;
    if (childViewArray.count > 0) {
        ZZMethod *initMethod = [[ZZMethod alloc] initWithMethodName:[(ZZUIView *)viewClass m_initMethodName]];
        
        NSMutableString *initCode = [NSMutableString stringWithFormat:@"if (self = [super %@]) {", initMethod.superMethodName];
        for (ZZUIView *view in childViewArray) {
            [initCode appendFormat:@"[%@ addSubview:self.%@];\n", viewClass.curView, view.propertyName];
        }
        
        if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
            [initCode appendString:@"[self p_addMasonry];\n"];
        }
        
        if ([[viewClass class] isSubclassOfClass:[ZZUIView class]]) {
            [initCode appendString:@"}\nreturn self;\n"];
        }
        
        [initMethod addMethodContentCode:initCode];
        code = [initMethod methodCode];
    }
    
    return [code stringByAppendingString:@"\n"];
}

- (NSString *)m_initViewControllerCodeForViewClass:(ZZUIViewController *)viewClass
{
    NSArray *childViewArray = viewClass.childViewsArray;
    if (childViewArray.count > 0) {
        [viewClass.loadView setSelected:YES];
        NSMutableString *code = [[NSMutableString alloc] initWithString:@"[super loadView];\n"];
        for (ZZUIView *view in childViewArray) {
            [code appendFormat:@"[%@ addSubview:self.%@];\n", viewClass.curView, view.propertyName];
        }
        if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
            [code appendString:@"[self p_addMasonry];\n"];
        }
        [viewClass.loadView clearMethodContent];
        [viewClass.loadView addMethodContentCode:code];
    }
    else {
        [viewClass.loadView setSelected:NO];
    }
    
    NSMutableString *initCode = [NSMutableString stringWithFormat:@"%@ Life Cycle\n", PMARK_];
    for (ZZMethod *method in viewClass.methodArray) {
        if (method.selected) {
            [initCode appendFormat:@"%@\n", method.methodCode];
        }
    }
    return initCode;
}

- (NSString *)m_delegateCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSArray *delegateArray = viewClass.childDelegateViewsArray;
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

- (NSString *)m_eventResponseCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSArray *controlsArray = viewClass.childControlsArray;
    if (controlsArray.count > 0) {
        NSString *eventCode = @"";
        for (ZZUIControl *control in controlsArray) {
            NSString *code = control.eventsCode;
            if (code.length > 0) {
                eventCode = [eventCode stringByAppendingString:code];
            }
        }
        if (eventCode.length > 0) {
            eventCode = [NSString stringWithFormat:@"%@ Event Response\n%@", PMARK_, eventCode];
        }
        return eventCode;
    }
    return nil;
}

- (NSString *)m_privateMethodCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSArray *childViews = viewClass.childViewsArray;
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

- (NSString *)m_getterCodeForViewClass:(ZZUIResponder *)viewClass
{
    if (viewClass.interfaceProperties.count + viewClass.extensionProperties.count > 0) {
        NSString *getterCode = [NSString stringWithFormat:@"%@ Getter\n", PMARK_];
        for (ZZNSObject *resp in viewClass.interfaceProperties) {
            if (resp.getterCode.length > 0) {
                getterCode = [getterCode stringByAppendingString:resp.getterCode];
            }
        }
        for (ZZNSObject *resp in viewClass.extensionProperties) {
            if (resp.getterCode.length > 0) {
                getterCode = [getterCode stringByAppendingString:resp.getterCode];
            }
        }
        return getterCode;
    }
    return nil;
}

#pragma mark - # h
- (NSString *)hFileForViewClass:(ZZUIResponder *)viewClass
{
    NSString *fileName = [viewClass.className stringByAppendingString:@".h"];
    NSString *copyrightCode = [[ZZUIHelperConfig sharedInstance] copyrightCodeByFileName:fileName];
    NSString *code = copyrightCode;
    if ([viewClass.superClassName hasPrefix:@"UI"]) {
        code = [code stringByAppendingString:@"#import <UIKit/UIKit.h>"];
    }
    else {
        code = [code stringByAppendingFormat:@"#import \"%@.h\"", viewClass.superClassName];
    }
    code = [code stringByAppendingFormat:@"\n\n%@", [self h_interfaceCodeForViewClass:viewClass]];
    return code;
}

- (NSString *)h_interfaceCodeForViewClass:(ZZUIResponder *)viewClass
{
    NSString *interfaceCode = [NSString stringWithFormat:@"@interface %@ : %@\n\n", viewClass.className, viewClass.superClassName];
    
    for (ZZNSObject *object in viewClass.interfaceProperties) {
        if (object.propertyCode.length > 0) {
            interfaceCode = [interfaceCode stringByAppendingFormat:@"%@\n", object.propertyCode];
        }
    }
    
    interfaceCode = [interfaceCode stringByAppendingString:@"@end\n"];
    return interfaceCode;
}

@end
