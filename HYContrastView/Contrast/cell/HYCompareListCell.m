//
//  HYCompareListCell.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCompareListCell.h"
#import "UIView+HYCategory.h"
#import "HYCarModel.h"
#import "HYContrastHeader.h"

@interface HYCompareListCell ()

/** 标题内容 */
@property (nonatomic, weak) HYCompareListCellView *titleLabel;

@property (nonatomic, copy) NSArray<HYCompareListCellView *> *viewsArray;

@end
@implementation HYCompareListCell

- (NSArray<HYCompareListCellView *> *)viewsArray {
    if (!_viewsArray) {
        NSArray *tempArr = [NSArray array];
        _viewsArray = tempArr;
    }
    return _viewsArray;
}

- (HYCompareListCellView *)getTitleLabelWithTitleStr:(NSString *)titleStr withIndex:(NSInteger)index {
    HYCompareListCellView *tempView = [[HYCompareListCellView alloc]initWithFrame:CGRectMake(kHYLeftConfigurationW*index, 0, kHYLeftConfigurationW, self.height_hy)];
    tempView.titleStr = titleStr;
    [self.contentView addSubview:tempView];
    return tempView;
}

- (void)setDataSource:(NSArray<HYCarModel *> *)dataSource  withIndexPath:(NSIndexPath *)indexPath {
    
    if ((self.viewsArray.count == 0) || (dataSource.count != self.viewsArray.count)) {
        //先移除 所有视图
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[HYCompareListCellView class]]) {
                [view removeFromSuperview];
            }
        }
        NSMutableArray *tempMutArr = [NSMutableArray array];
        for (int i = 0; i < dataSource.count ; i++) {
            HYCompareListCellView *tempLabel = [self getTitleLabelWithTitleStr:@"" withIndex:i];
            [tempMutArr addObject:tempLabel];
        }
        self.viewsArray = [tempMutArr copy];
    }
    
    [dataSource enumerateObjectsUsingBlock:^(HYCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HYParamlistModel*model = obj.groupParamsViewModelList[indexPath.section].paramList[indexPath.row];
        HYCompareListCellView *tempLabel = self.viewsArray[idx];
        tempLabel.titleStr = model.paramValue;
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#pragma mark - ⬅️⬅️⬅️⬅️ cell 上的Label view ➡️➡️➡️➡️
#pragma mark -
@interface HYCompareListCellView ()

/** 显示标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/*****************************************************************************/
/***** 下面以后可能会出现其他样式 所以这边就不与其他的下划线做封装处理 (其实就是懒...) *****/
/** 水平下滑线 */
@property (nonatomic,weak) UIView *horizontalLine;
/** 垂直分隔线 */
@property (nonatomic,weak) UIView *verticalLine;
/*****************************************************************************/
@end
@implementation HYCompareListCellView
#pragma mark - ⬅️⬅️⬅️⬅️ Getter & Setter ➡️➡️➡️➡️
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kHYLeftConfigurationW, self.height_hy)];
        tempView.textColor = [UIColor hy_colorWithHexString:@"2c2d2e"];
        tempView.font = [UIFont systemFontOfSize:12];
        tempView.textAlignment = NSTextAlignmentCenter;
        tempView.numberOfLines = 2;
        [self addSubview:tempView];
        _titleLabel = tempView;
    }
    return _titleLabel;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(kHYLeftConfigurationW-1, 0, 1, self.height_hy-1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _horizontalLine = tempView;
    }
    return _horizontalLine;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height_hy-1, kHYLeftConfigurationW, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _verticalLine = tempView;
    }
    return _verticalLine;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.frame = self.bounds;
        self.horizontalLine.frame = CGRectMake(self.width_hy-1, 0, 1, self.height_hy-1);
        self.verticalLine.frame = CGRectMake(0, self.height_hy-1, self.width_hy, 1);
    }
    return self;
}


@end
