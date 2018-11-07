//
//  HYContrastView.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYContrastView.h"
#import "UIView+HYCategory.h"
#import "HYConfigurationView.h"
#import "HYCompareListView.h"
#import "HYContrastHeader.h"

@interface HYContrastView ()<HYScrollDelegate>

/** 左侧配置说明列表 */
@property (nonatomic, strong) HYConfigurationView *configView;
/** 右侧对比列表 */
@property (nonatomic, strong) HYCompareListView   *compareListView;

@end
@implementation HYContrastView

- (HYConfigurationView *)configView {
    if (!_configView) {
        HYConfigurationView *tempView = [[HYConfigurationView alloc]init];
        _configView = tempView;
        [self addSubview:tempView];
    }
    return _configView;
}

- (HYCompareListView *)compareListView {
    if (!_compareListView) {
        HYCompareListView *tempView = [[HYCompareListView alloc]init];
        _compareListView = tempView;
        [self addSubview:tempView];
    }
    return _compareListView;
}

- (void)setDataArray:(NSArray<HYCarModel *> *)dataArray {
    _dataArray = dataArray;
    _configView.dataArray = dataArray;
    _compareListView.compareListData = dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //左侧配置标题列表
        _configView = [[HYConfigurationView alloc]initWithFrame:self.bounds];
        _configView.delegate = self;
        
        //右侧对比列表
        _compareListView = [[HYCompareListView alloc]initWithFrame:CGRectMake(kHYLeftConfigurationW, 0, self.width_hy-kHYLeftConfigurationW, self.height_hy)];
        _compareListView.delegate = self;
        
        [self addSubview:_compareListView];
        [self addSubview:_configView];
    }
    return self;
}

- (void)hy_scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _configView.configTable) {
        _compareListView.compareTable.contentOffset = scrollView.contentOffset;
    } else {
        _configView.configTable.contentOffset = scrollView.contentOffset;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
