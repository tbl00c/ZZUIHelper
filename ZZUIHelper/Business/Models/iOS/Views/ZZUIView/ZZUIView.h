//
//  ZZUIView.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder.h"
#import "ZZCALayer.h"

@interface ZZUIView : ZZUIResponder

@property (nonatomic, strong) NSString *m_initMethodName;

@property (nonatomic, strong) ZZCALayer *layer;

@end
