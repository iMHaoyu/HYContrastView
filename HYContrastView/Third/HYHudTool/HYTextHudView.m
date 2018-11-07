//
//  HYTextHudView.m
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/29.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import "HYTextHudView.h"
#import "UIView+HYCategory.h"
#import "UIColor+HYCategory.h"

//默认延迟时间
#define  kHYDefaeltDelay 1.5

//默认背景颜色
#define  kHYDefaeltBackgroundColor [UIColor hy_colorWithHexString:@"000000" alpha:0.8];

//定义高度
#define kHYScreenSize   [UIScreen mainScreen].bounds.size
#define kHYScreenWidth  kHYScreenSize.width
#define kHYScreenHeight kHYScreenSize.height

//LoadingView 宽/高
#define kHYLoadingViewHeight1 80                 //HYHubLoadingType
#define kHYLoadingViewHeight2 50                 //HYHubLoadingWithTitleType
#define kHYTitleLabelWidth    300                //HYHubOnlyTitleType
#define kHYImageWithTitleLoadingViewHeight 50    //HYHubImageWithTitleType

//Toast到顶端/底端默认距离
#define HYTextHudSpace 100.0f

// 判断是不是 X
#define KHYIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)




@interface HYTextHudView ()

/**  loading时显示的样式 （这边显示动画）  */
@property (nonatomic,weak) UIView       *loadingView;

/**  loading时显示的样式 （这边显示提示的图片）  */
@property (nonatomic,weak) UIImageView  *tipsImageView;

/**  提示文字  */
@property (nonatomic,weak) UILabel      *titleLabel;

/**  遮罩视图  */
@property (nonatomic,strong) UIView     * coverView;

/**  延迟时间 (dismiss)  */
@property (nonatomic)NSTimeInterval     delay;

@end
@implementation HYTextHudView
#pragma mark - ⬅️⬅️⬅️⬅️ getter & setter ➡️➡️➡️➡️
#pragma mark -
- (UIView *)loadingView {
    if (!_loadingView) {
        UIView *tempView         = [[UIView alloc]init];
        tempView.hidden          = YES;
        tempView.backgroundColor = [UIColor clearColor];
        [self addSubview:tempView];
        _loadingView = tempView;
    }
    return _loadingView;
}

- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        UIImageView *tempView    = [[UIImageView alloc]init];
        tempView.hidden          = YES;
        tempView.backgroundColor = [UIColor clearColor];
        [self addSubview:tempView];
        _tipsImageView = tempView;
    }
    return _tipsImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *tempView        = [[UILabel alloc]init];
        tempView.backgroundColor = [UIColor clearColor];
        tempView.hidden          = YES;
        tempView.numberOfLines   = 0;
        tempView.textAlignment   = NSTextAlignmentCenter;
        tempView.font            = [UIFont systemFontOfSize:16];
        [self addSubview:tempView];
        _titleLabel = tempView;
    }
    return _titleLabel;
}

- (void)setHudShowType:(HYHubShowType)hudShowType {
    _hudShowType = hudShowType;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _hudShowType          = HYHubLoadingType;
        _loadingAnimationType = HYLoadingAnimationRoundType;
        _underFillColor       = kHYDefaeltBackgroundColor;
        _tipImage             = [UIImage imageNamed:kHYDefaeltTipImageInfo];
        _hudDirection         = HYShowCenter;
    }
    return self;
}

