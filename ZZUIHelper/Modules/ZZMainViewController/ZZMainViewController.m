//
//  ZZMainViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZMainViewController.h"
#import "ZZNewFileViewController.h"

#import "ZZMethod.h"

@interface ZZMainViewController ()

@end

@implementation ZZMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZZMethod *methods = [[ZZMethod alloc] init];
    [methods setMethodName:@"    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   "];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    if ([ZZClassHelper sharedInstance].curClass == nil) {
        ZZNewFileViewController *vc = [[ZZNewFileViewController alloc] initWithNibName:@"ZZNewFileViewController" bundle:nil];
        [self presentViewControllerAsSheet:vc];
    }
}

@end
