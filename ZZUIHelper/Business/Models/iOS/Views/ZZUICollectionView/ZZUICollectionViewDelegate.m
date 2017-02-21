//
//  ZZUICollectionViewDelegate.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewDelegate.h"

@implementation ZZUICollectionViewDelegate

- (NSString *)className
{
    return @"UICollectionView";
}

- (NSString *)propertyName
{
    return @"collectionView";
}

- (NSString *)protocolName
{
    return @"UICollectionViewDelegate";
}

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"collectionView:didSelectItemAtIndexPath"];
    [array addObjectsFromArray:[super protocolMethods]];
    return array;
}

- (NSArray *)protocolMethodsCode
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[self collectionViewdidSelectItemAtIndexPath]];
    return array;
}

- (NSString *)collectionViewdidSelectItemAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (void)collectionView:(%@ *)%@ didSelectRowAtIndexPath:(NSIndexPath *)indexPath%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

@end
