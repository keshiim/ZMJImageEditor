//
//  WBGMosicaViewController.m
//  FBSnapshotTestCase
//
//  Created by 石磊 on 2018/3/30.
//

#import "WBGMosicaViewController.h"
#import "XScratchView.h"
#import "XRGBTool.h"

@interface WBGMosicaViewController ()
@property (nonatomic, strong) XScratchView *scratchView;
@property (nonatomic, strong) UIView *toolView;
@end

@implementation WBGMosicaViewController


- (instancetype)initWithImage:(UIImage *)image frame:(CGRect )frame {
    self = [super init];
    if (self) {
        self.image = image;
        self.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat WIDTH = self.view.frame.size.width;
    CGFloat HEIGHT = self.view.frame.size.height;

    XScratchView *scratchView = [[XScratchView alloc] initWithFrame:self.frame];
    //    scratchView.mosaicImage = [XRGBTool getFilterMosaicImageWith:[UIImage imageNamed:@"qq.png"]];
    scratchView.surfaceImage = self.image;
    scratchView.mosaicImage = [XRGBTool getMosaicImageWith:self.image level:0];

    _scratchView = scratchView;
    [self.view addSubview:scratchView];

    UIView *toolView = [[UIView alloc] init];
    toolView.frame = CGRectMake(0, HEIGHT - 49, WIDTH, 49);
    toolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:toolView];
    _toolView = toolView;

    CGFloat btnW = WIDTH / 3.0;
    NSArray *arr = @[@"返回",@"撤销",@"完成"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, 49);
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.accessibilityLabel = arr[i];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:btn];
    }
}

- (void)buttonAction:(UIButton *)btn {
    switch (btn.tag) {
        case 100:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 101:
            [_scratchView recover];
            break;
        case 102:
        {
            __weak typeof(self) weakSelf = self;
            UIGraphicsBeginImageContextWithOptions(weakSelf.scratchView.frame.size, NO, 0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [weakSelf.scratchView.layer renderInContext:context];
            UIImage *deadledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            if (weakSelf.mosicaCallback) {
                weakSelf.mosicaCallback(deadledImage);
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
