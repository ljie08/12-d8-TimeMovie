//
//  StillsViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "StillsViewModel.h"

@implementation StillsViewModel

- (instancetype)init {
    if (self = [super init]) {
        _stillsArr = [NSMutableArray array];
    }
    return self;
}

//获取剧照列表
- (void)getStillsListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getImageAllWithMovieId:movieID success:^(NSArray *stillsArr) {
        if (weakSelf.stillsArr.count) {
            [weakSelf.stillsArr removeAllObjects];
        }
        [weakSelf.stillsArr addObjectsFromArray:stillsArr];
        success(YES);
        
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
