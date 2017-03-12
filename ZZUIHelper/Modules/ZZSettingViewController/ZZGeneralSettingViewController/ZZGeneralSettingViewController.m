//
//  ZZGeneralSettingViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZGeneralSettingViewController.h"

@interface ZZGeneralSettingViewController () <NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *projectNameTF;
@property (weak) IBOutlet NSTextField *authorNameTF;
@property (weak) IBOutlet NSTextField *classPrefixTF;
@property (weak) IBOutlet NSButton *leftParenthesisInNewLine;
@property (weak) IBOutlet NSComboBox *layoutMethod;

@end

@implementation ZZGeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil userInfo:nil];
}

- (void)loadData
{
    self.projectNameTF.stringValue = [ZZUIHelperConfig sharedInstance].projectName;
    self.authorNameTF.stringValue = [ZZUIHelperConfig sharedInstance].authorName;
    self.classPrefixTF.stringValue = [ZZUIHelperConfig sharedInstance].classPrefix;
    self.leftParenthesisInNewLine.state = [ZZUIHelperConfig sharedInstance].newLineLeftParenthesis;
    [self.layoutMethod selectItemAtIndex:[ZZUIHelperConfig sharedInstance].layoutLibrary];
}

#pragma mark - # Delegate
//MARK: NSTextFieldDelegate
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSTextField *textfield = obj.object;
    if (textfield.tag == 0) {
        [ZZUIHelperConfig sharedInstance].projectName = self.projectNameTF.stringValue;
    }
    else if (textfield.tag == 1) {
        [ZZUIHelperConfig sharedInstance].authorName = self.authorNameTF.stringValue;
    }
    else {
        [ZZUIHelperConfig sharedInstance].classPrefix = self.classPrefixTF.stringValue;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil userInfo:nil];
}

#pragma mark - # Event Response
- (IBAction)codeStytleChanged:(id)sender {
    [ZZUIHelperConfig sharedInstance].newLineLeftParenthesis = self.leftParenthesisInNewLine.state;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil userInfo:nil];
}

- (IBAction)layoutMethodChanged:(id)sender {
    [ZZUIHelperConfig sharedInstance].layoutLibrary = [self.layoutMethod indexOfSelectedItem];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil userInfo:nil];
}


- (IBAction)resetButtonClick:(id)sender {
    [[ZZUIHelperConfig sharedInstance] resetToDefaultConfig];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_EDIT object:nil userInfo:nil];
    [self loadData];
}


@end
