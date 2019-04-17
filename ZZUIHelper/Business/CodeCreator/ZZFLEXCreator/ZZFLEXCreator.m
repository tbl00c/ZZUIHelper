//
//  ZZFLEXCreator.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2019/4/16.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFLEXCreator.h"
#import "ZZUIResponder+CodeCreator.h"
#import "ZZUIView+Masonry.h"
#import "ZZUIControl.h"
#import "ZZUIView.h"
#import "ZZUIViewController.h"

@interface ZZFLEXCreator ()

@property (nonatomic, strong) NSArray *codeBlocks;

@property (nonatomic, strong) NSString *(^zzflexCodeForViewClass)(ZZUIResponder *viewClass, ZZUIView *object, NSInteger index);

@end

@implementation ZZFLEXCreator

- (id)init
{
    if (self = [super init]) {
        [self setZzflexCodeForViewClass:^NSString *(ZZUIResponder *viewClass, ZZUIView *object, NSInteger index) {
            NSString *tag = @(index).stringValue;
            NSArray *properties = object.properties;
            for (ZZPropertyGroup *group in properties) {
                for (ZZProperty *item in group.properties) {
                    if (item.selected && [item.propertyName isEqualToString:@"tag"]) {
                        tag = item.propertyValue;
                        break;
                    }
                }
            }
            NSMutableString *code = [[NSMutableString alloc] init];
            if (object.remarks.length > 0) {
                [code appendFormat:@"// %@\n", object.remarks];
            }
            
            [code appendFormat:@"self.%@ = %@.add%@(%@)\n", object.propertyName, viewClass.curView, [object.className substringFromIndex:2], tag];
            
            BOOL isListView = ([[object class] isSubclassOfClass:NSClassFromString(@"ZZUITableView")] || [[object class] isSubclassOfClass:NSClassFromString(@"ZZUICollectionView")]);
            NSString *(^createPropertyCode)(ZZProperty *property) = ^NSString *(ZZProperty *property) {
                NSString *code;
                if (property.type == ZZPropertyTypeEvent) {
                    code = [NSString stringWithFormat:@".eventBlock(%@, ^(%@ *sender){\n// event\n})\n", property.propertyName, object.className];
                }
                else if ([property.propertyName containsString:@"tag"]) {
                    return @"";
                }
                else if (isListView && ([property.propertyName isEqualToString:@"delegate"] || [property.propertyName isEqualToString:@"dataSource"])) {
                    return @"";
                }
                else {
                    code = [NSString stringWithFormat:@".%@(%@)\n", property.propertyName, property.propertyValue];
                }
                return code;
            };
            
            for (ZZPropertyGroup *group in properties) {
                for (ZZProperty *item in group.properties) {
                    if (item.selected) {
                        [code appendString:createPropertyCode(item)];
                    }
                }
                for (ZZProperty *item in group.privateProperties) {
                    if (item.selected) {
                        [code appendString:createPropertyCode(item)];
                    }
                }
            }
            
            if (object.masonryContentCode.length > 0) {
                [code appendFormat:@".masonry(^(MASConstraintMaker *make) {\n%@})\n", object.masonryContentCode];
            }
            
            [code appendFormat:@".view;\n"];
            if (isListView) {
                [code appendFormat:@"self.%@Angel = [[ZZFLEXAngel alloc] initWithHostView:self.%@];\n\n", object.propertyName, object.propertyName];
            }
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
        for (ZZCreatorCodeBlock *block in self.codeBlocks) {
            if (![modules containsObject:block]) {
                [modules addObject:block];
            }
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
    BOOL isCell = [viewClass.superClassName isEqualToString:@"UICollectionViewCell"] || [viewClass.superClassName isEqualToString:@"UITableViewCell"];
    NSString *interfaceCode = [NSString stringWithFormat:@"@interface %@ : %@%@\n\n", viewClass.className, viewClass.superClassName, isCell ? @" <ZZFlexibleLayoutViewProtocol>" : @""];
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
        _codeBlocks = @[self.protocolCodeBlock,
                        self.lifeCycleCodeBlock,
                        self.delegateCodeBlock,
                        self.uiCodeBlock,];
    }
    return _codeBlocks;
}

- (ZZCreatorCodeBlock *)protocolCodeBlock
{
    if (!_protocolCodeBlock) {
        _protocolCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"View Protocol" action:^NSString *(ZZUIResponder *viewClass) {
            NSMutableString *initCode = [NSMutableString stringWithFormat:@"%@ ZZFlexibleLayoutViewProtocol\n", PMARK_];
            if ([viewClass.superClassName isEqualToString:@"UICollectionViewCell"]) {
                ZZMethod *method = [[ZZMethod alloc] initWithMethodName:@"+ (CGSize)viewSizeByDataModel:(id)dataModel"];
                [method addMethodContentCode:@"return CGSizeMake(-1, 100)"];
                [initCode appendFormat:@"%@\n", method.methodCode];
            }
            else if([viewClass.superClassName isEqualToString:@"UITableViewCell"]) {
                ZZMethod *method = [[ZZMethod alloc] initWithMethodName:@"+ (CGFloat)viewHeightByDataModel:(id)dataModel"];
                [method addMethodContentCode:@"return 100"];
                [initCode appendFormat:@"%@\n", method.methodCode];
            }
            else {
                return nil;
            }
            {
                ZZMethod *method = [[ZZMethod alloc] initWithMethodName:@"- (void)setViewDataModel:(id)dataModel"];
                [initCode appendFormat:@"%@\n", method.methodCode];
            }
            
            return initCode;
        }];
        [_protocolCodeBlock setRemarks:@"Cell ZZFlex协议"];
    }
    return _protocolCodeBlock;
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
                    if (childViewArray.count > 0) {
                        [initCode appendFormat:@"\n// 处理子视图\n"];
                        [initCode appendFormat:@"[self initSubviews];\n"];
                    }
                    
                    if ([[viewClass class] isSubclassOfClass:[ZZUIView class]]) {
                        [initCode appendString:@"}\nreturn self;\n"];
                    }
                    
                    [initMethod addMethodContentCode:initCode];
                    code = [initMethod methodCode];
                    
                    NSMutableString *result = [NSMutableString stringWithFormat:@"%@ Life Cycle\n%@\n", PMARK_, code];
                    return result;
                }
                return nil;
            }
            else {
                ZZUIViewController *vc = (ZZUIViewController *)viewClass;
                NSArray *childViewArray = viewClass.childViewsArray;
                if (childViewArray.count > 0) {
                    [vc.loadView setSelected:YES];
                    NSMutableString *code = [[NSMutableString alloc] initWithString:@"[super loadView];\n"];
                    if (childViewArray.count > 0) {
                        [code appendFormat:@"\n// 处理子视图\n"];
                        [code appendFormat:@"[self loadSubviews];\n"];
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
            }
        
            return nil;
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
                    if ([protocol.protocolName containsString:@"TableView"] || [protocol.protocolName containsString:@"collectionView"]) {
                        break;
                    }
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

- (ZZCreatorCodeBlock *)uiCodeBlock
{
    if (!_uiCodeBlock) {
        __weak typeof(self) weakSelf = self;
        _uiCodeBlock = [[ZZCreatorCodeBlock alloc] initWithBlockName:@"UICode" action:^NSString *(ZZUIResponder *viewClass) {
            if (viewClass.interfaceProperties.count + viewClass.extensionProperties.count > 0) {
                NSString *methodName = [[viewClass class] isSubclassOfClass:[ZZUIView class] ]? @"- (void)initSubviews\n" : @"- (void)loadSubviews\n";
                ZZMethod *uiMethod = [[ZZMethod alloc] initWithMethodName:methodName];
                NSInteger index = 0;
                for (ZZUIView *resp in viewClass.interfaceProperties) {
                    if ([[resp class] isSubclassOfClass:[ZZUIView class]]) {
                        NSString *code = weakSelf.zzflexCodeForViewClass(viewClass, resp, ++index);
                        if (code.length > 0) {
                            [uiMethod addMethodContentCode:code];
                        }
                    }
                }
                for (ZZUIView *resp in viewClass.extensionProperties) {
                    if ([[resp class] isSubclassOfClass:[ZZUIView class]]) {
                        NSString *code = weakSelf.zzflexCodeForViewClass(viewClass, resp, ++index);
                        if (code.length > 0) {
                            [uiMethod addMethodContentCode:code];
                        }
                    }
                }
                NSString *uiCode = [NSString stringWithFormat:@"%@ UI\n%@\n", PMARK_, uiMethod.methodCode];
                return uiCode;
            }
            return nil;
        }];
        [_uiCodeBlock setRemarks:@"Getter方法，通过惰性初始化的方式创建subViews"];
    }
    return _uiCodeBlock;
}

@end
