//
//  ZZUIView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIView.h"

@implementation ZZUIView
@synthesize m_initWithFrame = _m_initWithFrame;

- (NSString *)implementationInitCode
{
    NSArray *childViewArray = self.childViewsArray;
    if (childViewArray.count > 0) {
        NSMutableString *initCode = [NSMutableString stringWithString:@"if (self = [super initWithFrame:frame]) {"];
        for (ZZUIView *view in childViewArray) {
            [initCode appendFormat:@"[%@ addSubview:self.%@];\n", self.curView, view.propertyName];
        }
        
        if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry) {
            [initCode appendString:@"[self p_addMasonry];\n"];
        }
        
        [initCode appendString:@"}\nreturn self;\n"];
        
        [self.m_initWithFrame clearMethodContent];
        [self.m_initWithFrame addMethodContentCode:initCode];
        
        return [self.m_initWithFrame.methodCode stringByAppendingString:@"\n"];
    }
    
    return @"";
}


#pragma mark - # Getter
- (ZZMethod *)m_initWithFrame
{
    if (!_m_initWithFrame) {
        _m_initWithFrame = [[ZZMethod alloc] initWithMethodName:@"- (id)initWithFrame:(CGRect)frame"];
    }
    return _m_initWithFrame;
}

@end
