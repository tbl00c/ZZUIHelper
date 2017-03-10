//
//  ZZCreatorProtocol.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/10.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZCreatorProtocol <NSObject>

- (NSString *)hFileForViewClass:(ZZUIResponder *)viewClass;

- (NSString *)mFileForViewClass:(ZZUIResponder *)viewClass;

@end
