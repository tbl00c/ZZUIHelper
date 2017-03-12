//
//  ZZPropertyAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyAreaViewController.h"
#import "ZZPropertyEditViewController.h"
#import "ZZPropertyLayoutViewController.h"

@interface ZZPropertyAreaViewController ()

@property (nonatomic, strong) NSTabViewItem *editVCItem;
@property (nonatomic, strong) ZZPropertyEditViewController *editVC;
@property (nonatomic, strong) NSTabViewItem *layoutVCItem;
@property (nonatomic, strong) ZZPropertyLayoutViewController *layoutVC;

@end

@implementation ZZPropertyAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.tabViewItems.count == 2) {
        self.editVCItem = self.tabViewItems[0];
        self.editVC = (ZZPropertyEditViewController *)self.editVCItem.viewController;
        self.layoutVCItem = self.tabViewItems[1];
        self.layoutVC = (ZZPropertyLayoutViewController *)self.layoutVCItem.viewController;
        [self removeTabViewItem:self.layoutVCItem];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_NEW_PROJECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_SELECTED object:nil];
}

- (void)editProperty:(NSNotification *)notification
{
    ZZNSObject *object = notification.object;

    [self.editVC setObject:object];
    
    if ([ZZUIHelperConfig sharedInstance].layoutLibrary == ZZUIHelperLayoutLibraryMasonry && object && [[object class] isSubclassOfClass:[ZZUIResponder class]]) {
        [self.layoutVC setObject:(ZZUIView *)object];
        if (![self.tabViewItems containsObject:self.layoutVCItem]) {
            [self addTabViewItem:self.layoutVCItem];
        }
        return;
    }
    
    if ([self.tabViewItems containsObject:self.layoutVCItem]) {
        [self removeTabViewItem:self.layoutVCItem];
    }
}


@end
