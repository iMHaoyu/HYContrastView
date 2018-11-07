//
//  HYContrastView.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HYCarModel;
@interface HYContrastView : UIView
@property (nonatomic, copy) NSArray<HYCarModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
