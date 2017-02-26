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
@property (weak) IBOutlet NSTextField *propertyNameTF;
@property (weak) IBOutlet NSTextField *remarkTF;
@property (weak) IBOutlet NSTextField *warningLabel;

@end

@implementation ZZNewPropertyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.classNameLabel.stringValue = [self.className substringFromIndex:2];
    self.propertyNameTF.stringValue = [[self.className substringFromIndex:4] lowerFirstCharacter];
}

- (IBAction)okButtonClick:(id)sender {
    NSString *propertyName = self.propertyNameTF.stringValue;
    NSString *remark = self.remarkTF.stringValue;

    if (propertyName.length > 0 && [[ZZClassHelper sharedInstance] canNamed:propertyName]) {
        Class cls = NSClassFromString(self.className);
        id a = [[cls alloc] init];
        [[ZZClassHelper sharedInstance].curClass addPrivateProperty:a withName:propertyName andRemarks:remark];
        [self dismissController:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CLASS_PROPERTY_CHANGED object:a];
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
