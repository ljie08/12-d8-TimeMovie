//
//  TrailerViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TrailerViewModel.h"

@implementation TrailerViewModel

- (instancetype)init {
    if (self = [super init]) {
        _trailerArr = [NSMutableArray array];
    }
    return self;
}

//获取预告片列表
- (void)getTrailerListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getVideoListWithMovieId:movieID success:^(NSArray *trailerArr) {
        if (weakSelf.trailerArr.count) {
            [weakSelf.trailerArr removeAllObjects];
        }
        [weakSelf.trailerArr addObjectsFromArray:trailerArr];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
