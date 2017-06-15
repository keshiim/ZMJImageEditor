//
//  colorfullButton.m
//  CLImageEditorDemo
//
//  Created by Jason on 2017/2/27.
//  Copyright © 2017年 CALACULU. All rights reserved.
//

#import "ColorfullButton.h"
IB_DESIGNABLE
@implementation ColorfullButton {
    UIColor *_color;
    CGFloat _radius;
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self drawCirle];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self drawCirle];
}

- (void)setIsUse:(BOOL)isUse {
    _isUse = isUse;
    [self drawCirle];
}

- (void)drawCirle {
    for (CALayer *layer in self.layer.sublayers) {
        if (!layer.hidden) [layer removeFromSuperlayer];
    }
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.f, self.bounds.size.height/2.f) radius:_isUse ? _radius+5: _radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    layer.fillColor = _color.CGColor;
    layer.allowsEdgeAntialiasing = YES;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    if (_isUse) {
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = 2.f;
    }
    layer.path = path.CGPath;
    [path fill];
    UIGraphicsEndImageContext();
    
    [self.layer addSublayer:layer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/

@end
