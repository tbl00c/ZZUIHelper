//
//  ZZUICollectionView.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionView.h"
#import "ZZUICollectionViewDelegate.h"
#import "ZZUICollectionViewDataSource.h"

@implementation ZZUICollectionView
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUICollectionViewDataSource *dataSource = [[ZZUICollectionViewDataSource alloc] init];
        ZZUICollectionViewDelegate *delegate = [[ZZUICollectionViewDelegate alloc] init];
        _delegates = @[dataSource, delegate];
    }
    return _delegates;
}

- (NSString *)curView
{
    return @"self.contentView";
}

- (NSArray *)getterCodeExtCode
{
    NSMutableArray *extCode = @[].mutableCopy;
    [extCode addObject:@"UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];"];
    [extCode addObject:@"[layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];"];
    [extCode addObject:@"[layout setHeaderReferenceSize:CGSizeZero];"];
    [extCode addObject:@"[layout setFooterReferenceSize:CGSizeZero];"];
    [extCode addObject:@"[layout setMinimumLineSpacing:0];"];
    [extCode addObject:@"[layout setMinimumInteritemSpacing:0];"];
    [extCode addObject:@"[layout setSectionInset:UIEdgeInsetsZero];"];
    [extCode addObject:[NSString stringWithFormat:@"_%@ = [[%@ alloc] initWithFrame:CGRectZero collectionViewLayout:layout];", self.propertyName, self.className]];
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setBackgroundColor:[UIColor whiteColor]];", self.propertyName]];
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDataSource:self];", self.propertyName]];
    [extCode addObject:[NSString stringWithFormat:@"[_%@ setDelegate:self];", self.propertyName]];
    return extCode;
}

@end
