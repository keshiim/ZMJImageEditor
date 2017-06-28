//
//  WBGChatMacros.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#ifndef WBGChatMacros_h
#define WBGChatMacros_h
#import <UIKit/UIKit.h>

#define     HEIGHT_CHATBAR_TEXTVIEW         36.0f
#define     HEIGHT_MAX_CHATBAR_TEXTVIEW     111.5f
#define     HEIGHT_CHAT_KEYBOARD            215.0f

#define     BORDER_WIDTH_1PX    ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

typedef NS_ENUM(NSInteger, WBGEmojiType) {
    WBGEmojiTypeEmoji,
    WBGEmojiTypeFavorite,
    WBGEmojiTypeFace,
    WBGEmojiTypeImage,
    WBGEmojiTypeImageWithTitle,
    WBGEmojiTypeOther,
};

typedef NS_ENUM(NSInteger, WBGChatBarStatus) {
    WBGChatBarStatusInit,
    WBGChatBarStatusVoice,
    WBGChatBarStatusEmoji,
    WBGChatBarStatusMore,
    WBGChatBarStatusKeyboard,
};

#pragma mark - # SIZE
#define     SIZE_SCREEN                 [UIScreen mainScreen].bounds.size
#define     WIDTH_SCREEN                [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN               [UIScreen mainScreen].bounds.size.height
#define     HEIGHT_STATUSBAR            20.0f
#define     HEIGHT_TABBAR               49.0f
#define     HEIGHT_NAVBAR               44.0f
#define     NAVBAR_ITEM_FIXED_SPACE     5.0f

#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     MAX_MESSAGE_WIDTH               WIDTH_SCREEN * 0.58
#define     MAX_MESSAGE_IMAGE_WIDTH         WIDTH_SCREEN * 0.45
#define     MIN_MESSAGE_IMAGE_WIDTH         WIDTH_SCREEN * 0.25
#define     MAX_MESSAGE_EXPRESSION_WIDTH    WIDTH_SCREEN * 0.35
#define     MIN_MESSAGE_EXPRESSION_WIDTH    WIDTH_SCREEN * 0.2


#define mark - # Default
#define     DEFAULT_AVATAR_PATH    @"default_head"


#pragma mark - # Methods
#define     WBGURL(urlString)    [NSURL URLWithString:urlString]
#define     WBGNoNilString(str)  (str.length > 0 ? str : @"")
#define     WBGWeakSelf(type)    __weak typeof(type) weak##type = type;
#define     WBGStrongSelf(type)  __strong typeof(type) strong##type = type;
#define     WBGTimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])
#define     WBGColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#endif /* WBGChatMacros_h */
