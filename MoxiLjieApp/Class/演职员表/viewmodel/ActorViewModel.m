//
//  ActorViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ActorViewModel.h"

@implementation ActorViewModel

- (instancetype)init {
    if (self = [super init]) {
        _actorArr = [[NSMutableArray alloc] init];
    }
    return self;
}

//获取演员列表
- (void)getActorListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getActorListWithMovieId:movieID success:^(NSArray *actorArr) {
        if (weakSelf.actorArr.count) {
            [weakSelf.actorArr removeAllObjects];
        }
        [weakSelf.actorArr addObjectsFromArray:actorArr];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
