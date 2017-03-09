//
//  ZZSettingViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZSettingViewController.h"
#import <MGSFragaria/MGSFragaria.h>

@interface ZZSettingViewController ()

@end

@implementation ZZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MGSFragariaFontsAndColoursPrefsViewController *fontAndColorsVC = [[MGSFragariaFontsAndColoursPrefsViewController alloc] init];
    NSTabViewItem *fontAndColorTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:@"fontAndColorTabViewItem"];
    [fontAndColorTabViewItem setLabel:@"CodeArea"];
    [fontAndColorTabViewItem setView:fontAndColorsVC.view];
    [fontAndColorTabViewItem setViewController:fontAndColorsVC];
    [self insertTabViewItem:fontAndColorTabViewItem atIndex:1];
    
    MGSFragariaTextEditingPrefsViewController *editingVC = [[MGSFragariaTextEditingPrefsViewController alloc] init];
    NSTabViewItem *editingTabViewItem = [[NSTabViewItem alloc] initWithIdentifier:@"editingTabViewItem"];
    [editingTabViewItem setLabel:@"Editing"];
    [editingTabViewItem setView:editingVC.view];
    [editingTabViewItem setViewController:editingVC];
    [self insertTabViewItem:editingTabViewItem atIndex:2];
}

@end
