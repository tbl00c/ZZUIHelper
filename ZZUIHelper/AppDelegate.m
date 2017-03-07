//
//  AppDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/16.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    self.window = [NSApplication sharedApplication].windows[0];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    [self.window makeKeyAndOrderFront:self];
    
    return YES;
}

@end
