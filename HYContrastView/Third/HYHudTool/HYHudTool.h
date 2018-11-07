//
//  HYHudTool.h
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/28.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYTextHudView.h"

@interface HYHudTool : NSObject

#pragma mark - ⬅️⬅️⬅️⬅️ 只显示 Loading动画 ➡️➡️➡️➡️
#pragma mark -
/**
 菊花等待提示 - 默认 2s
 */
+ (void)hy_loading;

/**
 菊花等待提示

 @param delay             显示时间
 */
+ (void)hy_loadingWithDelay:(CGFloat)delay;

/**
 菊花等待提示
 
 @param animationType     loading 的动画类型
 */
+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType;

/**
 菊花等待提示

 @param animationType     loading 的动画类型
 @param delay             显示时间
 */
+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType andDelay:(CGFloat)delay;

/**
  菊花等待提示

 @param animationType     loading 的动画类型
 @param delay             显示时间
 @param bgColorHexString  背景颜色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha             透明的
 */
+ (void)hy_loadingWithAimationType:(HYLoadingAnimationType)animationType andDelay:(CGFloat)delay andBackgroundColorHexString:(NSString *)bgColorHexString andAlpha:(CGFloat)alpha;



#pragma mark - ⬅️⬅️⬅️⬅️ 显示loading动画 并带有提示文字 ➡️➡️➡️➡️
#pragma mark -
/**
 菊花等待提示加提示文字 - 默认 2s

 @param tipText           提示文字
 */
+ (void)hy_loadingWithTipText:(NSString *)tipText;

/**
 菊花等待提示加提示文字

 @param tipText           提示文字
 @param delay             显示时间
 */
+ (void)hy_loadingWithTipText:(NSString *)tipText andDelay:(CGFloat)delay;

/**
 菊花等待提示加提示文字
 
 @param tipText           提示文字
 @param delay             显示时间
 @param animationType     loading 的动画类型
 */
+ (void)hy_loadingWithTipText:(NSString *)tipText andDelay:(CGFloat)delay andAimationType:(HYLoadingAnimationType)animationType;




#pragma mark - ⬅️⬅️⬅️⬅️ 图片加文字 ➡️➡️➡️➡️
#pragma mark -
/**
 操作成功提示 - 默认 2s
 
 @param tipText           提示文字
 */
+ (void)hy_successedWithTipText:(NSString *)tipText;
+ (void)hy_successedWithTipText:(NSString *)tipText andDelay:(CGFloat)delay;

/**
 操作失败提示 - 默认 2s
 
 @param tipText           提示文字
 */
+ (void)hy_failedWithTipText:(NSString *)tipText;
+ (void)hy_failedWithTipText:(NSString *)tipText andDelay:(CGFloat)delay;


/**
 图片加文字提示

 @param tipText           提示文字
 @param delay             显示时间
 @param image             要显示的图片
 */
+ (void)hy_imageWithTipText:(NSString *)tipText andDelay:(CGFloat)delay andImage:(UIImage *)image;





#pragma mark - ⬅️⬅️⬅️⬅️ 只有文字提示 ➡️➡️➡️➡️
#pragma mark -

/**
 文字提示 - 居中显示 (默认)
 
 @param text              提示内容
 */
+ (void)hy_showTitleTextWithText:(NSString *)text;
+ (void)hy_showTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay;

/**
 文字提示 - 居上显示

 @param text              提示内容
 */
+ (void)hy_showTopTitleTextWithText:(NSString *)text;
+ (void)hy_showTopTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay;


/**
 文字提示 - 居下显示

 @param text              提示内容
 */
+ (void)hy_showBottomTitleTextWithText:(NSString *)text;
+ (void)hy_showBottomTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay;


/**
  文字提示

 @param text              提示内容
 @param delay             显示时间
 @param direction         显示位置
 */
+ (void)hy_showTitleTextWithText:(NSString *)text andDelay:(CGFloat)delay andShowDirection:(HYTextHudShowPosition)direction;


#pragma mark - ⬅️⬅️⬅️⬅️ 隐藏hud ➡️➡️➡️➡️
#pragma mark -
/**
 隐藏hud
 */
+ (void)hy_hiddenHyHud;

@end
