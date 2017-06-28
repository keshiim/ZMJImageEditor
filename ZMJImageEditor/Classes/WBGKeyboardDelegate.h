//
//  WBGKeyboardDelegate.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/21.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WBGKeyboardDelegate <NSObject>

@optional
- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardWillDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboardDidDismiss:(id)keyboard animated:(BOOL)animated;

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height;

@end

