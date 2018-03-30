//
//  XRGBTool.m
//  RGBTool
//
//  Created by admin on 21/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import "XRGBTool.h"
#import "XPixelItem.h"

@implementation XRGBTool

+ (NSArray *)getRGBsArrFromImage:(UIImage *)image{
    //1.get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;//一个像素四个分量，即ARGB
    NSUInteger bytesPerRow = bytesPerPixel * imageW;
    unsigned char *rawData = (unsigned char *)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char));
    NSUInteger bitsPerComponent = 8;//每个分量8个字节
    /*
     参数1：数据源
     参数2：图片宽
     参数3：图片高
     参数4：表示每一个像素点，每一个分量大小
     在我们图像学中，像素点：ARGB组成 每一个表示一个分量（例如，A，R，G，B）
     在我们计算机图像学中每一个分量的大小是8个字节
     参数5：每一行大小（其实图片是由像素数组组成的）
     如何计算每一行的大小，所占用的内存
     首先计算每一个像素点大小（我们取最大值）： ARGB是4个分量 = 每个分量8个字节 * 4
     参数6:颜色空间
     参数7:是否需要透明度
     */
    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
    
    //2.Now your rawData contains the image data int the RGBA8888 pixel format
    NSUInteger blackPixel = 0;
    NSMutableArray *pixelsArr = [NSMutableArray array];
    for (int y = 0; y < imageH; y++) {
        for (int x = 0; x < imageW; x++) {
            NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
            //rawData一维数组存储方式RGBA(第一个像素)RGBA(第二个像素)
            NSUInteger red = rawData[byteIndex];
            NSUInteger green = rawData[byteIndex+1];
            NSUInteger blue = rawData[byteIndex+2];
            NSUInteger alpha = rawData[byteIndex+3];
            XPixelItem *pixelItem = [[XPixelItem alloc] init];
            pixelItem.color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
            pixelItem.location = CGPointMake(x, y);
            [pixelsArr addObject:pixelItem];
            if  (red+green+blue == 0 && (alpha/255.0 >= 0.5)){//计算黑色部分所占比例
                blackPixel++;
            }
        }
    }
    NSLog(@"黑色所占的面积--%f,%lu",blackPixel*1.0/(imageW*imageH),(unsigned long)pixelsArr.count);
    imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(rawData);
    return pixelsArr;
}

+ (UIImage *)changePicColorPartial:(UIImage *)image{
    //1.get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;//一个像素四个分量，即ARGB
    NSUInteger bytesPerRow = bytesPerPixel * imageW;
    unsigned char *rawData = (unsigned char *)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char));
    NSUInteger bitsPerComponent = 8;//每个分量8个字节
    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
    
    //2.Now your rawData contains the image data int the RGBA8888 pixel format
    for (int y = 0; y < imageH; y++) {
        for (int x = 0; x < imageW; x++) {
            NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
            //rawData一维数组存储方式RGBA(第一个像素)RGBA(第二个像素)
            NSUInteger red = rawData[byteIndex];
            NSUInteger green = rawData[byteIndex+1];
            NSUInteger blue = rawData[byteIndex+2];
            NSUInteger alpha = rawData[byteIndex+3];
            if (red+green+blue == 0 && (alpha/255.0 >= 0.5)) {//黑色部分
                rawData[byteIndex] = 180;
                rawData[byteIndex+1] = 180;
                rawData[byteIndex+2] = 180;
                rawData[byteIndex+3] = 255;
            }else if(red+green+blue == 0 && (alpha/255.0 < 0.5)){//透明部分
                rawData[byteIndex] = 255;
                rawData[byteIndex+1] = 0;
                rawData[byteIndex+2] = 0;
                rawData[byteIndex+3] = 150;
            }else if(red+green+blue == 255*3 && (alpha/255.0 >= 0.5)){//白色部分
                rawData[byteIndex] = 140;
                rawData[byteIndex+1] = 128;
                rawData[byteIndex+2] = 214;
                rawData[byteIndex+3] = 255;
            }
        }
    }
    imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(rawData);
    return [UIImage imageWithCGImage:imageRef];

}

