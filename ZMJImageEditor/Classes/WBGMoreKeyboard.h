//
//  WBGMoreKeyboard.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WBGBaseKeyboard.h"
#import "WBGKeyboardDelegate.h"
#import "WBGMoreKeyboardDelegate.h"
#import "WBGMoreKeyboardItem.h"

@interface WBGMoreKeyboard : WBGBaseKeyboard

@property (nonatomic, weak  ) id<WBGMoreKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

+ (WBGMoreKeyboard *)keyboard;

@end
