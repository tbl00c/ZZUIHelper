//
//  ZZLazyLoadCreator.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZLazyLoadCreator.h"
#import "ZZUIResponder+CodeCreator.h"
#import "ZZUIView+Masonry.h"
#import "ZZUIControl.h"
#import "ZZUIView.h"
#import "ZZUIViewController.h"

@interface ZZLazyLoadCreator ()

@property (nonatomic, strong) NSArray *codeBlocks;

@property (nonatomic, strong) NSString *(^getterMethodForViewClass)(ZZNSObject *object);

@end

@implementation ZZLazyLoadCreator

- (id)init
{
    if (self = [super init]) {
        [self setGetterMethodForViewClass:^NSString *(ZZNSObject *object) {
            ZZMethod *getterMethod = [[ZZMethod alloc] initWithMethodName:[NSString stringWithFormat:@"- (%@ *)%@", object.className, object.propertyName]];
            NSMutableString *getterCode = [NSMutableString stringWithFormat:@"if (!_%@) {\n", object.propertyName];
            [getterCode appendFormat:@"_%@ = %@;\n", object.propertyName, object.allocInitMethodName];
            
            NSArray *properties = object.properties;
            for (ZZPropertyGroup *group in properties) {
                for (ZZProperty *item in group.properties) {
                    if (item.selected) {
                        if ([group.groupName isEqualToString:@"CALayer"]) {
                            [getterCode appendFormat:@"[_%@.layer %@];\n", object.propertyName, item.propertyCode];
                        }
                        else {
                            [getterCode appendFormat:@"[_%@ %@];\n", object.propertyName, item.propertyCode];
                        }
                    }
                }
                for (ZZProperty *item in group.privateProperties) {
                    if (item.selected) {
                        [getterCode appendFormat:@"[_%@ %@];\n", object.propertyName, item.propertyCode];
                    }
                }
            }
            
            [getterCode appendFormat:@"}\nreturn _%@;\n", object.propertyName];
            [getterMethod addMethodContentCode:getterCode];
            NSString *code = [[getterMethod methodCode] stringByAppendingString:@"\n"];
            return code;
        }];
    }
    return self;
}

- (NSMutableArray *)modules
{
    NSArray *moduleTitles = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    NSMutableArray *modules = [[NSMutableArray alloc] init];
    if (!moduleTitles) {
        modules = self.codeBlocks.mutableCopy;
    }
    else {
        NSMutableDictionary *codeBlockDic = [[NSMutableDictionary alloc] init];
        for (ZZCreatorCodeBlock *block in self.codeBlocks) {
            [codeBlockDic setObject:block forKey:block.blockName];
        }
        for (NSString *title in moduleTitles) {
            [modules addObject:codeBlockDic[title]];
        }
    }
    return modules;
}
- (void)setModules:(NSMutableArray *)modules
{
    NSMutableArray *m = [[NSMutableArray alloc] init];
    for (ZZCreatorCodeBlock *block in modules) {
        [m addObject:block.blockName];
    }
    [[NSUserDefaults standardUserDefaults] setObject:m forKey:NSStringFromClass([self class])];
}

