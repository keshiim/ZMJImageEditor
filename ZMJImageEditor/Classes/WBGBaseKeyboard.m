//
//  WBGBaseKeyboard.m
//  WBGKeyboards
//
//  Created by Jason on 2016/10/21.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WBGBaseKeyboard.h"
#import <Masonry/Masonry.h>
@import YYCategories.UIView_YYAdd;

@implementation WBGBaseKeyboard

#pragma mark - Public Methods
- (void)showWithAnimation:(BOOL)animation {
    [self showInView:[UIApplication sharedApplication].keyWindow withAnimation:animation];
}

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation {
    if (_isShow) {
        return;
    }
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillShow:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillShow:self animated:animation];
    }
    
    [view addSubview:self];
    CGFloat keyboardHeight = [self keyboardHeight];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.height.mas_equalTo(keyboardHeight);
        make.bottom.mas_equalTo(view).mas_offset(keyboardHeight);
    }];
    
    [view layoutIfNeeded];
    
    if (animation) {
        [UIView animateWithDuration:.25f animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view);
            }];
            [view layoutIfNeeded];
            _isShow = YES;
            
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:view.height - self.top];
            }
        } completion:^(BOOL finished) {
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
            }
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view);
        }];
        [view layoutIfNeeded];
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
        }
         _isShow = YES;
    }
    
}

- (void)dismissWithAnimation:(BOOL)animation {
    if (!_isShow) {
        if (!animation) {
            [self removeFromSuperview];
        }
        return;
    }
    
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillDismiss:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillDismiss:self animated:animation];
    }
    
    if (animation) {
        CGFloat keyboardHeight = [self keyboardHeight];
        [UIView animateWithDuration:.25f animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.superview).mas_offset(keyboardHeight);
            }];
            
            [self.superview layoutIfNeeded];
            
            _isShow = NO;
            
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:self.superview.height - self.top];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
            }
            
        }];
    }
    else {
        [self removeFromSuperview];
        
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
        
            [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
        }
        
        _isShow = NO;
    }
}

- (void)reset {
    
}

#pragma mark - WBGKeybardProtocol
- (CGFloat)keyboardHeight {
    return HEIGHT_CHAT_KEYBOARD;
}

@end
