//
//  WBGMoreKeyboardItem.m
//  WBGKeyboards
//
//  Created by Jason on 2016/10/24.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WBGMoreKeyboardItem.h"

@implementation WBGMoreKeyboardItem

+ (WBGMoreKeyboardItem *)createByTitle:(NSString *)title imagePath:(NSString *)imagePath image:(UIImage *)image
{
    WBGMoreKeyboardItem *item = [[WBGMoreKeyboardItem alloc] init];
    item.title = title;
    item.imagePath = imagePath;
    item.image = image;
    return item;
}
@end
