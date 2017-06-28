//
//  WBGMoreKeyboardCell.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBGMoreKeyboardItem.h"

@interface WBGMoreKeyboardCell : UICollectionViewCell
@property (nonatomic, strong) WBGMoreKeyboardItem *item;

@property (nonatomic, strong) void(^clickBlock)(WBGMoreKeyboardItem *item);

@end