+ (UIImage *)getMosaicImageWith:(UIImage *)image level:(NSInteger)level{
    CGImageRef imageRef = image.CGImage;
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char *)calloc(imageH*imageW*4, sizeof(unsigned char));
    CGContextRef contextRef = CGBitmapContextCreate(rawData, imageW, imageH, 8, imageW*4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageW, imageH), imageRef);
   
    unsigned char *bitMapData = CGBitmapContextGetData(contextRef);
    NSUInteger currentIndex,preCurrentIndex;
    NSUInteger sizeLevel = level == 0 ? MIN(imageW, imageH)/40.0 : level;
    //像素点默认是4个通道
    unsigned char *pixels[4] = {0};
    for (int i = 0; i < imageH; i++) {
        for (int j = 0; j < imageW; j++) {
            currentIndex = imageW*i + j;
            NSUInteger red = rawData[currentIndex*4];
            NSUInteger green = rawData[currentIndex*4+1];
            NSUInteger blue = rawData[currentIndex*4+2];
            NSUInteger alpha = rawData[currentIndex*4+3];
            if (red+green+blue == 0 && (alpha/255.0 <= 0.5)) {
                rawData[currentIndex*4] = 255;
                rawData[currentIndex*4+1] = 255;
                rawData[currentIndex*4+2] = 255;
                rawData[currentIndex*4+3] = 0;
                continue;
            }
            /*
             memcpy指的是c和c++使用的内存拷贝函数，memcpy函数的功能是从源src所指的内存地址的起始位置开始拷贝n个字节到目标dest所指的内存地址的起始位置中。
             strcpy和memcpy主要有以下3方面的区别。
             1、复制的内容不同。strcpy只能复制字符串，而memcpy可以复制任意内容，例如字符数组、整型、结构体、类等。
             2、复制的方法不同。strcpy不需要指定长度，它遇到被复制字符的串结束符"\0"才结束，所以容易溢出。memcpy则是根据其第3个参数决定复制的长度。
             3、用途不同。通常在复制字符串时用strcpy，而需要复制其他类型数据时则一般用memcpy
             */
            if (i % sizeLevel == 0) {
                if (j % sizeLevel == 0) {
                    memcpy(pixels, bitMapData+4*currentIndex, 4);
                }else{
                    //将上一个像素点的值赋给第二个
                    memcpy(bitMapData+4*currentIndex, pixels, 4);
                }
            }else{
                preCurrentIndex = (i-1)*imageW+j;
                memcpy(bitMapData+4*currentIndex, bitMapData+4*preCurrentIndex, 4);
            }
        }
    }
    //获取图片数据集合
    NSUInteger size = imageW*imageH*4;
    CGDataProviderRef providerRef = CGDataProviderCreateWithData(NULL, bitMapData, size, NULL);
    //创建马赛克图片，根据变换过的bitMapData像素来创建图片
    CGImageRef mosaicImageRef = CGImageCreate(imageW, imageH, 8, 4*8, imageW*4, colorSpace, kCGBitmapByteOrderDefault, providerRef, NULL, NO, kCGRenderingIntentDefault);//Creates a bitmap image from data supplied by a data provider.
    //创建输出马赛克图片
    CGContextRef outContextRef = CGBitmapContextCreate(bitMapData, imageW, imageH, 8, imageW*4, colorSpace, kCGImageAlphaPremultipliedLast);
    //绘制图片
    CGContextDrawImage(outContextRef, CGRectMake(0, 0, imageW, imageH), mosaicImageRef);
    
    CGImageRef resultImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *mosaicImage = [UIImage imageWithCGImage:resultImageRef];
    //释放内存
    CGImageRelease(resultImageRef);
    CGImageRelease(mosaicImageRef);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(providerRef);
    CGContextRelease(outContextRef);
    return mosaicImage;
}


+ (UIImage *)getFilterMosaicImageWith:(UIImage *)image{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
//    NSLog(@"%@",filter.attributes);
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setDefaults];
    //导出图片
    CIImage *outPutImage = [filter valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outPutImage fromRect:[outPutImage extent]];
    UIImage *showImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return showImage;
}


@end
