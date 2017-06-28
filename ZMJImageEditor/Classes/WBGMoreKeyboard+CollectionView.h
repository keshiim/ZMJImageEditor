//
//  WBGMoreKeyboard+CollectionView.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WBGMoreKeyboard.h"

@interface WBGMoreKeyboard (CollectionView) <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign, readonly) NSInteger pageItemCount;

- (void)registerCellClass;
@end
