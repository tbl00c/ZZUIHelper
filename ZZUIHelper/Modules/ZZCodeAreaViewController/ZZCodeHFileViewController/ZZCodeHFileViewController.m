//
//  ZZCodeHFileViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/26.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeHFileViewController.h"
#import <MGSFragaria/MGSFragaria.h>

@interface ZZCodeHFileViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property (nonatomic, strong) MGSFragaria *fragaria;

@end

@implementation ZZCodeHFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.fragaria embedInView:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_CLASS_PROPERTY_EDIT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_NEW_PROJECT object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData
{
    if ([ZZClassHelper sharedInstance].curClass) {
        ZZUIResponder *curClass = [ZZClassHelper sharedInstance].curClass;
        [self.fragaria setString:[[ZZCreatorManager sharedInstance] hFileForViewClass:curClass]];
    }
}

#pragma mark - # Getter
- (MGSFragaria *)fragaria
{
    if (!_fragaria) {
        _fragaria = [[MGSFragaria alloc] init];
        [_fragaria setObject:@"Objective-C" forKey:MGSFOSyntaxDefinitionName];
    }
    return _fragaria;
}


@end
