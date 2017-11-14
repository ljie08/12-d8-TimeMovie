//
//  MovieViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieViewModel.h"

@implementation MovieViewModel

- (instancetype)init {
    if (self = [super init]) {
        _hotArr = [NSMutableArray array];
        _newcomingArr = [NSMutableArray array];
    }
    return self;
}

- (void)getHotMovieWithSuccess:(void (^)(BOOL))success failure:(void (^)(NSString *))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getHotShowWithLocationId:CITY_ID success:^(NSArray *hotList) {
        if (weakSelf.hotArr.count) {
            [weakSelf.hotArr removeAllObjects];
        }
        [weakSelf.hotArr addObjectsFromArray:hotList];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

- (void)getNewMovieWithSuccess:(void (^)(BOOL))success failure:(void (^)(NSString *))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getComingNewWithLocationId:CITY_ID success:^(NSArray *newList) {
        if (weakSelf.newcomingArr.count) {
            [weakSelf.newcomingArr removeAllObjects];
        }
        [weakSelf.newcomingArr addObjectsFromArray:newList];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
