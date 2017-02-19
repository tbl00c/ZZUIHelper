//
//  ZZMainViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZMainViewController.h"
#import "ZZNewProjectViewController.h"

@interface ZZMainViewController ()

@end

@implementation ZZMainViewController

- (void)viewDidAppear {
    [super viewDidAppear];
    
    if ([ZZClassHelper sharedInstance].curClass == nil) {
        ZZNewProjectViewController *vc = [[ZZNewProjectViewController alloc] init];
        [self presentViewControllerAsSheet:vc];
    }
}

@end