- (void)showViewWithTitle:(NSString *)titleStr andDelay:(CGFloat)delay {
    _coverView = [UIView new];//背景view
    UIWindow * currentWindow = nil;
    
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            currentWindow = window;
            break;
        }
    }
    //默认优先级
    for (UIView * vv in currentWindow.subviews) {
        if ([vv isKindOfClass:[self class]]) {
            HYTextHudView * hud = (HYTextHudView *)vv;
                [hud hiddenHyHud];
        }
    }
    
    _coverView.center = currentWindow.center;
    _coverView.bounds = CGRectMake(0, 0, kHYScreenWidth, kHYScreenHeight);
    [currentWindow addSubview:_coverView];
    [currentWindow addSubview:self];
    [currentWindow bringSubviewToFront:self];
    
    /**  只有加载动画  */
    if (self.hudShowType == HYHubLoadingType) {
        
        self.loadingView.hidden = NO;
        
        //区分loading显示的动画 来设置不同的frame
        if (self.loadingAnimationType != HYLoadingAnimationSlidCollisionType) {
            
            [self setupTextViewWithFrame:CGRectMake(0, 0, kHYLoadingViewHeight1, kHYLoadingViewHeight1)  showPosition:HYShowCenter];
            self.loadingView.frame  = CGRectMake(5, 5, kHYLoadingViewHeight1-10, kHYLoadingViewHeight1-10);
        }else {
            
            [self setupTextViewWithFrame:CGRectMake(0, 0, kHYLoadingViewHeight1*3,kHYLoadingViewHeight1)  showPosition:HYShowCenter];
            self.loadingView.frame  = CGRectMake(5, 5, kHYLoadingViewHeight1*3-10, kHYLoadingViewHeight1-10);
        }
        
        //显示
        [self showAnimationLoadedIntoView:self.loadingView];
        
    /**  带有文字和加载动画  */
    }else if (self.hudShowType == HYHubLoadingWithTitleType) {
        
        self.loadingView.hidden = NO;
        self.titleLabel.hidden  = NO;
        
        CGFloat textHudWidth   = kHYLoadingViewHeight2*3;
        //区分loading显示的动画 来设置不同的frame
        if (self.loadingAnimationType != HYLoadingAnimationSlidCollisionType) {
            self.loadingView.frame = CGRectMake((textHudWidth - kHYLoadingViewHeight2)/2, 10, kHYLoadingViewHeight2, kHYLoadingViewHeight2);
        }else {
            self.loadingView.frame = CGRectMake(5, 5, textHudWidth-10, kHYLoadingViewHeight1-10);
        }
        self.titleLabel.frame      = CGRectMake(0, self.loadingView.maxY_hy+10, kHYLoadingViewHeight2*3, 20);
        [self setupTextViewWithFrame:CGRectMake(0, 0, textHudWidth, self.titleLabel.maxY_hy+10)  showPosition:HYShowCenter];
        
        
        //赋值 显示
        self.titleLabel.text   = titleStr;
        [self showAnimationLoadedIntoView:self.loadingView];
        
    /**  只有文字  */
    }else if (self.hudShowType == HYHubOnlyTitleType) {
        
        self.titleLabel.hidden  = NO;
        [_coverView removeFromSuperview];
        NSDictionary *attrs     = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
        CGSize size             = [titleStr boundingRectWithSize:CGSizeMake(kHYTitleLabelWidth, CGFLOAT_MAX)
                                                         options:NSStringDrawingTruncatesLastVisibleLine |
                                                                 NSStringDrawingUsesLineFragmentOrigin   |
                                                                 NSStringDrawingUsesFontLeading
                                                      attributes:attrs
                                                         context:nil].size;
        self.titleLabel.frame   = CGRectMake(10, 10, size.width, size.height);
        self.titleLabel.text    = titleStr;
        [self setupTextViewWithFrame:CGRectMake(0, 0, size.width+20, self.titleLabel.maxY_hy + 10) showPosition:self.hudDirection];
    
    /**  带有图片和文字  */
    }else if (self.hudShowType == HYHubImageWithTitleType) {
        self.titleLabel.hidden    = NO;
        self.tipsImageView.hidden = NO;
        
        CGFloat textHudWidth      = kHYImageWithTitleLoadingViewHeight*4;
        NSDictionary *attrs       = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
        CGSize size               = [titleStr boundingRectWithSize:CGSizeMake(textHudWidth, CGFLOAT_MAX)
                                                           options: NSStringDrawingTruncatesLastVisibleLine |
                                                                    NSStringDrawingUsesLineFragmentOrigin   |
                                                                    NSStringDrawingUsesFontLeading
                                                        attributes:attrs
                                                           context:nil].size;
        CGFloat imageWidth       = 30;
        self.tipsImageView.frame = CGRectMake((textHudWidth - imageWidth)/2, 10, imageWidth, imageWidth);
        self.titleLabel.frame    = CGRectMake(0, self.tipsImageView.maxY_hy+10, textHudWidth, (size.height<60)?size.height:60);
        
        [self setupTextViewWithFrame:CGRectMake(0, 0, textHudWidth, self.titleLabel.maxY_hy+10)  showPosition:HYShowCenter];
        self.titleLabel.text     = titleStr;
        self.tipsImageView.image = self.tipImage?self.tipImage:[UIImage imageNamed:kHYDefaeltTipImageInfo];
    }
    
    self.delay = delay?delay:0;
    [self hideHud];
}

