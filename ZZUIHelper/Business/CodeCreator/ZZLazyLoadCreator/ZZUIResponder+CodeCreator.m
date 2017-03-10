//
//  ZZUIResponder+CodeCreator.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder+CodeCreator.h"
#import "ZZUIControl.h"
#import "ZZUITableView.h"

@implementation ZZUIResponder (CodeCreator)

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
        if (object.delegates.count > 0) {
            for (ZZProtocol *protocol in object.delegates) {
                if (!containDelegate(delegateArray, protocol.protocolName)) {
                    [delegateArray addObject:protocol];
                }
            }
        }
    }
    for (ZZUIScrollView *object in self.extensionProperties) {
        if (object.delegates.count > 0) {
            for (ZZProtocol *protocol in object.delegates) {
                if (!containDelegate(delegateArray, protocol.protocolName)) {
                    [delegateArray addObject:protocol];
                }
            }
        }
    }
    return delegateArray;
}

@end
