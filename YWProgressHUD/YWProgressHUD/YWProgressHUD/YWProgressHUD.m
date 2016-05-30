//
//  LBProgressHUD.m
//  LuckyBuy
//
//  Created by huangtie on 16/3/9.
//  Copyright © 2016年 Qihoo. All rights reserved.
//

#import "YWProgressHUD.h"
#import <CoreText/CoreText.h>
#import "UIView+Frame.h"

#define SIZE_RADIUS_WIDTH 24
#define SIZE_FONT_TITLE 18

#define SIZE_SCALE 0.32
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SIZE_CONTAINERVIEW_WIDTH       SCREEN_WIDTH * SIZE_SCALE
#define SIZE_CONTAINERVIEW_HEIGHT      SCREEN_WIDTH * SIZE_SCALE

#define SIZE_CIRCLELINE_WIDTH  8

#define KEY_ANIMATION_ROTATE @"KEY_ANIMATION_ROTATE"

@interface YWProgressHUD()

@property (nonatomic, strong) UIView *containerView;  ///< 总视图容器

@property (nonatomic, strong) UIView *rotateView;  ///< 旋转圆圈视图


@property (nonatomic, strong) CAShapeLayer *bottomRotateLayer;   ///< 底部圆圈

@property (nonatomic, strong) CAShapeLayer *rotateLayer;   ///< 半圆圈

@property (nonatomic, strong) UILabel *titleLable; ///< 标题Lable

@end

@implementation YWProgressHUD

- (instancetype)initWithView:(UIView *)view {
    
    return [self initWithFrame:view.bounds];
}

- (instancetype)initWithWindow:(UIWindow *)window {
    
    return [self initWithView:window];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addMySubviews];

    }
    return self;
}

- (void)addMySubviews {
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - SIZE_CONTAINERVIEW_WIDTH) / 2, (self.frame.size.height - SIZE_CONTAINERVIEW_WIDTH) / 2 , SIZE_CONTAINERVIEW_WIDTH, SIZE_CONTAINERVIEW_HEIGHT)];
    _containerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    _containerView.layer.cornerRadius = 10;
    _containerView.hidden = YES;
    [self addSubview:_containerView];
    
    _rotateView = [[UIView alloc] initWithFrame:CGRectMake((_containerView.frame.size.width - 2 * SIZE_RADIUS_WIDTH) / 2, (_containerView.frame.size.height - 2 * SIZE_RADIUS_WIDTH) / 2 - 10, 2 * SIZE_RADIUS_WIDTH, 2 * SIZE_RADIUS_WIDTH)];
    _rotateView.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_rotateView];
    
    // 旋转圆圈
    
    UIBezierPath *bottomPathRotate= [UIBezierPath bezierPathWithArcCenter:CGPointMake(SIZE_RADIUS_WIDTH, SIZE_RADIUS_WIDTH) radius:SIZE_RADIUS_WIDTH startAngle:0 endAngle:M_PI_2 * 4 clockwise:YES];
    _bottomRotateLayer = [CAShapeLayer layer];
    _bottomRotateLayer.path = bottomPathRotate.CGPath;
    _bottomRotateLayer.fillColor = [UIColor clearColor].CGColor;
    _bottomRotateLayer.strokeColor = [UIColor lightGrayColor].CGColor;   // 旋转圆圈底色
    _bottomRotateLayer.lineWidth = SIZE_CIRCLELINE_WIDTH;
    _bottomRotateLayer.lineCap = kCALineCapRound;
    [_rotateView.layer addSublayer:_bottomRotateLayer];
    
    UIBezierPath *pathRotate= [UIBezierPath bezierPathWithArcCenter:CGPointMake(SIZE_RADIUS_WIDTH, SIZE_RADIUS_WIDTH) radius:SIZE_RADIUS_WIDTH startAngle:0 endAngle:M_PI_2 clockwise:YES];
    _rotateLayer = [CAShapeLayer layer];
    _rotateLayer.path = pathRotate.CGPath;
    _rotateLayer.fillColor = [UIColor clearColor].CGColor;
    _rotateLayer.strokeColor = [UIColor whiteColor].CGColor;
    _rotateLayer.lineWidth = SIZE_CIRCLELINE_WIDTH;
    _rotateLayer.lineCap = kCALineCapRound;
    [_rotateView.layer addSublayer:_rotateLayer];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = @(2*M_PI);
    rotateAnimation.duration = 1.3;
    rotateAnimation.repeatCount = HUGE;
    rotateAnimation.removedOnCompletion = NO;
    [_rotateView.layer addAnimation:rotateAnimation forKey:KEY_ANIMATION_ROTATE];
    
    // 标题文本
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rotateView.frame) + 10, _containerView.frame.size.width, 30)];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.font = [UIFont systemFontOfSize:SIZE_FONT_TITLE];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = _lableText;
    [_containerView addSubview:_titleLable];

}