- (void)hideHud{
    if (self.delay == 0) {
        self.delay = kHYDefaeltDelay;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenHyHud];
    });
}

- (void)hiddenHyHud{
    self.loadingView.hidden   = YES;
    self.titleLabel.hidden    = YES;
    self.tipsImageView.hidden = YES;
    self.hidden       = YES;
    _coverView.hidden = YES;
    [_coverView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)setupTextViewWithFrame:(CGRect)rect showPosition:(HYTextHudShowPosition)showPosition {
    
    self.bounds             = rect;
    if (showPosition == HYShowTop) {
        self.center             = CGPointMake(kHYScreenWidth/2.0, KHYIsiPhoneX?HYTextHudSpace+24:HYTextHudSpace);
    }else if (showPosition == HYShowBottom) {
        self.center             = CGPointMake(kHYScreenWidth/2.0, kHYScreenHeight-HYTextHudSpace);
    }else {
        self.center             = CGPointMake(kHYScreenWidth/2.0, kHYScreenHeight/2.0);
    }
    self.backgroundColor    = self.underFillColor?self.underFillColor:kHYDefaeltBackgroundColor;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds= YES;
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor hy_colorWithHexString:@"ffffff"];
}

- (void)showAnimationLoadedIntoView:(UIView *)view {
    
    ////柱状图模式
    if (self.loadingAnimationType == HYLoadingAnimationRectangularType) {

        [self getLoadingReplicatorLayer2WithView:view];
        
    ////圆环
    }else if (self.loadingAnimationType == HYLoadingAnimationRingType) {
        
        [self getLoadingReplicatorLayer3WithView:view];
        
    ////圆环 (缩进)
    }else if (self.loadingAnimationType == HYLoadingAnimationRingIndentType) {
        
        [self getLoadingReplicatorLayer4WithView:view];
        
    ////滑动 大小 透明度 渐变
    }else if (self.loadingAnimationType == HYLoadingAnimationSlidGradientType) {
        
        [self getLoadingReplicatorLayer5WithView:view];
        
    ////滑动 碰撞
    }else if (self.loadingAnimationType == HYLoadingAnimationSlidCollisionType) {
    
        [self getLoadingReplicatorLayer6WithView:view];
        
    ////旋转波动
    }else {
        
        [self getLoadingReplicatorLayer1WithView:view];
        
    }
}

#pragma mark - ⬅️⬅️⬅️⬅️ Loading 动画 ➡️➡️➡️➡️
#pragma mark -
/*******************************************************************************************************************
 ************ 以下是对 loading加载样式 的动画Demo 可以在(showAnimationLoadedIntoView:)中添加对应你添加的动画样式 *************
 *******************************************************************************************************************/
