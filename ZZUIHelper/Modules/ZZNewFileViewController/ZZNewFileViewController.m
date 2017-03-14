//
//  ZZNewFileViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNewFileViewController.h"

@interface ZZNewFileViewController () <NSComboBoxDelegate>

@property (weak) IBOutlet NSTextField *classNameTF;

@property (weak) IBOutlet NSComboBoxCell *superClassCobox;

@property (weak) IBOutlet NSTextField *defineSuperClassNameLabel;

@property (weak) IBOutlet NSButton *cancelButton;

@end

@implementation ZZNewFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classNameTF.stringValue = [ZZUIHelperConfig sharedInstance].classPrefix;
    [self.superClassCobox addItemsWithObjectValues:[ZZClassHelper sharedInstance].superClassArray];
    [self.superClassCobox selectItemAtIndex:0];
    [self.cancelButton setHidden:[ZZClassHelper sharedInstance].curClass == nil];
}

#pragma mark - # Delegate
//MARK: NSComboBoxDelegate
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    NSInteger index = self.superClassCobox.indexOfSelectedItem;
    NSString *superClass = [ZZClassHelper sharedInstance].superClassArray[index];
    self.classNameTF.stringValue = [[ZZUIHelperConfig sharedInstance].classPrefix stringByAppendingString:[superClass substringFromIndex:2]];
    [self.defineSuperClassNameLabel setPlaceholderString:superClass];
}

#pragma mark - # Event Response
- (IBAction)okButtonClick:(id)sender {
    NSString *className = self.classNameTF.stringValue;
    NSInteger index = self.superClassCobox.indexOfSelectedItem;
    NSString *superClass = [ZZClassHelper sharedInstance].superClassArray[index];
    NSString *defineSuperClass = self.defineSuperClassNameLabel.stringValue;
    defineSuperClass = defineSuperClass.length == 0 ? superClass : defineSuperClass;
    if (className.length > 0) {
        NSString *zzClassName = [@"ZZ" stringByAppendingString:superClass];
        ZZUIResponder *object = [[NSClassFromString(zzClassName) alloc] init];
        [object setClassName:className];
        [object setSuperClassName:defineSuperClass];
        [ZZClassHelper sharedInstance].curClass = object;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROJECT object:nil];
        [self dismissViewController:self];
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    [self dismissViewController:self];
}

@end
