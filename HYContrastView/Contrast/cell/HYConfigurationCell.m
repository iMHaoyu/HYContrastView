//
//  HYConfigurationCell.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYConfigurationCell.h"
#import "UIView+HYCategory.h"
#import "HYContrastHeader.h"

@interface HYConfigurationCell ()
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
@implementation HYConfigurationCell
#pragma mark - ⬅️⬅️⬅️⬅️ Getter & Setter ➡️➡️➡️➡️
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kHYLeftConfigurationW, self.height_hy)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"edeeef"];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self titleLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self horizontalLine];
    [self verticalLine];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
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
