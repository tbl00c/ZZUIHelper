//
//  ZZPropertyEditViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZUIScrollView.h"

@interface ZZPropertyEditViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation ZZPropertyEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_EDIT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)editProperty:(NSNotification *)notification
{
    ZZNSObject *object = notification.object;
    NSString *code = @"";
    if (object) {
        code = [code stringByAppendingFormat:@"%@\n", object.propertyName];
        code = [code stringByAppendingFormat:@"ClassName: %@\n", object.className];
        code = [code stringByAppendingFormat:@"Remark: %@\n\n", object.remarks.length > 0 ? object.remarks : @"无备注"];
        
        if ([[object class] isSubclassOfClass:[ZZUIScrollView class]]) {
            for (ZZProtocol *protocol in [(ZZUIScrollView *)object delegates]) {
                code = [code stringByAppendingString:@"-------------------------------------------------\n"];
                code = [code stringByAppendingFormat:@"%@\n", protocol.protocolName];
                for (NSString *methods in protocol.protocolMethods) {
                    code = [code stringByAppendingFormat:@"%@\n", methods];
                }
                code = [code stringByAppendingString:@"\n"];
            }
        }
    }
    self.textView.string = code;
}

@end
