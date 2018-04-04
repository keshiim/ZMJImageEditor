//
//  ScratchCardView.h
//  RGBTool
//
//  Created by admin on 23/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XScratchView : UIView

/** masoicImage(放在底层) */
@property (nonatomic, strong) UIImage *mosaicImage;
/** surfaceImage(放在顶层) */
@property (nonatomic, strong) UIImage *surfaceImage;
/** 恢复 */
- (void)recover;

@end
