//
//  ZZUITableViewCell.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITableViewCell.h"

@implementation ZZUITableViewCell
@synthesize m_initWithStyle_reuseIdentifier = _m_initWithStyle_reuseIdentifier;

- (NSString *)implementationInitCode
{
    NSArray *childViewArray = self.childViewsArray;
    if (childViewArray.count > 0) {
        NSMutableString *initCode = @"if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {".mutableCopy;
        for (ZZUIView *view in childViewArray) {
            [initCode appendFormat:@"[%@ addSubview:self.%@];\n", self.curView, view.propertyName];
        }
        [initCode appendString:@"}\nreturn self;"];
        [self.m_initWithStyle_reuseIdentifier addMethodContentCode:initCode];
        return [self.m_initWithStyle_reuseIdentifier.methodCode stringByAppendingString:@"\n"];
    }
    
    return @"";
}

- (NSString *)curView
{
    return @"self.contentView";
}

#pragma mark - # Getter
- (ZZMethod *)m_initWithStyle_reuseIdentifier
{
    if (!_m_initWithStyle_reuseIdentifier) {
        _m_initWithStyle_reuseIdentifier = [[ZZMethod alloc] initWithMethodName:@"- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier"];
    }
    return _m_initWithStyle_reuseIdentifier;
}

@end
