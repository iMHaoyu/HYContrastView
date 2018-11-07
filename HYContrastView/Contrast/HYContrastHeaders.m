//
//  HYContrastHeaders.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYContrastHeaders.h"
#import "HYContrastHeader.h"
#import "UIView+HYCategory.h"
#import "HYCarModel.h"

#pragma mark - ⬅️⬅️⬅️⬅️ 左侧配置说明列表的 headerView ➡️➡️➡️➡️
#pragma mark -
@interface HYConfigHeader ()
/** 配置说明列表 HeaderView 上的 Buttom （可以放置“隐藏相同项”的功能）*/
@property (nonatomic, weak) UIButton *configButton;

/*****************************************************************************/
/***** 下面以后可能会出现其他样式 所以这边就不与其他的下划线做封装处理 (其实就是懒...) *****/
/** 顶部下滑线 */
@property (nonatomic,weak) UIView *topLine;
/** 水平下滑线 */
@property (nonatomic,weak) UIView *horizontalLine;
/** 垂直分隔线 */
@property (nonatomic,weak) UIView *verticalLine;
/*****************************************************************************/

@end
@implementation HYConfigHeader

- (UIButton *)configButton {
    if (!_configButton) {
        UIButton *tempButton = [[UIButton alloc]initWithFrame:self.bounds];
        [tempButton setImage:[UIImage imageNamed:@"ic_contrast"] forState:normal];
        tempButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [tempButton addTarget:self action:@selector(configButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempButton];
        _configButton = tempButton;
    }
    return _configButton;
}

- (UIView *)topLine {
    if (!_topLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _topLine = tempView;
    }
    return _topLine;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(self.width_hy-1, 0, 1, self.height_hy-1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _horizontalLine = tempView;
    }
    return _horizontalLine;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height_hy-1, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _verticalLine = tempView;
    }
    return _verticalLine;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    [self.configButton setTitle:titleStr forState:normal];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configButton];
        [self topLine];
        [self horizontalLine];
        [self verticalLine];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configButton];
    }
    return self;
}

- (void)configButtonClicked:(UIButton *)sender {
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock();
    }
}

@end








#pragma mark - ⬅️⬅️⬅️⬅️ 右侧对比列表的 headerView ➡️➡️➡️➡️
#pragma mark -
@interface HYCompareListHeader ()

@end
@implementation HYCompareListHeader

- (void)setHeaderDetails:(NSArray<HYCarModel *> *)headerDetails {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[HYCompareItemHeaderView class]] || [view isKindOfClass:[HYCompareOtherView class]]) {
            [view removeFromSuperview];
        }
    }
    
    [headerDetails enumerateObjectsUsingBlock:^(HYCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //最后的空白对比项头部
        if (idx == headerDetails.count - 1) {
            HYCompareOtherView *header = [[HYCompareOtherView alloc]initWithFrame:CGRectMake(kHYLeftConfigurationW * idx, 0, kHYLeftConfigurationW, kHYLeftConfigHeaderH)];
            [self addSubview:header];
            
        //其他有值的对比项头部
        }else {
            HYCompareItemHeaderView *header = [[HYCompareItemHeaderView alloc]initWithFrame:CGRectMake(kHYLeftConfigurationW * idx, 0, kHYLeftConfigurationW, kHYLeftConfigHeaderH)];
            header.contentText.text = obj.specName;
            header.index = idx;
            header.compareItemHeaderViewDeleteBlock = ^(NSInteger index) {
                if (self.deleteCompareListHeaderBlock) {
                    self.deleteCompareListHeaderBlock(index);
                }
            };
            [self addSubview:header];
        }
    }];

}

@end








@interface HYCompareItemHeaderView ()

/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;

/*****************************************************************************/
/***** 下面以后可能会出现其他样式 所以这边就不与其他的下划线做封装处理 (其实就是懒...) *****/
/** 顶部下滑线 */
@property (nonatomic,weak) UIView *topLine;
/** 水平下滑线 */
@property (nonatomic,weak) UIView *horizontalLine;
/** 垂直分隔线 */
@property (nonatomic,weak) UIView *verticalLine;
/*****************************************************************************/
@end
@implementation HYCompareItemHeaderView

- (UILabel *)contentText {
    if (!_contentText) {
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, self.width_hy-10, self.height_hy-4)];
        tempLabel.textColor = [UIColor hy_colorWithHexString:@"24354e"];
        tempLabel.font = [UIFont systemFontOfSize:12];
        tempLabel.textAlignment = NSTextAlignmentLeft;
        tempLabel.numberOfLines = 2;
        [self addSubview:tempLabel];
        _contentText = tempLabel;
    }
    return _contentText;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        CGFloat tempW = self.height_hy*0.3;
        UIButton *tempView  = [[UIButton alloc]initWithFrame:CGRectMake(self.width_hy-tempW, 0, tempW, tempW)];
        [tempView setImage:[UIImage imageNamed:@"ic_delete"] forState:normal];
        [tempView addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempView];
        _deleteButton = tempView;
    }
    return _deleteButton;
}

- (UIView *)topLine {
    if (!_topLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _topLine = tempView;
    }
    return _topLine;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(self.width_hy-1, 0, 1, self.height_hy-1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _horizontalLine = tempView;
    }
    return _horizontalLine;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height_hy-1, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _verticalLine = tempView;
    }
    return _verticalLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self contentText];
        [self deleteButton];
        [self topLine];
        [self horizontalLine];
        [self verticalLine];
    }
    return self;
}


- (void)deleteBtnClicked:(UIButton *)sender {
    if (self.compareItemHeaderViewDeleteBlock) {
        self.compareItemHeaderViewDeleteBlock(self.index);
    }
}

@end










@interface HYCompareOtherView ()

@property (nonatomic, weak) UIImageView *imageView;

/*****************************************************************************/
/***** 下面以后可能会出现其他样式 所以这边就不与其他的下划线做封装处理 (其实就是懒...) *****/
/** 顶部下滑线 */
@property (nonatomic,weak) UIView *topLine;
/** 水平下滑线 */
@property (nonatomic,weak) UIView *horizontalLine;
/** 垂直分隔线 */
@property (nonatomic,weak) UIView *verticalLine;
/*****************************************************************************/
@end
@implementation HYCompareOtherView

- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat tempW = 20;
        UIImageView *tempView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width_hy-tempW)*0.5, (self.height_hy-tempW)*0.5, tempW, tempW)];
        tempView.image = [UIImage imageNamed:@"ic_Prohibit"];
        tempView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:tempView];
        _imageView = tempView;
    }
    return _imageView;
}

- (UIView *)topLine {
    if (!_topLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _topLine = tempView;
    }
    return _topLine;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(self.width_hy-1, 0, 1, self.height_hy-1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _horizontalLine = tempView;
    }
    return _horizontalLine;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        UIView *tempView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height_hy-1, self.width_hy, 1)];
        tempView.backgroundColor = [UIColor hy_colorWithHexString:@"dadbdb"];
        [self addSubview:tempView];
        _verticalLine = tempView;
    }
    return _verticalLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self imageView];
        [self topLine];
        [self horizontalLine];
        [self verticalLine];
    }
    return self;
}

@end
