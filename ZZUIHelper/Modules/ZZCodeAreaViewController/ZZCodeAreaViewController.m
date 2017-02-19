//
//  ZZCodeAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeAreaViewController.h"

@interface ZZCodeAreaViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *codeTextView;

@end

@implementation ZZCodeAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [self reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    if ([ZZClassHelper sharedInstance].curClass) {
        self.codeTextView.string = [ZZClassHelper sharedInstance].curClass.mFileCode;
    }
    else {
        self.codeTextView.string = @"";
    }
}

@end
