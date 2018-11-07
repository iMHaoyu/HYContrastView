//
//  HYHudTool.m
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/28.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import "HYHudTool.h"
#import "UIColor+HYCategory.h"

#define  kHYDefaultDely 2
//超长时间
#define  kHYTimeOut   20.0f
@implementation HYHudTool

/***************************************  只有loading动画  ***************************************/
+(void)hy_loading {
    
    [self hy_loadingWithDelay:kHYTimeOut];
}

+(void)hy_loadingWithDelay:(CGFloat)delay {
    [self hy_loadingWithAimationType:HYLoadingAnimationRingIndentType andDelay:delay andBackgroundColorHexString:nil andAlpha:1];
}

+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType {
    
    [self hy_loadingWithAimationType:animationType andDelay:kHYTimeOut andBackgroundColorHexString:nil andAlpha:1];
}

+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType andDelay:(CGFloat)delay {

    [self hy_loadingWithAimationType:animationType andDelay:delay andBackgroundColorHexString:nil andAlpha:1];
}

+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType andDelay:(CGFloat)delay andBackgroundColorHexString:(NSString *)bgColorHexString andAlpha:(CGFloat)alpha {
    
    HYTextHudView *tempView         = [[HYTextHudView alloc]init];
    tempView.hudShowType            = HYHubLoadingType;
    tempView.underFillColor         = bgColorHexString.length?[UIColor hy_colorWithHexString:bgColorHexString alpha:alpha]:nil;
    tempView.loadingAnimationType   = animationType?animationType:HYLoadingAnimationRoundType;
    [tempView showViewWithTitle:nil andDelay:delay];
}


/***************************************  loading动画 并带有提示文字  ***************************************/
+ (void)hy_loadingWithTipText:(NSString *)tipText {
    
    [self hy_loadingWithTipText:tipText andDelay:kHYTimeOut andAimationType:HYLoadingAnimationRoundType];
}

+ (void)hy_loadingWithTipText:(NSString *)tipText andDelay:(CGFloat)delay {
    
    [self hy_loadingWithTipText:tipText andDelay:delay andAimationType:HYLoadingAnimationRoundType];
}

+ (void)hy_loadingWithTipText:(NSString *)tipText andDelay:(CGFloat)delay andAimationType:(HYLoadingAnimationType)animationType {
    
    HYTextHudView *tempView       = [[HYTextHudView alloc]init];
    if (!tipText.length) {
        tempView.hudShowType      = HYHubLoadingType;
    }else {
        tempView.hudShowType      = HYHubLoadingWithTitleType;
    }
    tempView.loadingAnimationType =  animationType;
    [tempView showViewWithTitle:tipText andDelay:delay];
}



/***************************************  图片加文字提示  ***************************************/
+ (void)hy_successedWithTipText:(NSString *)tipText {
    
    [self hy_imageWithTipText:tipText andDelay:kHYDefaultDely andImage:[UIImage imageNamed:kHYDefaeltTipImageSuccessed]];
}

+ (void)hy_successedWithTipText:(NSString *)tipText andDelay:(CGFloat)delay {
    [self hy_imageWithTipText:tipText andDelay:delay andImage:[UIImage imageNamed:kHYDefaeltTipImageSuccessed]];
}

+ (void)hy_failedWithTipText:(NSString *)tipText {
    
    [self hy_imageWithTipText:tipText andDelay:kHYDefaultDely andImage:[UIImage imageNamed:kHYDefaeltTipImageFailed]];
}

+ (void)hy_failedWithTipText:(NSString *)tipText andDelay:(CGFloat)delay {
    [self hy_imageWithTipText:tipText andDelay:delay andImage:[UIImage imageNamed:kHYDefaeltTipImageFailed]];
}

+ (void)hy_imageWithTipText:(NSString *)tipText andDelay:(CGFloat)delay andImage:(UIImage *)image {
    
    HYTextHudView *tempView   = [[HYTextHudView alloc]init];
    tempView.hudShowType      = HYHubImageWithTitleType;
    tempView.tipImage         = image;
    [tempView showViewWithTitle:tipText andDelay:delay];
}



/***************************************  仅文字提示  ***************************************/

+ (void)hy_showTopTitleTextWithText:(NSString *)text {
    [self hy_showTitleTextWithText:text andDelay:kHYDefaultDely andShowDirection:HYShowTop];
}
+ (void)hy_showTopTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay {
    [self hy_showTitleTextWithText:text andDelay:delay andShowDirection:HYShowTop];
}

+ (void)hy_showBottomTitleTextWithText:(NSString *)text {
    [self hy_showTitleTextWithText:text andDelay:kHYDefaultDely andShowDirection:HYShowBottom];
}
+ (void)hy_showBottomTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay {
    [self hy_showTitleTextWithText:text andDelay:delay andShowDirection:HYShowBottom];
}

+ (void)hy_showTitleTextWithText:(NSString *)text {
    [self hy_showTitleTextWithText:text andDelay:kHYDefaultDely];
}

+ (void)hy_showTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay {
    [self hy_showTitleTextWithText:text andDelay:delay andShowDirection:HYShowCenter];
}

+ (void)hy_showTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay andShowDirection:(HYTextHudShowPosition)direction {
    HYTextHudView *tempView   = [[HYTextHudView alloc]init];
    tempView.hudShowType      = HYHubOnlyTitleType;
    tempView.hudDirection     = direction;
    [tempView showViewWithTitle:text.length?text:@"" andDelay:delay];
}



/***************************************  隐藏  ***************************************/
+ (void)hy_hiddenHyHud {
    UIWindow * currentWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows)
        if (window.windowLevel == UIWindowLevelNormal) {
            currentWindow = window;
            break;
        }
    [currentWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HYTextHudView class]]) {
            HYTextHudView * hud = (HYTextHudView *)obj;
                [hud hiddenHyHud];
        }
    }];
}

@end
