//
//  HYCarModel.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCarModel.h"

@implementation HYCarModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"specColorList" : [HYSpecColorListModel class], @"groupParamsViewModelList" : [HYGroupParamsViewModelListModel class]};
}

@end

@implementation HYSpecColorListModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID" : @"id"};
}

@end

@implementation HYGroupParamsViewModelListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"paramList" : [HYParamlistModel class]};
}

@end

@implementation HYParamlistModel

@end
