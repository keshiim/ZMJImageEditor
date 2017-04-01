//
//  WBGTextToolView.m
//  CLImageEditorDemo
//
//  Created by Jason on 2017/3/2.
//  Copyright © 2017年 CALACULU. All rights reserved.
//

#import "WBGTextToolView.h"
#import "WBGTextTool.h"
#import "WBGImageEditorGestureManager.h"
#import "UIView+YYAdd.h"
#import "UIImage+library.h"

static const CGFloat MAX_FONT_SIZE = 50.0f;
static const CGFloat MIN_TEXT_SCAL = 0.614f;
static const CGFloat MAX_TEXT_SCAL = 4.0f;
static const CGFloat LABEL_OFFSET  = 13.f;
static const CGFloat DELETEBUTTON_BOUNDS = 26.f;

@interface WBGTextToolOverlapContentView : UIView
@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGFloat defaultFont;
@end

@implementation WBGTextToolOverlapContentView

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        [self setNeedsDisplay];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (_textColor != textColor) {
        _textColor = textColor;
        [self setNeedsDisplay];
    }
}

- (void)setTextFont:(UIFont *)textFont {
    if (_textFont != textFont) {
        _textFont = textFont;
        _defaultFont = textFont.pointSize;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor grayColor]; //阴影颜色
    shadow.shadowOffset= CGSizeMake(2, 2);//偏移量
    shadow.shadowBlurRadius = 5;//模糊度
    
    rect.origin = CGPointMake(1, 2);
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:self.text
                                                                 attributes:@{NSForegroundColorAttributeName : self.textColor,
                                                                              NSFontAttributeName : self.textFont,
                                                                              NSShadowAttributeName: shadow}];
    [string drawInRect:CGRectInset(rect, 21, 25)];
}

@end

@interface WBGTextToolOverlapView ()
@property (nonatomic, strong) WBGTextToolOverlapContentView *contentView;
@end
@implementation WBGTextToolOverlapView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = [[WBGTextToolOverlapContentView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
    }
    return self;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        [_contentView setText:_text];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (_textColor != textColor) {
        _textColor = textColor;
        [_contentView setTextColor:_textColor];
    }
}

- (void)setTextFont:(UIFont *)textFont {
    if (_textFont != textFont) {
        _textFont = textFont;
        _contentView.defaultFont = textFont.pointSize;
        [_contentView setTextFont:_textFont];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.bounds = self.bounds;
    _contentView.origin = CGPointZero;
}

- (void)drawRect:(CGRect)rect {
    //CGFloat scale = [(NSNumber *)[self valueForKeyPath:@"layer.transform.scale.x"] floatValue];
    
    //UIFont *font = [self.textFont fontWithSize:_defaultFont * scale];
    
    
}

@end

@interface WBGTextToolView () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) WBGTextTool *textTool;
@end

@implementation WBGTextToolView
{
    WBGTextLabel  *_label;
    UIButton *_deleteButton;
    
    CGFloat _scale;
    CGFloat _arg;
    
    CGPoint _initialPoint;
    CGFloat _initialArg;
    CGFloat _initialScale;
    
    CALayer *rectLayer1;
    CALayer *rectLayer2;
    CALayer *rectLayer3;
    
    CGFloat _rotation;
}

static WBGTextToolView *activeView = nil;
+ (void)setActiveTextView:(WBGTextToolView *)view
{
    if(view != activeView){
        [activeView setAvtive:NO];
        activeView = view;
        [activeView setAvtive:YES];
        
        [activeView.superview bringSubviewToFront:activeView];
        
    }
}

+ (void)setInactiveTextView:(WBGTextToolView *)view {
    if (activeView) {activeView = nil;}
    
    [view setAvtive:NO];
}

