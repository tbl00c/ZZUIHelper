//
//  ZZSettingViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZSettingViewController.h"

@interface ZZSettingViewController ()
@property (weak) IBOutlet NSTextField *projectNameTF;
@property (weak) IBOutlet NSTextField *authorNameTF;
@property (weak) IBOutlet NSTextField *classPrefixTF;
@property (weak) IBOutlet NSButton *leftParenthesisInNewLine;
@property (weak) IBOutlet NSComboBox *layoutMethod;

@end

@implementation ZZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData
{
    self.projectNameTF.stringValue = [ZZUIHelperConfig sharedInstance].projectName;
    self.authorNameTF.stringValue = [ZZUIHelperConfig sharedInstance].authorName;
    self.classPrefixTF.stringValue = [ZZUIHelperConfig sharedInstance].classPrefix;
    self.leftParenthesisInNewLine.state = [ZZUIHelperConfig sharedInstance].newLineLeftParenthesis;
    [self.layoutMethod selectItemAtIndex:[ZZUIHelperConfig sharedInstance].layoutLibrary];
}

- (IBAction)resetButtonClick:(id)sender {
    [[ZZUIHelperConfig sharedInstance] resetToDefaultConfig];
    [self loadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SETTING_EDIT object:nil userInfo:nil];
}

- (IBAction)okButtonClick:(id)sender {
    [ZZUIHelperConfig sharedInstance].projectName = self.projectNameTF.stringValue;
    [ZZUIHelperConfig sharedInstance].authorName = self.authorNameTF.stringValue;
    [ZZUIHelperConfig sharedInstance].classPrefix = self.classPrefixTF.stringValue;
    [ZZUIHelperConfig sharedInstance].newLineLeftParenthesis = self.leftParenthesisInNewLine.state;
    [ZZUIHelperConfig sharedInstance].layoutLibrary = [self.layoutMethod indexOfSelectedItem];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SETTING_EDIT object:nil userInfo:nil];
    [self dismissController:self];
}


@end
