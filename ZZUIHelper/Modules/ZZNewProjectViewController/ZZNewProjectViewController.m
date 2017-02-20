//
//  ZZNewProjectViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNewProjectViewController.h"

@interface ZZNewProjectViewController () <NSComboBoxDelegate>

@property (weak) IBOutlet NSTextField *classNameTF;

@property (weak) IBOutlet NSComboBoxCell *superClassCobox;

@end

@implementation ZZNewProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classNameTF.stringValue = [ZZUIHelperConfig sharedInstance].classPrefix;
    [self.superClassCobox addItemsWithObjectValues:[ZZClassHelper sharedInstance].superClassArray];
    [self.superClassCobox selectItemAtIndex:0];
}

#pragma mark - # Delegate
//MARK: NSComboBoxDelegate
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSInteger index = self.superClassCobox.indexOfSelectedItem;
    NSString *superClass = [ZZClassHelper sharedInstance].superClassArray[index];
    self.classNameTF.stringValue = [[ZZUIHelperConfig sharedInstance].classPrefix stringByAppendingString:[superClass substringFromIndex:2]];
}

#pragma mark - # Event Response
- (IBAction)okButtonClick:(id)sender {
    NSString *className = self.classNameTF.stringValue;
    NSInteger index = self.superClassCobox.indexOfSelectedItem;
    NSString *superClass = [ZZClassHelper sharedInstance].superClassArray[index];
    if (className.length > 0) {
        NSString *className = [@"ZZ" stringByAppendingString:superClass];
        ZZUIResponder *object = [[NSClassFromString(className) alloc] init];
        [object setClassName:className];
        [ZZClassHelper sharedInstance].curClass = object;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROJECT object:nil];
        [self dismissController:self];
    }
}

@end
