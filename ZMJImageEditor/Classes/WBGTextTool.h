//
//  WBGTextTool.h
//  CLImageEditorDemo
//
//  Created by Jason on 2017/3/1.
//  Copyright © 2017年 CALACULU. All rights reserved.
//

#import "WBGImageToolBase.h"
@class _WBGTextView;

@interface WBGTextTool : WBGImageToolBase
@property (nonatomic, copy) void(^dissmissTextTool)(NSString *currentText);//, BOOL isEditAgain);
@property (nonatomic, strong) _WBGTextView *textView;
@property (nonatomic, assign) BOOL isEditAgain;
@property (nonatomic, copy)   void(^editAgainCallback)(NSString *text);
@end


@interface _WBGTextView : UIView
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, copy) void(^dissmissTextTool)(NSString *currentText, BOOL isUse);//, BOOL isEditAgain);
@property (nonatomic, strong) UITextView *textView;
@end

@interface _WBGToolBar : UIToolbar
+ (instancetype)createToolBarWithCancel:(dispatch_block_t)cancelBlock done:(dispatch_block_t)doneBlock;
@end
