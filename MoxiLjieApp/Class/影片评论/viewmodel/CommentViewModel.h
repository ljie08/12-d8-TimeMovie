//
//  CommentViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface CommentViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *commentArr;

//获取评论列表
- (void)getCommentListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
