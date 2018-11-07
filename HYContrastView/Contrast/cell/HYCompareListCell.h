//
//  HYCompareListCell.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HYCarModel;
@interface HYCompareListCell : UITableViewCell

//@property (nonatomic, copy) NSArray<HYCarModel *> *dataSource;
- (void)setDataSource:(NSArray<HYCarModel *> *)dataSource  withIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - ⬅️⬅️⬅️⬅️ cell 上的Label view ➡️➡️➡️➡️
#pragma mark -
@interface HYCompareListCellView : UIView
@property (nonatomic, copy) NSString *titleStr;
@end

NS_ASSUME_NONNULL_END
