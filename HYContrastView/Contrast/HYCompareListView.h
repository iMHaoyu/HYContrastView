//
//  HYCompareListView.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYContrastHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class HYCarModel;
@interface HYCompareListView : UIView

/** 对比列表 */
@property (nonatomic, weak) UITableView  *compareTable;
/** 需要显示的对比数据源 */
@property (nonatomic, copy) NSArray<HYCarModel *> *compareListData;
/** 滑动代理，用来联动配置列表和对比列表 */
@property (nonatomic, weak) id<HYScrollDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
