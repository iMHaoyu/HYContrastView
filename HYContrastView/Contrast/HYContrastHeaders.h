//
//  HYContrastHeaders.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ⬅️⬅️⬅️⬅️ 左侧配置说明列表的 headerView ➡️➡️➡️➡️
#pragma mark -
typedef void(^HYConfigHeaderButtonClickedBlock)(void);
@interface HYConfigHeader : UIView

/** header 上显示的标题 */
@property (nonatomic, copy) NSString *titleStr;
/** 配置 header 上的 button 点击事件回调 */
@property (nonatomic, copy) HYConfigHeaderButtonClickedBlock  buttonClickedBlock;
@end


#pragma mark - ⬅️⬅️⬅️⬅️ 右侧对比列表的 headerView ➡️➡️➡️➡️
#pragma mark -
@class HYCarModel;
typedef void(^HYDeleteCompareListHeaderBlock)(NSInteger index);
@interface HYCompareListHeader : UIView

/** 对比列表 所有对比项的 headerView */
@property (nonatomic, copy) NSArray<HYCarModel *> *headerDetails;
/** 删除 header 回调块 */
@property (nonatomic, copy) HYDeleteCompareListHeaderBlock deleteCompareListHeaderBlock;

@end




typedef void(^HYCompareItemHeaderViewDeleteBlock)(NSInteger index);
@interface HYCompareItemHeaderView : UIView

/** 数据所在数组中的下标值 */
@property (nonatomic, assign) NSInteger index;

/** 显示的内容 Label */
@property (nonatomic, weak) UILabel *contentText;
/** 删除按钮的回调块 */
@property (nonatomic, copy) HYCompareItemHeaderViewDeleteBlock compareItemHeaderViewDeleteBlock;
@end




@interface HYCompareOtherView : UIView

@end

NS_ASSUME_NONNULL_END
