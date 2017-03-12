//
//  ZZPropertyEditViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZPropertyEditViewController.h"
#import "ZZPropertyEditViewController+Delegate.h"
#import "ZZUIControl.h"

@interface ZZPropertyEditViewController ()

@end

@implementation ZZPropertyEditViewController

- (void)loadView
{
    [super loadView];
    
    [self.collectionView setWantsLayer:YES];
    [self.collectionView.layer setBackgroundColor:[NSColor windowBackgroundColor].CGColor];
    
    [self registerViewsForCollectionView:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_SETTING_EDIT object:nil];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setObject:(ZZNSObject *)object
{
    _object = object;
    if (!object) {
        self.data = nil;
        [self.collectionView reloadData];
        return;
    }
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    // base
    ZZPropertySectionModel *baseSection = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeProperty title:nil andData:@[object.propertyNameProperty, object.remarksProperty]];
    [data addObject:baseSection];
    
    // Properties
    if (object.properties.count > 0) {
        for (ZZPropertyGroup *group in object.properties) {
            if (group.properties.count > 0) {
                ZZPropertySectionModel *classSection = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeProperty title:group.groupName andData:group.properties];
                [data insertObject:classSection atIndex:1];
            }
        }
    }
    
    // Events
    if ([[object class] isSubclassOfClass:[ZZUIControl class]] && [(ZZUIControl *)object events].count > 0) {
        ZZPropertySectionModel *eventsMethods = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeEvent title:@"Events" andData:[(ZZUIControl *)object events]];
        [data addObject:eventsMethods];
    }
    
    // Delegates
    for (ZZProtocol *protocol in [object delegates]) {
        ZZPropertySectionModel *protocolMethods = [[ZZPropertySectionModel alloc] initWithSectionType:ZZPropertySectionTypeDelegate title:protocol.protocolName andData:protocol.protocolMethods];
        [data addObject:protocolMethods];
    }

    self.data = data;
    [self.collectionView reloadData];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}


@end