- (instancetype)initWithTool:(WBGTextTool *)tool text:(NSString *)text font:(UIFont *)font
{
    self = [super initWithFrame:CGRectMake(0, 0, 132, 132)];
    if(self){
        
        _archerBGView = [[WBGTextToolOverlapView alloc] initWithFrame:CGRectMake(0, 0, 132, 132)];
        _archerBGView.backgroundColor = [UIColor clearColor];
        
        _label = [[WBGTextLabel alloc] init];
        _label.numberOfLines = 0;
        _label.backgroundColor = [UIColor clearColor];
        _label.font = font;// [UIFont systemFontOfSize:MAX_FONT_SIZE];
        _label.minimumScaleFactor = font.pointSize * 0.8f;
        _label.adjustsFontSizeToFitWidth = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = text;
        _label.layer.allowsEdgeAntialiasing = true;
        self.text = text;
        [self addSubview:_label];
        
        _textTool = tool;
        
        CGSize size = [_label sizeThatFits:CGSizeMake(tool.editor.drawingView.width - 2*LABEL_OFFSET, FLT_MAX)];
        _label.frame = CGRectMake(LABEL_OFFSET, LABEL_OFFSET, size.width + 20, size.height + _label.font.pointSize);
        
        self.frame = CGRectMake(0, 0, _label.width + 2*LABEL_OFFSET, _label.height + 2*LABEL_OFFSET);
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage my_imageNamed:@"close_Text" inBundle:[NSBundle bundleForClass:self.class]] forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake(0, 0, DELETEBUTTON_BOUNDS, DELETEBUTTON_BOUNDS);
        [_deleteButton addTarget:self action:@selector(pushedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        
        _arg = 0;
        [self setScale:1];
        
        [self initGestures];
    }
    return self;
}

- (void)initGestures
{
    _label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPan:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPinch:)];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidRotation:)];
    
    [pinch requireGestureRecognizerToFail:tap];
    [rotation requireGestureRecognizerToFail:tap];
    
    [self.textTool.editor.scrollView.panGestureRecognizer requireGestureRecognizerToFail:pan];
    
    tap.delegate = [WBGImageEditorGestureManager instance];
    pan.delegate = [WBGImageEditorGestureManager instance];
    pinch.delegate = [WBGImageEditorGestureManager instance];
    rotation.delegate = [WBGImageEditorGestureManager instance];
    
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:pan];
    [self addGestureRecognizer:pinch];
    [self addGestureRecognizer:rotation];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if(view == self) {
        return self;
    }
    return view;
}


#pragma mark- gesture events
- (void)pushedDeleteBtn:(id)sender
{
    WBGTextToolView *nextTarget = nil;
    
    const NSInteger index = [self.superview.subviews indexOfObject:self];
    
    for(NSInteger i=index+1; i<self.superview.subviews.count; ++i){
        UIView *view = [self.superview.subviews objectAtIndex:i];
        if([view isKindOfClass:[WBGTextToolView class]]){
            nextTarget = (WBGTextToolView *)view;
            break;
        }
    }
    
    if(nextTarget==nil){
        for(NSInteger i=index-1; i>=0; --i){
            UIView *view = [self.superview.subviews objectAtIndex:i];
            if([view isKindOfClass:[WBGTextToolView class]]){
                nextTarget = (WBGTextToolView *)view;
                break;
            }
        }
    }
    
    [[self class] setActiveTextView:nextTarget];
    [self removeFromSuperview];
    [_archerBGView removeFromSuperview];
}

- (void)viewDidTap:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        if(self.active){
            [self editTextAgain:sender];
        } else {
            //取消当前
            [self.textTool.editor resetCurrentTool];
        }
        [[self class] setActiveTextView:self];
        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
        
    }
}

- (void)viewDidPan:(UIPanGestureRecognizer*)recognizer
{
    //平移
    [[self class] setActiveTextView:self];
    UIView *piece = _archerBGView;
    CGPoint translation = [recognizer translationInView:piece.superview];
    piece.center = CGPointMake(piece.center.x + translation.x, piece.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:piece.superview];

    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
        [self.textTool.editor resetCurrentTool];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        
        CGRect rectCoordinate = [piece.superview convertRect:piece.frame toView:self.textTool.editor.imageView.superview];
        if (!CGRectIntersectsRect(CGRectInset(self.textTool.editor.imageView.frame, 30, 30), rectCoordinate)) {
            [UIView animateWithDuration:.2f animations:^{
                piece.center = piece.superview.center;
                self.center = piece.center;
                
            }];
        }
    
        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
    [self layoutSubviews];
}

