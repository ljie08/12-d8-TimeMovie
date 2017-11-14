//
//  MovieDetailViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface MovieDetailViewModel : BaseViewModel

@property (nonatomic, strong) MovieBasic *basic;
@property (nonatomic, strong) MovieBoxOffice *boxOffice;
@property (nonatomic, strong) NSMutableArray *hotArr;
@property (nonatomic, strong) NSMutableArray *actorArr;

//获取详情
- (void)getMovieDetailWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

- (void)getHotCommentWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
