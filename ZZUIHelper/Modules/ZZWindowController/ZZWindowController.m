//
//  ZZWindowController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZWindowController.h"
#import "ZZNewFileViewController.h"
#import <MGSFragaria/MGSFragaria.h>


@interface ZZWindowController ()


@end

@implementation ZZWindowController

//MARK: NSToolbarDelegate
- (IBAction)newButtonClick:(id)sender {
    ZZNewFileViewController *vc = [[ZZNewFileViewController alloc] initWithNibName:@"ZZNewFileViewController" bundle:nil];
    NSViewController *presentVC = self.window.contentViewController.childViewControllers[1];
    [presentVC presentViewControllerAsSheet:vc];
}

- (IBAction)exportButtonClick:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanCreateDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    __weak typeof(self)weakSelf = self;
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSString *pathString = [panel.URLs.firstObject path];
            [weakSelf exportFilesToPath:pathString];
        }
    }];
}

- (void)exportFilesToPath:(NSString *)path
{
    //.h
    NSString *fileName = [[ZZClassHelper sharedInstance].curClass.className stringByAppendingString:@".h"];
    NSString *hPath = [path stringByAppendingPathComponent:fileName];
    NSString *hCode = [ZZClassHelper sharedInstance].curClass.hFileCode;
    if (![self p_writeCode:hCode toFileAtPath:hPath]) {
        
        return;
    }
    
    //.m
    fileName = [[ZZClassHelper sharedInstance].curClass.className stringByAppendingString:@".m"];
    NSString *mPath = [path stringByAppendingPathComponent:fileName];
    NSString *mCode = [ZZClassHelper sharedInstance].curClass.mFileCode;
    if (![self p_writeCode:mCode toFileAtPath:mPath]) {
        
        return;
    }
    
    [[NSWorkspace sharedWorkspace] openFile:path];
}

- (IBAction)codeSettingButtonClick:(id)sender {
    MGSFragariaFontsAndColoursPrefsViewController *vc = [[MGSFragariaFontsAndColoursPrefsViewController alloc] init];
    NSViewController *presentVC = self.window.contentViewController.childViewControllers[1];
    [presentVC presentViewControllerAsModalWindow:vc];
}

- (BOOL)p_writeCode:(NSString *)code toFileAtPath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"删除已存在的%@文件失败", [filePath lastPathComponent]);
            return NO;
        }
    }
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:filePath contents:[code dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    if (!ok) {
        NSLog(@"%@文件写入失败", [filePath lastPathComponent]);
    }
    return ok;
}

@end
