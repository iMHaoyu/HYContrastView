//
//  HYCarModel.h
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYSpecColorListModel,HYGroupParamsViewModelListModel,HYParamlistModel;
@interface HYCarModel : NSObject

@property (nonatomic, assign) NSString *specId;

@property (nonatomic, strong) NSArray<HYSpecColorListModel *> *specColorList;

@property (nonatomic, strong) NSArray<HYGroupParamsViewModelListModel *> *groupParamsViewModelList;

@property (nonatomic,   copy) NSString *specName;

@property (nonatomic, assign) NSInteger seriesId;
@end


@interface HYSpecColorListModel : NSObject

@property (nonatomic, assign) NSString *ID;

@property (nonatomic, assign) NSInteger specId;

@property (nonatomic, assign) NSInteger colorId;

@property (nonatomic,   copy) NSString *colorValue;

@property (nonatomic,   copy) NSString *colorName;

@property (nonatomic, assign) NSInteger bodyId;

@end

@interface HYGroupParamsViewModelListModel : NSObject

@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic,   copy) NSString *groupName;

@property (nonatomic, strong) NSArray<HYParamlistModel *> *paramList;

@end

@interface HYParamlistModel : NSObject

@property (nonatomic, assign) NSString *paramId;

@property (nonatomic,   copy) NSString *paramValue;

@property (nonatomic,   copy) NSString *paramName;

@end

NS_ASSUME_NONNULL_END
