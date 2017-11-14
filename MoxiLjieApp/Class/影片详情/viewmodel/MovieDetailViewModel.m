//
//  MovieDetailViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieDetailViewModel.h"

@implementation MovieDetailViewModel

- (instancetype)init {
    if (self = [super init]) {
        _basic = [[MovieBasic alloc] init];
        _boxOffice = [[MovieBoxOffice alloc] init];
        _hotArr = [NSMutableArray array];
        _actorArr = [NSMutableArray array];
    }
    return self;
}


//获取详情
- (void)getMovieDetailWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getMovieDetailWithLocationId:CITY_ID movieId:movieID success:^(MovieBasic *basic, MovieBoxOffice *boxOffice, NSArray *actorList) {
        weakSelf.basic = basic;
        weakSelf.boxOffice = boxOffice;
        if (weakSelf.actorArr.count) {
            [weakSelf.actorArr removeAllObjects];
        }
        [weakSelf.actorArr addObjectsFromArray:actorList];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

- (void)getHotCommentWithMovieID:(NSString *)movieID success:(void (^)(BOOL))success failure:(void (^)(NSString *))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getHotCommentWithMovieId:movieID success:^(NSArray *hotCommentArr) {
        if (weakSelf.hotArr.count) {
            [weakSelf.hotArr removeAllObjects];
        }
        [weakSelf.hotArr addObjectsFromArray:hotCommentArr];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
