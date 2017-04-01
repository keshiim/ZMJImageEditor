//
//  UIImage+library.h
//  Pods
//
//  Created by Jason on 2017/3/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (library)

+ (UIImage *)my_bundleImageNamed:(NSString *)name;
+ (UIImage *)my_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

@end
