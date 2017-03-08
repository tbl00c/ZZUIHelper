//
//  ZZCodeCreator.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCodeCreator : NSObject

+ (ZZCodeCreator *)sharedInstance;

- (NSString *)hFileForViewClass:(ZZUIResponder *)viewClass;

- (NSString *)mFileForViewClass:(ZZUIResponder *)viewClass;

@end
