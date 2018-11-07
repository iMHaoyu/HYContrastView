//
//  HYContrastHeader.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#ifndef HYContrastHeader_h
#define HYContrastHeader_h

/** 左边配置标题栏的宽度 */
static CGFloat const kHYLeftConfigurationW = 100.f;
/** 左边配置标题栏和右边对比列表的 headerView 高度 */
static CGFloat const kHYLeftConfigHeaderH = 50.f;
/** 左边配置标题栏和右边对比列表的 Cell 高度 */
static CGFloat const kHYLeftConfigCellH = 40.f;
/** 左边配置标题栏和右边对比列表的 Section 高度 */
static CGFloat const kHYLeftConfigSectionHeaderH  = 30.f;



/** 滑动代理 */
@protocol HYScrollDelegate <NSObject>
- (void)hy_scrollViewDidScroll:(UIScrollView *)scrollView;
@end



/** 颜色分类 */
#import "UIColor+HYCategory.h"
#import "HYHudTool.h"
#endif /* HYContrastHeader_h */
