//
//  ZZControlItem.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ZZControlItemDelegate <NSObject>

- (void)didSelectItemWithClassName:(NSString *)className;

@end

@interface ZZControlItem : NSCollectionViewItem
@property (nonatomic, weak) id<ZZControlItemDelegate> delegate;
@property (nonatomic, strong) NSString *buttonTitle;
@end
