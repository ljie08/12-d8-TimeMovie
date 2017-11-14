//
//  WebManager.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;


@interface WebManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

#pragma mark - Data
//定位城市
- (void)getCityWithSuccess:(void(^)(NSArray *cityList))success failure:(void(^)(NSString *errorStr))failure;

//正在售票
- (void)getOnShowWithLocationId:(NSString *)locationId success:(void(^)(NSArray *showList))success failure:(void(^)(NSString *errorStr))failure;

//正在热映
- (void)getHotShowWithLocationId:(NSString *)locationId success:(void(^)(NSArray *hotList))success failure:(void(^)(NSString *errorStr))failure;

//即将上映
- (void)getComingNewWithLocationId:(NSString *)locationId success:(void(^)(NSArray *newList))success failure:(void(^)(NSString *errorStr))failure;

//影片详情
- (void)getMovieDetailWithLocationId:(NSString *)locationId movieId:(NSString *)movieId success:(void(^)(MovieBasic *basic, MovieBoxOffice *boxOffice, NSArray *actorList))success failure:(void(^)(NSString *errorStr))failure;

//演员表
- (void)getActorListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *actorArr))success failure:(void(^)(NSString *errorStr))failure;

//影片详情-短评
- (void)getHotCommentWithMovieId:(NSString *)movieId success:(void(^)(NSArray *hotCommentArr))success failure:(void(^)(NSString *errorStr))failure;

//短评列表
- (void)getCommentListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *commentArr))success failure:(void(^)(NSString *errorStr))failure;

//预告片
- (void)getVideoListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *trailerArr))success failure:(void(^)(NSString *errorStr))failure;

//剧照
- (void)getImageAllWithMovieId:(NSString *)movieId success:(void(^)(NSArray *stillsArr))success failure:(void(^)(NSString *errorStr))failure;


#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                 withType:(int)type
                 WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailureBlock:(requestFailureBlock)failure;

@end
