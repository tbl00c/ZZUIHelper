//
//  ZZPropertyEditViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZPropertyPViewController.h"
#import "ZZPropertyMViewController.h"
#import "ZZUIScrollView.h"
#import "ZZUIControl.h"

@implementation ZZPropertyEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editProperty:) name:NOTI_CLASS_PROPERTY_SELECTED object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)editProperty:(NSNotification *)notification
{
    ZZNSObject *object = notification.object;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];

    // P
    NSTabViewItem *classViewItem = [[NSTabViewItem alloc] init];
    [classViewItem setLabel:@"  P  "];
    ZZPropertyPViewController *classVC = [[ZZPropertyPViewController alloc] initWithNibName:@"ZZPropertyPViewController" bundle:nil];
    [classViewItem.view addSubview:classVC.view];
    [classViewItem setViewController:classVC];
    [items addObject:classViewItem];
    
    /// M
    // Events
    NSMutableArray *mData = [[NSMutableArray alloc] init];
    if ([[object class] isSubclassOfClass:[ZZUIControl class]] && [(ZZUIControl *)object actionMethods].count > 0) {
        ZZPropertySectionModel *eventsMethods = [[ZZPropertySectionModel alloc] initWithSectionTitle:@"Events" andData:[(ZZUIControl *)object actionMethods]];
        [mData addObject:eventsMethods];
    }
    
    // Delegates
    if ([[object class] isSubclassOfClass:[ZZUIScrollView class]] && [(ZZUIScrollView *)object delegates].count > 0) {
        for (ZZProtocol *protocol in [(ZZUIScrollView *)object delegates]) {
            ZZPropertySectionModel *protocolMethods = [[ZZPropertySectionModel alloc] initWithSectionTitle:protocol.protocolName andData:protocol.protocolMethods];
            [mData addObject:protocolMethods];
        }
    }
    
    if (mData.count > 0) {
        NSTabViewItem *eventsViewItem = [[NSTabViewItem alloc] init];
        [eventsViewItem setLabel:@"  M  "];
        ZZPropertyMViewController *mVC = [[ZZPropertyMViewController alloc] initWithNibName:@"ZZPropertyMViewController" bundle:nil];
        [mVC setObject:object];
        [mVC setData:mData];
        [eventsViewItem.view addSubview:mVC.view];
        [eventsViewItem setViewController:mVC];
        [items addObject:eventsViewItem];
    }
    
    [self setTabViewItems:items];
    if (items.count > 0) {
        [self setSelectedTabViewItemIndex:0];
    }
}

@end
