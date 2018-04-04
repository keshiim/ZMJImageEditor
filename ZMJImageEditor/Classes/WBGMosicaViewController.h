//
//  WBGMosicaViewController.h
//  FBSnapshotTestCase
//
//  Created by 石磊 on 2018/3/30.
//

#import <UIKit/UIKit.h>

@interface WBGMosicaViewController : UIViewController

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect )frame;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, copy) void (^mosicaCallback)(UIImage *mosicaImage);

@end
