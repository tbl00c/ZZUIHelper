//
//  ZZUICollectionViewDataSource.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUICollectionViewDataSource.h"

@implementation ZZUICollectionViewDataSource

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
    return @"UICollectionViewDataSource";
}

- (NSArray *)protocolMethods
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"numberOfSectionsInCollectionView:"];
    [array addObject:@"collectionView:numberOfItemsInSection:"];
    [array addObject:@"collectionView:cellForItemAtIndexPath:"];
    [array addObject:@"collectionView:viewForSupplementaryElementOfKind:atIndexPath:"];
    [array addObject:@"collectionView:canMoveItemAtIndexPath:"];
    [array addObject:@"collectionView:moveItemAtIndexPath:toIndexPath:"];
    [array addObjectsFromArray:[super protocolMethods]];
    return array;
}

- (NSArray *)protocolMethodsCode
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[self numberOfSectionsInCollectionView]];
    [array addObject:[self collectionViewnumberOfItemsInSection]];
    [array addObject:[self collectionViewcellForItemAtIndexPath]];
//    [array addObject:[self collectionViewviewForSupplementaryElementOfKindatIndexPath]];
//    [array addObject:[self collectionViewcanMoveItemAtIndexPath]];
//    [array addObject:[self collectionViewmoveItemAtIndexPathtoIndexPath]];
    return array;
}

- (NSString *)numberOfSectionsInCollectionView
{
    NSString *code = [NSString stringWithFormat:@"- (NSInteger)numberOfSectionsInCollectionView:(%@ *)%@%@\n\treturn 1;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)collectionViewnumberOfItemsInSection
{
    NSString *code = [NSString stringWithFormat:@"- (NSInteger)collectionView:(%@ *)%@ numberOfItemsInSection:(NSInteger)section%@\n\treturn self.data.count;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)collectionViewcellForItemAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (UICollectionViewCell *)collectionView:(%@ *)%@ cellForItemAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn nil;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)collectionViewviewForSupplementaryElementOfKindatIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (UICollectionReusableView *)collectionView:(%@ *)%@ viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath%@\n\treturn nil;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)collectionViewcanMoveItemAtIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (BOOL)collectionView:(%@ *)%@ canMoveItemAtIndexPath:(NSIndexPath *)indexPath%@\n\treturn YES;\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}

- (NSString *)collectionViewmoveItemAtIndexPathtoIndexPath
{
    NSString *code = [NSString stringWithFormat:@"- (void)collectionView:(%@ *)%@ moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)indexPath%@\n\n}\n\n", self.className, self.propertyName, LEFT_PARENTHESIS];
    return code;
}


@end
