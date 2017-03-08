//
//  ZZClassHelper.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZClassHelper.h"
#import "ZZUIViewController.h"
#import "ZZUITableView.h"
#import "ZZUIImageView.h"
#import "ZZUIButton.h"
#import "ZZUILabel.h"
#import "ZZUITextView.h"
#import "ZZUITextField.h"

@implementation ZZClassHelper

+ (ZZClassHelper *)sharedInstance
{
    static ZZClassHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ZZClassHelper alloc] init];
    });
    return helper;
}

- (BOOL)canNamed:(NSString *)name
{
    NSArray *properties = self.properties;
    for (ZZNSObject *object in properties) {
        if ([object.propertyName isEqualToString:name]) {
            return NO;
        }
    }
    return YES;
}

- (NSArray *)properties
{
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    [properties addObjectsFromArray:self.curClass.interfaceProperties];
    [properties addObjectsFromArray:self.curClass.extensionProperties];
    return properties;
}

- (NSArray *)superClassArray
{
    return @[@"UIViewController",
             @"UIView",
             @"UITableViewCell",
             @"UICollectionViewCell",
             @"UIImageView",
             @"UIScrollView"];
}

@end
