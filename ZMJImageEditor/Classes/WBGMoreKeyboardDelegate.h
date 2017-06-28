//
//  WBGMoreKeyboardDelegate.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBGMoreKeyboardItem.h"

@protocol WBGMoreKeyboardDelegate <NSObject>
@optional
- (void) moreKeyboard:(id)keyboard didSelectedFunctionItem:(WBGMoreKeyboardItem *)funcItem;

@end
