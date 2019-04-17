//
//  ZZUIResponder+ClassHelper.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder+ClassHelper.h"
#import "ZZUITableView.h"
#import "ZZUICollectionView.h"
#import "ZZNSMutableArray.h"
#import "ZZUICollectionViewFlowLayout.h"
#import "ZZUIResponder+CodeCreator.h"
#import "ZZZZFLEXAngel.h"

@implementation ZZUIResponder (ClassHelper)

- (void)addPublicProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if ([[property class] isSubclassOfClass:[ZZUIView class]]) {
        [(ZZUIView *)property setSuperViewName:[(ZZUIView *)self curView]];
    }
    if ([NSStringFromClass([[ZZCreatorManager sharedInstance].curCreator class]) containsString:@"ZZFLEX"]) {
        if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:[NSString stringWithFormat:@"%@Data", property.propertyName]]) {
            ZZZZFLEXAngel *data = [[ZZZZFLEXAngel alloc] init];
            NSString *dataName = [NSString stringWithFormat:@"%@Angel", property.propertyName];
            [self addPublicProperty:data withName:dataName andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
        }
    }
    else {
        if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:[NSString stringWithFormat:@"%@Data", property.propertyName]]) {
            ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
            NSString *dataName = [NSString stringWithFormat:@"%@Data", property.propertyName];
            [self addPublicProperty:data withName:dataName andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
        }
        if ([[property class] isSubclassOfClass:[ZZUICollectionView class]] && [[ZZClassHelper sharedInstance] canNamed:@"collectionViewFlowLayout"]) {
            ZZUICollectionViewFlowLayout *layout = [[ZZUICollectionViewFlowLayout alloc] init];
            [self addPrivateProperty:layout withName:@"collectionViewFlowLayout" andRemarks:@"collectionViewFlowLayout"];
        }
    }
    [self.interfaceProperties addObject:property];
}

- (BOOL)removePublicProperty:(ZZNSObject *)property
{
    if ([self.interfaceProperties containsObject:property]) {
        [self.interfaceProperties removeObject:property];
        // 级联删除
        NSArray *data = self.interfaceProperties.copy;
        for (ZZUIView *view in data) {
            if ([[view class] isSubclassOfClass:[ZZUIView class]] && [view.superViewName hasSuffix:[@"." stringByAppendingString:property.propertyName]]) {
                [self removePublicProperty:view];
            }
        }
        return YES;
    }
    return NO;
}

/// 添加私有属性
- (void)addPrivateProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if ([[property class] isSubclassOfClass:[ZZUIView class]]) {
        [(ZZUIView *)property setSuperViewName:[(ZZUIView *)self curView]];
    }
    if ([NSStringFromClass([[ZZCreatorManager sharedInstance].curCreator class]) containsString:@"ZZFLEX"]) {
        if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:[NSString stringWithFormat:@"%@Data", property.propertyName]]) {
            ZZZZFLEXAngel *data = [[ZZZZFLEXAngel alloc] init];
            NSString *dataName = [NSString stringWithFormat:@"%@Angel", property.propertyName];
            [self addPrivateProperty:data withName:dataName andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
        }
    }
    else {
        if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:[NSString stringWithFormat:@"%@Data", property.propertyName]]) {
            ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
            NSString *dataName = [NSString stringWithFormat:@"%@Data", property.propertyName];
            [self addPrivateProperty:data withName:dataName andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
        }
        if ([[property class] isSubclassOfClass:[ZZUICollectionView class]] && [[ZZClassHelper sharedInstance] canNamed:@"collectionViewFlowLayout"]) {
            ZZUICollectionViewFlowLayout *layout = [[ZZUICollectionViewFlowLayout alloc] init];
            [self addPrivateProperty:layout withName:@"collectionViewFlowLayout" andRemarks:[property.propertyName stringByAppendingString:@"CollectionViewLayout"]];
        }
    }
    [self.extensionProperties addObject:property];
}

- (BOOL)removePrivateProperty:(ZZNSObject *)property
{
    if ([self.extensionProperties containsObject:property]) {
        [self.extensionProperties removeObject:property];
        // 级联删除
        NSArray *data = self.extensionProperties.copy;
        for (ZZUIView *view in data) {
            if ([[view class] isSubclassOfClass:[ZZUIView class]] && [view.superViewName hasSuffix:[@"." stringByAppendingString:property.propertyName]]) {
                [self removePrivateProperty:view];
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)removePrivatePropertyAtIndex:(NSInteger)index
{
    if (index < self.extensionProperties.count) {
        ZZProperty *property = self.extensionProperties[index];
        [self.extensionProperties removeObjectAtIndex:index];
        // 级联删除
        NSArray *data = self.extensionProperties.copy;
        for (ZZUIView *view in data) {
            if ([[view class] isSubclassOfClass:[ZZUIView class]] && [view.superViewName hasSuffix:[@"." stringByAppendingString:property.propertyName]]) {
                [self removePrivateProperty:view];
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)movePrivatePropertyAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex
{
    if (index >= self.extensionProperties.count || toIndex > self.extensionProperties.count) {
        return NO;
    }
    id data = self.extensionProperties[index];
    if (index > toIndex) {
        [self.extensionProperties removeObjectAtIndex:index];
        [self.extensionProperties insertObject:data atIndex:toIndex];
    }
    else if (index < toIndex) {
        [self.extensionProperties insertObject:data atIndex:toIndex];
        [self.extensionProperties removeObjectAtIndex:index];
    }
    
    return YES;
}

@end
