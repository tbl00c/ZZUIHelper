//
//  ZZCodeAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeAreaViewController.h"

@interface ZZCodeAreaViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *codeTextView;

@property (weak) IBOutlet NSSegmentedControl *segmentView;

@end

@implementation ZZCodeAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newProject) name:NOTI_NEW_PROJECT object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    if ([ZZClassHelper sharedInstance].curClass) {
        if (self.segmentView.selectedSegment == 0) {
            self.codeTextView.string = [ZZClassHelper sharedInstance].curClass.hFileCode;
        }
        else if (self.segmentView.selectedSegment == 1) {
            self.codeTextView.string = [ZZClassHelper sharedInstance].curClass.mFileCode;
        }
        else {
            self.codeTextView.string = @"";
        }
    }
    else {
        self.codeTextView.string = @"";
    }
}

- (void)newProject
{
    NSString *className = [ZZClassHelper sharedInstance].curClass.className;
    [self.segmentView setLabel:[className stringByAppendingString:@".h"] forSegment:0];
    [self.segmentView setLabel:[className stringByAppendingString:@".m"] forSegment:1];
    self.segmentView.selectedSegment = 1;
    [self reloadData];
}

- (IBAction)segmentViewSelectItem:(id)sender {
    [self reloadData];
}

@end
