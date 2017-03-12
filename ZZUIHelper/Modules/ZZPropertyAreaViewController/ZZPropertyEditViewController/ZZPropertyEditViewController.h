//
//  ZZPropertyEditViewController.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZZPropertyEditViewController : NSViewController

@property (nonatomic, strong) ZZNSObject *object;

@property (nonatomic, strong) NSArray *data;

@property (weak) IBOutlet NSCollectionView *collectionView;

@end
