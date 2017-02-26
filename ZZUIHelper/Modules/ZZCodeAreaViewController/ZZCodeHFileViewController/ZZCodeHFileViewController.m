//
//  ZZCodeHFileViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeHFileViewController.h"

@interface ZZCodeHFileViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation ZZCodeHFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_EDIT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_NEW_PROJECT object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    if ([ZZClassHelper sharedInstance].curClass) {
        self.textView.string = [ZZClassHelper sharedInstance].curClass.hFileCode;
    }
}

@end
