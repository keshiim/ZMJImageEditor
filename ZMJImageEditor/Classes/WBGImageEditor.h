//
//  WBGImageEditor.h
//  Trader
//
//  Created by Jason on 2017/3/13.
//
//

#import <UIKit/UIKit.h>

@protocol WBGImageEditorDelegate, WBGImageEditorTransitionDelegate;

@interface WBGImageEditor : UIViewController

@property (nonatomic, weak) id<WBGImageEditorDelegate> delegate;

- (id)initWithImage:(UIImage*)image;
- (id)initWithImage:(UIImage*)image delegate:(id<WBGImageEditorDelegate>)delegate;
- (id)initWithDelegate:(id<WBGImageEditorDelegate>)delegate;

- (void)showInViewController:(UIViewController<WBGImageEditorTransitionDelegate> *)controller withImageView:(UIImageView*)imageView;
- (void)refreshToolSettings;
@end



@protocol WBGImageEditorDelegate <NSObject>
@optional
- (void)imageEditor:(WBGImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image;
- (void)imageEditorDidCancel:(WBGImageEditor *)editor;

@end


@protocol WBGImageEditorTransitionDelegate <WBGImageEditorDelegate>
@optional
- (void)imageEditor:(WBGImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled;
- (void)imageEditor:(WBGImageEditor *)editor didDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled;

@end