- (void)viewDidPinch:(UIPinchGestureRecognizer *)recognizer {
    //缩放
    [[self class] setActiveTextView:self];
    
    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        //坑点：recognizer.scale是相对原图片大小的scal
        
        CGFloat scale = [(NSNumber *)[_archerBGView valueForKeyPath:@"layer.transform.scale.x"] floatValue];
        NSLog(@"scale = %f", scale);
        
        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
        [self.textTool.editor resetCurrentTool];
        
        CGFloat currentScale = recognizer.scale;
        
        if (scale > MAX_TEXT_SCAL && currentScale > 1) {
            return;
        }
        
        if (scale < MIN_TEXT_SCAL && currentScale < 1) {
            return;
        }
        
        
        _archerBGView.transform = CGAffineTransformScale(_archerBGView.transform, currentScale, currentScale);
        recognizer.scale = 1;
        [self layoutSubviews];
        
        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
}

- (void)viewDidRotation:(UIRotationGestureRecognizer *)recognizer {
    //旋转
    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        
        _archerBGView.transform = CGAffineTransformRotate(_archerBGView.transform, recognizer.rotation);
        _rotation = _rotation + recognizer.rotation;
        recognizer.rotation = 0;
        [self layoutSubviews];
        
        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
        [self.textTool.editor resetCurrentTool];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
}

#pragma mark - Edit it again
- (void)editTextAgain:(UITapGestureRecognizer *)recognizer {
    //事件源
    [self.textTool.editor editTextAgain];
    self.textTool.isEditAgain = YES;
    self.textTool.textView.textView.text = self.text;
    self.textTool.textView.textView.font = self.font;
    
    __weak typeof (self)weakSelf = self;
    self.textTool.editAgainCallback = ^(NSString *text){
        weakSelf.text = text;
        [weakSelf resizeSelf];
        weakSelf.font = weakSelf.textTool.textView.textView.font;
        weakSelf.fillColor = weakSelf.textTool.textView.textView.textColor;
    };
    
}

- (void)resizeSelf {
    
    
    CGSize size = [_label sizeThatFits:CGSizeMake(self.textTool.editor.drawingView.width - 2*LABEL_OFFSET, FLT_MAX)];
    _label.frame = CGRectMake(LABEL_OFFSET, LABEL_OFFSET, size.width + 20, size.height + _label.font.pointSize);
    self.bounds = CGRectMake(0, 0, _label.width + 2*LABEL_OFFSET, _label.height + 2*LABEL_OFFSET);
    _archerBGView.bounds = self.bounds;
    
    rectLayer1.frame = CGRectMake(_label.width - 2 - _scale/2.f, - 2, 4, 4);
    rectLayer2.frame = CGRectMake(_scale/2.f - 2, _scale/2.f + _label.height - 2, 4, 4);
    rectLayer3.frame = CGRectMake(_label.width - 2 - _scale/2.f, _label.height - 2 - _scale/2.f, 4, 4);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect boundss;
    if (!_archerBGView.superview) {
        [self.superview insertSubview:_archerBGView belowSubview:self];
        _archerBGView.frame = self.frame;
        boundss = self.bounds;
    }
    boundss = _archerBGView.bounds;
    self.transform = CGAffineTransformMakeRotation(_rotation);
    
    CGFloat w = boundss.size.width;
    CGFloat h = boundss.size.height;
    CGFloat scale = [(NSNumber *)[_archerBGView valueForKeyPath:@"layer.transform.scale.x"] floatValue];

    self.bounds = CGRectMake(0, 0, w*scale, h*scale);
    self.center = _archerBGView.center;
    
    _label.frame = CGRectMake(LABEL_OFFSET, LABEL_OFFSET, self.bounds.size.width - 2*LABEL_OFFSET, self.bounds.size.height - 2*LABEL_OFFSET);
    {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (!rectLayer1) {
            rectLayer1 = [CALayer layer];
            rectLayer1.backgroundColor = [UIColor whiteColor].CGColor;
            [_label.layer addSublayer:rectLayer1];
        }
        rectLayer1.frame = CGRectMake(_label.width - 2 - _scale/2.f, - 2, 4, 4);
        
        
        if (!rectLayer2) {
            rectLayer2 = [CALayer layer];
            rectLayer2.backgroundColor = [UIColor whiteColor].CGColor;
            [_label.layer addSublayer:rectLayer2];
        }
        rectLayer2.frame = CGRectMake(_scale/2.f - 2, _label.height - 2 - _scale/2.f, 4, 4);
        
        
        if (!rectLayer3) {
            rectLayer3 = [CALayer layer];
            rectLayer3.backgroundColor = [UIColor whiteColor].CGColor;
            [_label.layer addSublayer:rectLayer3];
        }
        rectLayer3.frame = CGRectMake(_label.width - 2 - _scale/2.f, _label.height - 2 - _scale/2.f, 4, 4);
        [CATransaction commit];
    }
}

