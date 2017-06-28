//
//  WBGBaseKeyboard.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/21.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBGChatMacros.h"
#import "WBGKeyboardDelegate.h"
#import "WBGKeyboardProtocol.h"

@interface WBGBaseKeyboard : UIView <WBGKeyboardProtocol>

///是否正在展示
@property (nonatomic, assign, readonly) BOOL isShow;

///键盘事件回调
@property (nonatomic, weak) id<WBGKeyboardDelegate> keyboardDelegate;

/**
 *  显示键盘(keyWindow上)
 *  @param animation 是否显示动画
 */
- (void)showWithAnimation:(BOOL)animation;

/**
 *  显示键盘
 *  @param view      父view
 *  @param animation 是否显示动画
 */
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

/**
 *  键盘消失
 *  @param animation 是否显示消失动画
 */
- (void)dismissWithAnimation:(BOOL)animation;

/**
 *  重置键盘⌨️
 */
- (void)reset;

@end