#pragma mark - # m
/// .m文件代码
- (NSString *)mFileForViewClass:(ZZUIResponder *)viewClass
{
    NSString *fileName = [viewClass.className stringByAppendingString:@".m"];
    NSString *copyrightCode = [[ZZUIHelperConfig sharedInstance] copyrightCodeByFileName:fileName];
    NSString *code = [copyrightCode stringByAppendingFormat:@"#import \"%@.h\"\n\n", viewClass.className];
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
        NSString *extensionCode = [NSString stringWithFormat:@"@interface %@ ()", viewClass.className];
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
    NSMutableString *implementationCode = [NSMutableString stringWithFormat:@"@implementation %@\n\n", viewClass.className];
    
    for (ZZCreatorCodeBlock *block in self.modules) {
        NSString *code = block.action(viewClass);
        if (code.length > 0) {
            [implementationCode appendString:block.action(viewClass)];
        }
    }
    
    [implementationCode appendString:@"@end\n"];
    return implementationCode;
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

#pragma mark - # Getter
- (NSArray *)codeBlocks
{
    if (!_codeBlocks) {
        _codeBlocks = @[self.lifeCycleCodeBlock,
                        self.delegateCodeBlock,
                        self.eventCodeBlock,
                        self.privateCodeBlock,
                        self.getterCodeBlock];
    }
    return _codeBlocks;
}

- (ZZCreatorCodeBlock *)lifeCycleCodeBlock
{
    if (!_lifeCycleCodeBlock) {
        _lifeCycleCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"Life Cycle" action:^NSString *(ZZUIResponder *viewClass) {
            if ([[viewClass class] isSubclassOfClass:[ZZUIView class]]) {
                NSString *code = @"";
                NSArray *childViewArray = viewClass.childViewsArray;
                if (childViewArray.count > 0) {
                    ZZMethod *initMethod = [[ZZMethod alloc] initWithMethodName:[(ZZUIView *)viewClass m_initMethodName]];
                    
                    NSMutableString *initCode = [NSMutableString stringWithFormat:@"if (self = [super %@]) {", initMethod.superMethodName];
                    for (ZZUIView *view in childViewArray) {
                        [initCode appendFormat:@"[%@ addSubview:self.%@];\n", view.superViewName, view.propertyName];
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
            ZZUIViewController *vc = (ZZUIViewController *)viewClass;
            NSArray *childViewArray = viewClass.childViewsArray;
            if (childViewArray.count > 0) {
                [vc.loadView setSelected:YES];
                NSMutableString *code = [[NSMutableString alloc] initWithString:@"[super loadView];\n"];
                for (ZZUIView *view in childViewArray) {
                    [code appendFormat:@"[%@ addSubview:self.%@];\n", view.superViewName, view.propertyName];
                }
                if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
                    [code appendString:@"[self p_addMasonry];\n"];
                }
                [vc.loadView clearMethodContent];
                [vc.loadView addMethodContentCode:code];
            }
            else {
                [vc.loadView setSelected:NO];
            }
            
            NSMutableString *initCode = [NSMutableString stringWithFormat:@"%@ Life Cycle\n", PMARK_];
            for (ZZMethod *method in vc.methodArray) {
                if (method.selected) {
                    [initCode appendFormat:@"%@\n", method.methodCode];
                }
            }
            return initCode;
        }];
        [_lifeCycleCodeBlock setRemarks:@"初始化函数，声明周期函数"];
    }
    return _lifeCycleCodeBlock;
}

- (ZZCreatorCodeBlock *)delegateCodeBlock
{
    if (!_delegateCodeBlock) {
        _delegateCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"Delegate" action:^NSString *(ZZUIResponder *viewClass) {
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
        }];
        [_delegateCodeBlock setRemarks:@"SubView的代理方法"];
    }
    return _delegateCodeBlock;
}

- (ZZCreatorCodeBlock *)eventCodeBlock
{
    if (!_eventCodeBlock) {
        _eventCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"Event Response" action:^NSString *(ZZUIResponder *viewClass) {
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
        }];
        [_eventCodeBlock setRemarks:@"SubView的事件响应函数"];
    }
    return _eventCodeBlock;
}

- (ZZCreatorCodeBlock *)privateCodeBlock
{
    if (!_privateCodeBlock) {
        _privateCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"Private Methods" action:^NSString *(ZZUIResponder *viewClass) {
            NSArray *childViews = viewClass.childViewsArray;
            if (childViews.count > 0 && [ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
                NSString *privateCode = [NSString stringWithFormat:@"%@ Private Methods\n", PMARK_];
                
                ZZMethod *method = [[ZZMethod alloc] initWithMethodName:@"- (void)p_addMasonry"];
                NSMutableString *code = [[NSMutableString alloc] init];
                for (ZZUIView *view in childViews) {
                    [code appendString:view.masonryCode];
                }
                [method addMethodContentCode:code];
                
                privateCode = [privateCode stringByAppendingFormat:@"%@\n", method.methodCode];
                return privateCode;
            }
            return nil;
        }];
        [_privateCodeBlock setRemarks:@"类的私有方法，如Masonry的布局函数"];
    }
    return _privateCodeBlock;
}

- (ZZCreatorCodeBlock *)getterCodeBlock
{
    if (!_getterCodeBlock) {
        __weak typeof(self) weakSelf = self;
        _getterCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"Getters" action:^NSString *(ZZUIResponder *viewClass) {
            if (viewClass.interfaceProperties.count + viewClass.extensionProperties.count > 0) {
                NSString *getterCode = [NSString stringWithFormat:@"%@ Getter\n", PMARK_];
                for (ZZNSObject *resp in viewClass.interfaceProperties) {
                    NSString *code = weakSelf.getterMethodForViewClass(resp);
                    if (code.length > 0) {
                        getterCode = [getterCode stringByAppendingString:code];
                    }
                }
                for (ZZNSObject *resp in viewClass.extensionProperties) {
                    NSString *code = weakSelf.getterMethodForViewClass(resp);
                    if (code.length > 0) {
                        getterCode = [getterCode stringByAppendingString:code];
                    }
                }
                return getterCode;
            }
            return nil;
        }];
        [_getterCodeBlock setRemarks:@"Getter方法，通过惰性初始化的方式创建subViews"];
    }
    return _getterCodeBlock;
}

@end