#pragma mark- Properties

- (void)setAvtive:(BOOL)active {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _deleteButton.hidden = !active;
        _label.layer.borderWidth = (active) ? 1/_scale : 0;
        _label.layer.shadowColor = [UIColor grayColor].CGColor;
        _label.layer.shadowOffset= CGSizeMake(0, 0);
        _label.layer.shadowOpacity = .6f;
        _label.layer.shadowRadius = 2.f;
        
        _deleteButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _deleteButton.layer.shadowOffset= CGSizeMake(0, 0);
        _deleteButton.layer.shadowOpacity = .6f;
        _deleteButton.layer.shadowRadius = 2.f;
        
        rectLayer1.hidden = rectLayer2.hidden = rectLayer3.hidden = !active;
        [CATransaction commit];
        
        if (active) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"kColorPanNotificaiton" object:nil];
        } else {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kColorPanNotificaiton" object:nil];
        }
    });
}

- (void)changeColor:(NSNotification *)notification {
    UIColor *currentColor = (UIColor *)notification.object;
    self.fillColor = currentColor;
}

- (BOOL)active
{
    return !_deleteButton.hidden;
}

- (void)sizeToFitWithMaxWidth:(CGFloat)width lineHeight:(CGFloat)lineHeight
{
    self.transform = CGAffineTransformIdentity;
    _label.transform = CGAffineTransformIdentity;
    
    CGSize size = [_label sizeThatFits:CGSizeMake(width / (15/MAX_FONT_SIZE), FLT_MAX)];
    _label.frame = CGRectMake(16, 16, size.width, size.height);
    
    CGFloat viewW = (_label.width + 32);
    CGFloat viewH = _label.font.lineHeight;
    
    CGFloat ratio = MIN(width / viewW, lineHeight / viewH);
    [self setScale:ratio];
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.transform = CGAffineTransformIdentity;
    
    _label.transform = CGAffineTransformMakeScale(_scale, _scale);
    
    CGRect rct = self.frame;
    rct.origin.x += (rct.size.width - (_label.width + 32)) / 2;
    rct.origin.y += (rct.size.height - (_label.height + 32)) / 2;
    rct.size.width  = _label.width + 32;
    rct.size.height = _label.height + 32;
    self.frame = rct;
    
    _label.center = CGPointMake(rct.size.width/2, rct.size.height/2);
    
    self.transform = CGAffineTransformMakeRotation(_arg);
    
    _label.layer.borderWidth = 1/_scale;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _label.textColor = [UIColor clearColor];
    _archerBGView.textColor = fillColor;
}

- (UIColor*)fillColor
{
    //return _label.textColor;
    return _archerBGView.textColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _label.layer.borderColor = borderColor.CGColor;
}

- (UIColor*)borderColor
{
    return [UIColor colorWithCGColor:_label.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _label.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return _label.layer.borderWidth;
}

- (void)setFont:(UIFont *)font
{
    _label.font = font;
    _archerBGView.textFont = font;
}

- (UIFont*)font
{
    return _label.font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _label.textAlignment = textAlignment;
}

- (NSTextAlignment)textAlignment
{
    return _label.textAlignment;
}

- (void)setText:(NSString *)text
{
    if(![text isEqualToString:_text]){
        _text = text;
        _label.text = (_text.length>0) ? _text : @"文字";
        _archerBGView.text = _label.text;
    }
}

@end

@interface WBGTextTool ()
@end

@implementation WBGTextLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    EditImageCropOverLayView *view = [[EditImageCropOverLayView alloc] init];
    view.bounds = self.bounds;
    //[self addSubview:view];
}

- (void)drawTextInRect:(CGRect)rect
{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *txtColor = self.textColor;
    UIFont *font = self.font;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 1);
    CGContextSetLineJoin(contextRef, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(contextRef, kCGTextFill);
    self.textColor = txtColor;
    self.shadowOffset = CGSizeMake(10, 10);
    self.font = font;
    [super drawTextInRect:CGRectInset(rect, 5, 5)];
    
    self.shadowOffset = shadowOffset;
}

@end



@implementation EditImageCropOverLayView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    path.lineWidth = 2.5;
    [[UIColor whiteColor] setStroke];
    [path stroke];
}

@end
