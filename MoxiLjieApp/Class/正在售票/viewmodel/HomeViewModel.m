//
//  HomeViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/31.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init {
    if (self = [super init]) {
        _cityArr = [NSMutableArray array];
        _movieArr = [NSMutableArray array];
    }
    return self;
}

//获取城市
- (void)getCitySuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getCityWithSuccess:^(NSArray *cityList) {
        if (weakSelf.cityArr.count) {
            [weakSelf.cityArr removeAllObjects];
        }
        [weakSelf.cityArr addObjectsFromArray:cityList];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

- (NSString *)getLocalCityIDWithCityName:(NSString *)cityName {
    NSString *cityID;
    for (City *city in self.cityArr) {
        NSString *cityname = [LJUtil stringToLowerCase:city.n];
        cityName = [LJUtil stringToLowerCase:cityName];
        if ([cityname isEqualToString:cityName]) {
            cityID = city.city_id;
        }
    }
    return cityID;
}

//获取电影
- (void)getMovieWithSuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getOnShowWithLocationId:CITY_ID success:^(NSArray *showList) {
        if (weakSelf.movieArr.count) {
            [weakSelf.movieArr removeAllObjects];
        }
        [weakSelf.movieArr addObjectsFromArray:showList];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
