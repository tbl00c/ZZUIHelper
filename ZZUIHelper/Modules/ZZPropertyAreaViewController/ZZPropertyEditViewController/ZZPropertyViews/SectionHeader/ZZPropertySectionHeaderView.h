//
//  ZZPropertySectionHeaderView.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/1.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZZPropertySectionModel.h"

@protocol ZZPropertySectionHeaderViewDelegate <NSObject>

- (void)didClickedPropertySectionHeaderView:(ZZPropertySectionModel *)model;

@end

@interface ZZPropertySectionHeaderView : NSView

@property (nonatomic, strong) ZZPropertySectionModel *model;

@property (nonatomic, weak) id<ZZPropertySectionHeaderViewDelegate> delegate;

@property (nonatomic, assign) BOOL showBottomLine;

@end
