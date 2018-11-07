//
//  HYConfigurationView.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYContrastHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class HYCarModel;
@interface HYConfigurationView : UIView

/** 左侧配置列表 */
@property (nonatomic, weak) UITableView  *configTable;
/** 滑动代理，用来联动配置列表和对比列表 */
@property (nonatomic, weak) id<HYScrollDelegate> delegate;
/** 数据数组，配置列表从中进行获取自己所用到的数据结构 */
@property (nonatomic, copy) NSArray<HYCarModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
