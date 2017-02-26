//
//  ZZPropertyEditViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZPropertyClassViewController.h"
#import "ZZPropertyEventsViewController.h"
#import "ZZPropertyProtocolsViewController.h"
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

    // Class
    NSTabViewItem *classViewItem = [[NSTabViewItem alloc] init];
    [classViewItem setLabel:@"Class"];
    ZZPropertyClassViewController *classVC = [[ZZPropertyClassViewController alloc] initWithNibName:@"ZZPropertyClassViewController" bundle:nil];
    [classViewItem.view addSubview:classVC.view];
    [classViewItem setViewController:classVC];
    [items addObject:classViewItem];
    
    // Events
    if ([[object class] isSubclassOfClass:[ZZUIControl class]] && [(ZZUIControl *)object actionMethods].count > 0) {
        NSTabViewItem *eventsViewItem = [[NSTabViewItem alloc] init];
        [eventsViewItem setLabel:@"Events"];
        ZZPropertyEventsViewController *eventsVC = [[ZZPropertyEventsViewController alloc] initWithNibName:@"ZZPropertyEventsViewController" bundle:nil];
        [eventsVC setObject:object];
        [eventsVC setEvents:[(ZZUIControl *)object actionMethods]];
        [eventsViewItem.view addSubview:eventsVC.view];
        [eventsViewItem setViewController:eventsVC];
        [items addObject:eventsViewItem];
    }
    
    // Delegates
    if ([[object class] isSubclassOfClass:[ZZUIScrollView class]] && [(ZZUIScrollView *)object delegates].count > 0) {
        for (ZZProtocol *protocol in [(ZZUIScrollView *)object delegates]) {
            NSTabViewItem *protocolViewItem = [[NSTabViewItem alloc] init];
            [protocolViewItem setLabel:protocol.protocolKey];
            ZZPropertyProtocolsViewController *protocolVC = [[ZZPropertyProtocolsViewController alloc] initWithNibName:@"ZZPropertyProtocolsViewController" bundle:nil];
            [protocolVC setObject:object];
            [protocolVC setProtocol:protocol];
            [protocolViewItem.view addSubview:protocolVC.view];
            [protocolViewItem setViewController:protocolVC];
            [items addObject:protocolViewItem];
        }
    }
    
    [self setTabViewItems:items];
    [self setSelectedTabViewItemIndex:0];
}

@end
