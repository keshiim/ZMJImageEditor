//
//  XRGBTool.h
//  RGBTool
//
//  Created by admin on 21/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface XRGBTool : NSObject

/** 获取所有的像素点RGBA和坐标 */
+ (NSArray *)getRGBsArrFromImage:(UIImage *)image;

//局部修改图片颜色
+ (UIImage *)changePicColorPartial:(UIImage *)image;

/** 通过遍历像素点实现马赛克效果,level越大,马赛克颗粒越大,若level为0则默认为图片1/20 */
+ (UIImage *)getMosaicImageWith:(UIImage *)image level:(NSInteger)level;

/** 通过滤镜来实现马赛克效果(只能处理.png格式的图片) */
+ (UIImage *)getFilterMosaicImageWith:(UIImage *)image;

@end
