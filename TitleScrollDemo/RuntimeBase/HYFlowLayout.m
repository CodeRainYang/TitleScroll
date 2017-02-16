//
//  HYFlowLayout.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYFlowLayout.h"

@implementation HYFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
