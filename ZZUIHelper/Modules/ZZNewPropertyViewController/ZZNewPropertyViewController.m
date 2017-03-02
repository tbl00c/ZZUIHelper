//
//  ZZNewPropertyViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNewPropertyViewController.h"
#import "NSString+MMBJ.h"

@interface ZZNewPropertyViewController ()

@property (nonatomic, strong) NSString *uiClassName;

@property (weak) IBOutlet NSTextField *classNameLabel;
@property (weak) IBOutlet NSTextField *definedClassNameLabel;
@property (weak) IBOutlet NSTextField *propertyNameTF;
@property (weak) IBOutlet NSTextField *remarkTF;
@property (weak) IBOutlet NSTextField *warningLabel;

@end

@implementation ZZNewPropertyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *className = [self.className substringFromIndex:2];
    self.definedClassNameLabel.placeholderString = className;
    self.classNameLabel.stringValue = className;
    self.propertyNameTF.stringValue = [[className substringFromIndex:2] lowerFirstCharacter];
    
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    [self.propertyNameTF becomeFirstResponder];
}

- (IBAction)okButtonClick:(id)sender {
    NSString *propertyName = self.propertyNameTF.stringValue;
    NSString *remark = self.remarkTF.stringValue;
    NSString *definedClassName = self.definedClassNameLabel.stringValue;
    if (propertyName.length > 0 && [[ZZClassHelper sharedInstance] canNamed:propertyName]) {
        Class cls = NSClassFromString(self.className);
        ZZNSObject *object = [[cls alloc] init];
        [object setClassName:definedClassName];
        [[ZZClassHelper sharedInstance].curClass addPrivateProperty:object withName:propertyName andRemarks:remark];
        [self dismissController:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_CHANGED object:object];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROPERTY_VC_CLOSE object:nil];
    }
    else {
        self.warningLabel.stringValue = @"类名不可用";
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROPERTY_VC_CLOSE object:nil];
    [self dismissController:self];
}

@end
