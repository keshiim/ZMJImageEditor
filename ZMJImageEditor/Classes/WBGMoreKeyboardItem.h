//
//  WBGMoreKeyboardItem.h
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBGMoreKeyboardItem : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imagePath;

@property (nonatomic, strong) UIImage *image;

+ (WBGMoreKeyboardItem *)createByTitle:(NSString *)title imagePath:(NSString *)imagePath image:(UIImage *)image;

@end
