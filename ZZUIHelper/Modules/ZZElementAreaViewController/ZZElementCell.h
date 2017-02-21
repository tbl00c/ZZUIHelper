//
//  ZZElementCell.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ZZElementCellDelegate <NSObject>

- (void)elementCellDeleteButtonClick:(ZZNSObject *)object;

@end

@interface ZZElementCell : NSTableCellView

@property (nonatomic, weak) id<ZZElementCellDelegate> delegate;

@property (nonatomic, strong) ZZNSObject *object;

@end
