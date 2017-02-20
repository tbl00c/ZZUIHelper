//
//  ZZWindowController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZWindowController.h"
#import "ZZNewProjectViewController.h"

@interface ZZWindowController ()


@end

@implementation ZZWindowController

//MARK: NSToolbarDelegate
- (IBAction)newButtonClick:(id)sender {
    ZZNewProjectViewController *vc = [[ZZNewProjectViewController alloc] initWithNibName:@"ZZNewProjectViewController" bundle:nil];
    NSViewController *presentVC = self.window.contentViewController.childViewControllers[1];
    [presentVC presentViewControllerAsSheet:vc];
}

- (IBAction)exportButtonClick:(id)sender {
}

@end
