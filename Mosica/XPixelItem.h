//
//  XPixelItem.h
//  RGBTool
//
//  Created by admin on 24/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XPixelItem : NSObject

/** 当前像素点的RGBA */
@property (nonatomic, strong) UIColor *color;
/** 当前像素点的坐标 */
@property (nonatomic, assign) CGPoint location;

@end
