//
//  HYConfigurationView.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYConfigurationView.h"
#import "HYContrastHeaders.h"
#import "UIView+HYCategory.h"
#import "HYCarModel.h"
#import "HYConfigurationCell.h"

@interface HYConfigurationView ()<UITableViewDelegate,UITableViewDataSource>

/** 事件响应的范围 */
@property (nonatomic, strong) UIBezierPath *path;
/** 配置列表的头标题 */
@property (nonatomic, weak)   HYConfigHeader *configHeader;
/** 配置列表所用到的数据 */
@property (nonatomic, copy)   NSArray<HYGroupParamsViewModelListModel *> *dataSource;

@end
@implementation HYConfigurationView

/** 设置Path范围内为可响应事件范围 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGPathIsEmpty(self.path.CGPath)) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - ⬅️⬅️⬅️⬅️ Getter & Setter ➡️➡️➡️➡️
#pragma mark -
- (UITableView *)configTable {
    if (!_configTable) {
        UITableView *tempView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.configHeader.frame), self.width_hy, self.height_hy)];
        tempView.delegate = self;
        tempView.dataSource = self;
        tempView.bounces = NO;
        tempView.rowHeight = kHYLeftConfigCellH;
        tempView.showsVerticalScrollIndicator = NO;
        tempView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tempView.backgroundColor = [UIColor clearColor];
        [self addSubview:tempView];
        _configTable = tempView;
        
        [_configTable registerClass:[HYConfigurationCell class] forCellReuseIdentifier:NSStringFromClass([HYConfigurationCell class])];
    }
    return _configTable;
}

- (HYConfigHeader *)configHeader {
    if (!_configHeader) {
        HYConfigHeader *headerView = [[HYConfigHeader alloc]initWithFrame:CGRectMake(0, 20, kHYLeftConfigurationW, kHYLeftConfigHeaderH)];
        headerView.buttonClickedBlock = ^{
            
        };
        [self addSubview:headerView];
        _configHeader = headerView;
    }
    return _configHeader;
}

- (void)setDataArray:(NSArray<HYCarModel *> *)dataArray {
    _dataArray = dataArray;
    self.dataSource = dataArray[0].groupParamsViewModelList;
    [self.configTable reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kHYLeftConfigurationW, self.height_hy)];
        self.path = path;
        
        [self configTable];
        [self configHeader];
    }
    return self;
}

#pragma mark - ⬅️⬅️⬅️⬅️ TableView Delegate & DataSource ➡️➡️➡️➡️
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *tempLists = self.dataSource[section].paramList;
    return tempLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYConfigurationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HYConfigurationCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HYConfigurationCell *tempCell = (HYConfigurationCell *)cell;
    HYParamlistModel *model = self.dataSource[indexPath.section].paramList[indexPath.row];
    tempCell.titleStr = model.paramName;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc]init];
    sectionHeader.backgroundColor = [UIColor hy_colorWithHexString:@"eff0f1"];
    
    UILabel *sectionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, kHYLeftConfigSectionHeaderH)];
    HYGroupParamsViewModelListModel *model = self.dataSource[section];
    sectionTitleLabel.text = model.groupName;
    sectionTitleLabel.font = [UIFont systemFontOfSize:13];
    sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    sectionTitleLabel.numberOfLines = 2;
    sectionTitleLabel.textColor = [UIColor hy_colorWithHexString:@"757677"];
    [sectionHeader addSubview: sectionTitleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kHYLeftConfigSectionHeaderH-1, self.configTable.width_hy, 1)];
    line.backgroundColor = [UIColor hy_colorWithHexString:@"dcddde"];
    [sectionHeader addSubview: line];
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHYLeftConfigSectionHeaderH;
}

#pragma mark - ⬅️⬅️⬅️⬅️ UIScrollViewDelegate ➡️➡️➡️➡️
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hy_scrollViewDidScroll:)]) {
        [self.delegate hy_scrollViewDidScroll:scrollView];
    }
}


@end
