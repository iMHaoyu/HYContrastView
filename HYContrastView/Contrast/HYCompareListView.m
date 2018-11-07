//
//  HYCompareListView.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCompareListView.h"
#import "HYCompareListCell.h"
#import "HYContrastHeaders.h"
#import "UIView+HYCategory.h"
#import "HYCarModel.h"

@interface HYCompareListView ()<UITableViewDelegate,UITableViewDataSource>
/** tableView 下面 用来左右滑动 tableView */
@property (nonatomic, weak) UIScrollView *underScroll;
/** 对比项的 标题 （界面上显示的类似于TableViewHeaderView，其实不是） */
@property (nonatomic, weak) HYCompareListHeader *compareHeader;
/** 对比列表所用到的数据 */
@property (nonatomic, copy)   NSArray<HYGroupParamsViewModelListModel *> *dataSource;
@end
@implementation HYCompareListView

#pragma mark - ⬅️⬅️⬅️⬅️ Getter & Setter ➡️➡️➡️➡️
#pragma mark -
- (UIScrollView *)underScroll {
    if (!_underScroll) {
        UIScrollView *tempView = [[UIScrollView alloc]initWithFrame:self.bounds];
        tempView.bounces = NO;
        [self addSubview:tempView];
        _underScroll = tempView;
    }
    return _underScroll;
}

- (UITableView *)compareTable {
    if (!_compareTable) {
        UITableView *tempView = [[UITableView alloc]init];
        tempView.delegate = self;
        tempView.dataSource = self;
        tempView.rowHeight = kHYLeftConfigCellH;
        [self.underScroll addSubview:tempView];
        _compareTable = tempView;
        
        [_compareTable registerClass:[HYCompareListCell class] forCellReuseIdentifier:NSStringFromClass([HYCompareListCell class])];
    }
    return _compareTable;
}

- (HYCompareListHeader *)compareHeader {
    if (!_compareHeader) {
        HYCompareListHeader *tempView = [[HYCompareListHeader alloc]init];
        [self.underScroll addSubview:tempView];
        _compareHeader = tempView;
    }
    return _compareHeader;
}

- (void)setCompareListData:(NSArray<HYCarModel *> *)compareListData {
    _compareListData = compareListData;
    
    self.dataSource = compareListData[0].groupParamsViewModelList;
    
    CGFloat tempW = compareListData.count * kHYLeftConfigurationW;
    self.underScroll.contentSize = CGSizeMake(tempW, 0);
    self.compareHeader.frame = CGRectMake(0, 20, tempW, kHYLeftConfigHeaderH);
    self.compareTable.frame = CGRectMake(0, CGRectGetMaxY(self.compareHeader.frame), tempW, self.underScroll.height_hy);
    self.compareHeader.headerDetails = compareListData;
    self.compareHeader.deleteCompareListHeaderBlock = ^(NSInteger index) {
        [self compareListHeaderDeleteBtnClickedWithIndex:index];
    };
    [self.compareTable reloadData];
}

#pragma mark - ⬅️⬅️⬅️⬅️ TableView Delegate & DataSource ➡️➡️➡️➡️
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *models = self.dataSource[section].paramList;
    return models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYCompareListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HYCompareListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HYCompareListCell *tempCell = (HYCompareListCell *)cell;
    [tempCell setDataSource:self.compareListData withIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc]init];
    sectionHeader.backgroundColor = [UIColor hy_colorWithHexString:@"eff0f1"];
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

#pragma mark - ⬅️⬅️⬅️⬅️ Private Method ➡️➡️➡️➡️
#pragma mark -
- (void)compareListHeaderDeleteBtnClickedWithIndex:(NSInteger)index {
    NSMutableArray *tempMut = [self.compareListData mutableCopy];
    
    if (tempMut.count > 3) {
       [tempMut removeObjectAtIndex:index];
    }else {
        
        [HYHudTool hy_showBottomTitleTextWithText:@"最少留下两项做对比!"];
    }

    self.compareListData = [tempMut copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
