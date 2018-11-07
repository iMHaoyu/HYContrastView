//
//  HYTextHudView.h
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/29.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**  提示框样式  */
typedef NS_ENUM(NSInteger,HYHubShowType) {
    
    HYHubLoadingType            = 1 << 0,    // 只有一个加载的动画
    HYHubLoadingWithTitleType   = 1 << 1,    // 带有文字的加载动画
    HYHubOnlyTitleType          = 1 << 2,    // 只有文字
    HYHubImageWithTitleType     = 1 << 3,    // 带有图片和文字
};

/**  lodaing 动画样式 (HYHubLoadingType 下)  */
typedef NS_ENUM(NSInteger,HYLoadingAnimationType) {
    
    HYLoadingAnimationRoundType         = 2 << 0,    // Default 圆
    HYLoadingAnimationRectangularType   = 2 << 1,    // 柱状图（矩形波浪）
    HYLoadingAnimationRingType          = 2 << 2,    // 圆环
    HYLoadingAnimationRingIndentType    = 2 << 3,    // 圆环（缩进）
    HYLoadingAnimationSlidGradientType  = 2 << 4,    // 滑动 大小 透明度 渐变
    HYLoadingAnimationSlidCollisionType = 2 << 5,    // 滑动 碰撞
};

/**  文字提示的显示位置  */
typedef NS_ENUM(NSInteger,HYTextHudShowPosition) {
    HYShowCenter,   // 居中
    HYShowTop,      // 居上
    HYShowBottom,   // 居下
};

/**  自带的三种图片  */
static NSString *const  kHYDefaeltTipImageInfo      = @"HY_tips_info";
static NSString *const  kHYDefaeltTipImageSuccessed = @"HY_tips_done";
static NSString *const  kHYDefaeltTipImageFailed    = @"HY_tips_error";



@interface HYTextHudView : UIView

/**  hud 显示类型   */
@property (nonatomic, assign) HYHubShowType          hudShowType;
/**  HYHubLoadingType 下的动画显示类型  */
@property (nonatomic, assign) HYLoadingAnimationType loadingAnimationType;
/**  纯文本提示 显示位置  */
@property (nonatomic, assign) HYTextHudShowPosition  hudDirection;
/**  背景颜色  */
@property (nonatomic, strong) UIColor                *underFillColor;
/**  加载的图片  */
@property (nonatomic, strong) UIImage                *tipImage;


/**
 显示hud

 @param titleStr hud title
 @param delay hud显示时间
 */
- (void)showViewWithTitle:(NSString *)titleStr andDelay:(CGFloat)delay;

/**
 隐藏hud
 */
- (void)hiddenHyHud;
@end