#pragma mark -- SET OR GET

- (void)setLableText:(NSString *)lableText {
    
    _lableText = lableText;
    _titleLable.text = _lableText;
}

- (void)setShowMask:(BOOL)showMask {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:showMask - .5];
}

#pragma mark -- Method

- (void)show:(BOOL)animated {
    
    self.containerView.hidden = NO;
    if (animated)
    {
        self.containerView.transform = CGAffineTransformScale(self.transform,0.2,0.2);
        
        [UIView animateWithDuration:.3 animations:^{
            self.containerView.transform = CGAffineTransformScale(self.transform,1.05,1.05);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? .3 : 0 delay:.1 options:UIViewAnimationOptionCurveEaseOut  animations:^{
        self.containerView.transform = CGAffineTransformScale(self.transform,1.05,1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animated ? .3 : 0 animations:^{
            self.containerView.transform = CGAffineTransformScale(self.transform,0.2,0.2);
        } completion:^(BOOL finished) {
            [self.rotateView.layer removeAnimationForKey:KEY_ANIMATION_ROTATE];
            [self removeFromSuperview];
        }];
    }];
}


+ (instancetype)showHUDto:(UIView *)view animated:(BOOL)animated {
    YWProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (instancetype)showHUDto:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated {

    YWProgressHUD *hud = [[self alloc] initWithView:view];
    hud.titleLable.text = title;
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews)
    {
        if ([aView isKindOfClass:[YWProgressHUD class]])
        {
            [huds addObject:aView];
        }
    }
    
    for (YWProgressHUD *hud in huds)
    {
        [hud hide:animated];
    }
    return [huds count];
}

#pragma mark - New Show And Hide
+ (instancetype)showHUD:(UIView *)view animated:(BOOL)animated {
    return [self showHUD:view text:@"" animated:animated];
}
+ (instancetype)showHUD:(UIView *)view text:(NSString *)text animated:(BOOL)animated {
    YWProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    hud.containerView.hidden = NO;


    if (text.length > 0) {
        [hud.titleLable setText:text];

        [hud.containerView setHeight:SIZE_CONTAINERVIEW_HEIGHT + 20];
        [hud.containerView setWidth:SIZE_CONTAINERVIEW_HEIGHT + 20];

        [hud.rotateView setX:(hud.containerView.frame.size.width - 2 * SIZE_RADIUS_WIDTH) / 2];
        [hud.rotateView setY:(hud.containerView.frame.size.height - 2 * SIZE_RADIUS_WIDTH) / 2 - 15];
        [hud.titleLable setWidth:hud.containerView.frame.size.width];

    }
    else {

        [hud.containerView setHeight:SIZE_CONTAINERVIEW_HEIGHT];
    }

    [hud setAlpha:0];
    [UIView animateWithDuration:animated ? .3 : 0 animations:^{
        [hud setAlpha:1];

    } completion:^(BOOL finished) {
    }];

    return hud;
}
+ (void)hideAllHUD:(UIView *)view animated:(BOOL)animated {

    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:[YWProgressHUD class]]) {
            [huds addObject:aView];
        }
    }

    for (YWProgressHUD *hud in huds) {
        [UIView animateWithDuration:animated ? .3 : 0 animations:^{
            [hud setAlpha:0];

        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    }
}



@end
