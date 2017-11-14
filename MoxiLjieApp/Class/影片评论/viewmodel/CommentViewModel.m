//
//  CommentViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "CommentViewModel.h"

@implementation CommentViewModel

- (instancetype)init {
    if (self = [super init]) {
        _commentArr = [NSMutableArray array];
    }
    return self;
}

//获取评论列表
- (void)getCommentListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    [[WebManager sharedManager] getCommentListWithMovieId:movieID success:^(NSArray *commentArr) {
        if (weakSelf.commentArr.count) {
            [weakSelf.commentArr removeAllObjects];
        }
        [weakSelf.commentArr addObjectsFromArray:commentArr];
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