/**  数学计算  */
#define AngleWithDegrees(deg) (M_PI * (deg) / 180.0)
static const CGFloat kHYAnimationDuration = 0.9;
//旋转波动
- (void)getLoadingReplicatorLayer1WithView:(UIView *)view {
    
    CAReplicatorLayer *containerLayer = [CAReplicatorLayer layer];
    containerLayer.masksToBounds      = YES;
    containerLayer.instanceCount      = 8;
    containerLayer.instanceDelay      = kHYAnimationDuration / containerLayer.instanceCount;
    containerLayer.frame              = CGRectMake(0,0,view.width_hy,view.height_hy);
    containerLayer.instanceTransform  = CATransform3DMakeRotation(AngleWithDegrees(360 / containerLayer.instanceCount), 0, 0, 1);
    
    //在90度要放多少个圆
    NSUInteger count     = containerLayer.instanceCount/4;
    //圆心到切线的角度 一定要是浮点型
    CGFloat cuttingAngle = (90 / (count + 1)) / 2.0f;
    //减少半径
    CGFloat r            = view.width_hy / 2.f;
    //计算 x 坐标
    CGFloat xPoint       = r * sin(AngleWithDegrees(cuttingAngle));
    //计算 y 坐标
    CGFloat yPoint       = r - r * cos(AngleWithDegrees(cuttingAngle));
    //直径
    CGFloat tempW        = sqrt(xPoint * xPoint + yPoint * yPoint)*2;
    
    CALayer *subLayer        = [CALayer layer];
    subLayer.backgroundColor = [UIColor hy_colorWithHexString:@"ecf0f1"].CGColor;
    subLayer.frame           = CGRectMake((view.width_hy - tempW) / 2, 0, tempW, tempW);
    subLayer.cornerRadius    = tempW / 2;
    subLayer.transform       = CATransform3DMakeScale(0, 0, 0);
    [containerLayer addSublayer:subLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue         = @(1);
    animation.toValue           = @(0.1);
    animation.repeatCount       = HUGE;
    animation.duration          = kHYAnimationDuration;
    [subLayer addAnimation:animation forKey:nil];
    
    [view.layer addSublayer:containerLayer];
}

static const CGFloat kHYSubLayerWidth = 8;
static const CGFloat kHYSubLayerSpace = 4;
//柱状图模式
- (void)getLoadingReplicatorLayer2WithView:(UIView *)view {
    
    CAReplicatorLayer *containerLayer = [CAReplicatorLayer layer];
    containerLayer.masksToBounds      = YES;
    containerLayer.instanceCount      = 3;
    containerLayer.instanceDelay      = kHYAnimationDuration / containerLayer.instanceCount;
    containerLayer.instanceTransform  = CATransform3DMakeTranslation(kHYSubLayerWidth + kHYSubLayerSpace, 0, 0);
    CGFloat width                     = kHYSubLayerWidth * containerLayer.instanceCount + (containerLayer.instanceCount - 1) * kHYSubLayerSpace;
    CGFloat height                    = view.height_hy*0.7;
    containerLayer.frame              = CGRectMake((view.width_hy-width)/2, (view.height_hy-height)*0.5, width, height);
    
    CALayer *subLayer        = [CALayer layer];
    subLayer.backgroundColor = [UIColor hy_colorWithHexString:@"ecf0f1"].CGColor;
    subLayer.frame           = CGRectMake(0, height - 6, kHYSubLayerWidth, height);
    subLayer.cornerRadius    = 2;
    [containerLayer addSublayer:subLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue         = @(height * 1.5 - 6);
    animation.toValue           = @(height * 0.5);
    animation.repeatCount       = HUGE;
    animation.duration          = kHYAnimationDuration;
    animation.autoreverses      = YES;
    [subLayer addAnimation:animation forKey:nil];
    
    [view.layer addSublayer:containerLayer];
}

//圆环
- (void)getLoadingReplicatorLayer3WithView:(UIView *)view {
    
    CGFloat width = view.width_hy*0.8;
    
    UIBezierPath *path        = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    CAShapeLayer *shapeLayer  = [CAShapeLayer layer];
    shapeLayer.strokeColor    = [UIColor hy_colorWithHexString:@"ecf0f1"].CGColor;
    shapeLayer.fillColor      = [UIColor clearColor].CGColor;
    shapeLayer.lineCap        = kCALineJoinRound;
    shapeLayer.strokeStart    = 0;
    shapeLayer.strokeEnd      = 0.4;
    shapeLayer.lineWidth      = 6;
    shapeLayer.path           = path.CGPath;
    shapeLayer.frame          = CGRectMake((view.width_hy-width)*0.5, (view.width_hy-width)*0.5, width, width);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration          = 1.5;
    animation.fromValue         = @0;
    animation.toValue           = @(M_PI * 2);
    animation.repeatCount       = INFINITY; // HUGE
    [shapeLayer addAnimation:animation forKey:nil];
    
    [view.layer addSublayer:shapeLayer];
}

//圆环 (缩进)
- (void)getLoadingReplicatorLayer4WithView:(UIView *)view {
    
    CGFloat width = view.width_hy*0.8;
    
    UIBezierPath *path       = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor   = [UIColor hy_colorWithHexString:@"ecf0f1"].CGColor;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.strokeStart   = -1;
    shapeLayer.strokeEnd     = 0;
    shapeLayer.lineWidth     = 4;
    shapeLayer.path          = path.CGPath;
    shapeLayer.frame         = CGRectMake((view.width_hy-width)*0.5, (view.width_hy-width)*0.5, width, width);
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue         = @(-1);
    startAnimation.toValue           = @(1);
    CABasicAnimation *endAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue           = @(0);
    endAnimation.toValue             = @(1);
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations        = @[startAnimation, endAnimation];
    groupAnimation.duration          = 1.5;
    groupAnimation.repeatCount       = INFINITY;
    [shapeLayer addAnimation:groupAnimation forKey:nil];
    
    [view.layer addSublayer:shapeLayer];
}

//滑动 渐变
- (void)getLoadingReplicatorLayer5WithView:(UIView *)view {
    
    
    CGFloat minX      = 4;
    CGFloat roundSize = 10;
    CGFloat minY      = (view.width_hy - roundSize)/2;
    
    
    UIView *shapeView1            = [[UIView alloc] init];
    shapeView1.backgroundColor    = [UIColor hy_colorWithHexString:@"9ed660"];
    shapeView1.layer.cornerRadius = roundSize*0.5;
    [view addSubview:shapeView1];
    
    UIView *shapeView2            = [[UIView alloc] init];
    shapeView2.backgroundColor    = [UIColor hy_colorWithHexString:@"ef5362"];;
    shapeView2.layer.cornerRadius = roundSize*0.5;
    [view addSubview:shapeView2];
    
    UIView *shapeView3            = [[UIView alloc] init];
    shapeView3.backgroundColor    = [UIColor hy_colorWithHexString:@"33bdf3"];;
    shapeView3.layer.cornerRadius = roundSize*0.5;;
    [view addSubview:shapeView3];
    
    
    shapeView1.frame = CGRectMake(minX, minY, roundSize, roundSize);
    shapeView2.frame = CGRectMake(minX, minY, roundSize, roundSize);
    shapeView3.frame = CGRectMake(minX, minY, roundSize, roundSize);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.values = @[@(-(view.width_hy*.05)),
                                 @(view.width_hy*0),
                                 @(view.width_hy*.1),
                                 @(view.width_hy*.4),
                                 @(view.width_hy*.5),
                                 @(view.width_hy*.6),
                                 @(view.width_hy*.8)];
    positionAnimation.keyTimes = @[ @0, @(5 / 90.0), @(25 / 90.0), @(45 / 90.0), @(65 / 90.0), @(85 / 90.0), @1 ];
    positionAnimation.additive = YES;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath  = @"transform.scale";
    scaleAnimation.values   = @[ @.7, @.9, @1, @.9, @.7 ];
    scaleAnimation.keyTimes = @[ @0, @(15 / 90.0), @(45 / 90.0), @(75 / 90.0), @1 ];
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animation];
    alphaAnimation.keyPath  = @"opacity";
    alphaAnimation.values   = @[ @0, @1, @1, @1, @0 ];
    alphaAnimation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations        = @[positionAnimation, scaleAnimation, alphaAnimation];
    group.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.repeatCount       = HUGE_VALF;
    group.duration          = 1.3;
    
    [shapeView1.layer addAnimation:group forKey:@"basic1"];
    group.timeOffset = .43;
    [shapeView2.layer addAnimation:group forKey:@"basic2"];
    group.timeOffset = .86;
    [shapeView3.layer addAnimation:group forKey:@"basic3"];
    
}

// 滑动 碰撞
- (void)getLoadingReplicatorLayer6WithView:(UIView *)view {

    CGFloat smallSize = 6;
    CGFloat minX      = 0;
    CGFloat minY      = (view.height_hy - smallSize)/2;
    UIColor *bgColor  = [UIColor hy_colorWithHexString:@"33bdf3"];
    
    UIView *shapeView1              = [[UIView alloc] init];
    shapeView1.backgroundColor      = bgColor;
    shapeView1.layer.cornerRadius   = smallSize/2;
    [view addSubview:shapeView1];
    
    UIView *shapeView2              = [[UIView alloc] init];
    shapeView2.backgroundColor      = bgColor;
    shapeView2.layer.cornerRadius   = smallSize/2;
    [view addSubview:shapeView2];
    
    UIView *shapeView3              = [[UIView alloc] init];
    shapeView3.backgroundColor      = bgColor;
    shapeView3.layer.cornerRadius   = smallSize/2;
    [view addSubview:shapeView3];
    
    UIView *shapeView4              = [[UIView alloc] init];
    shapeView4.backgroundColor      = bgColor;
    shapeView4.layer.cornerRadius   = smallSize/2;
    [view addSubview:shapeView4];
    
    UIView *shapeView5              = [[UIView alloc] init];
    shapeView5.backgroundColor      = bgColor;
    shapeView5.layer.cornerRadius   = smallSize/2;
    [view addSubview:shapeView5];
    
    shapeView1.frame = CGRectMake(minX, minY, smallSize, smallSize);
    shapeView2.frame = CGRectMake(minX, minY, smallSize, smallSize);
    shapeView3.frame = CGRectMake(minX, minY, smallSize, smallSize);
    shapeView4.frame = CGRectMake(minX, minY, smallSize, smallSize);
    shapeView5.frame = CGRectMake(minX, minY, smallSize, smallSize);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation];
    positionAnimation.keyPath  = @"position.x";
    positionAnimation.duration = 2;
    positionAnimation.values   = @[@(-(view.width_hy*.2)),
                                   @(view.width_hy*.4),
                                   @(view.width_hy*.6),
                                   @(view.width_hy*1.3),];
    positionAnimation.keyTimes = @[ @0, @.4, @.65, @1 ];
    positionAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                                          ];
    positionAnimation.additive = YES;
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animation];
    alphaAnimation.removedOnCompletion  = NO;
    alphaAnimation.keyPath     = @"opacity";
    alphaAnimation.fillMode    = kCAFillModeForwards;
    alphaAnimation.duration    = 2;
    alphaAnimation.values      = @[ @0, @1, @1, @1, @0 ];
    alphaAnimation.keyTimes    = @[ @0, @(.5 / 6.0), @(3 / 6.0), @(5.5 / 6.0), @1 ];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations   = @[positionAnimation, alphaAnimation];
    group.repeatCount  = HUGE_VALF;
    group.duration     = 3.2;
    
    [shapeView1.layer addAnimation:group forKey:nil];
    group.timeOffset = .2;
    [shapeView2.layer addAnimation:group forKey:nil];
    group.timeOffset = .4;
    [shapeView3.layer addAnimation:group forKey:nil];
    group.timeOffset = .6;
    [shapeView4.layer addAnimation:group forKey:nil];
    group.timeOffset = .8;
    [shapeView5.layer addAnimation:group forKey:nil];
}

@end
