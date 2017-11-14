//
//  WebManager.m
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "WebManager.h"

@implementation WebManager

+ (instancetype)sharedManager {
    static WebManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
    }
    return self;
}

#pragma mark - Data
//定位城市
- (void)getCityWithSuccess:(void(^)(NSArray *cityList))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET withType:1 WithUrl:Location_PATH WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *cityArr = [City mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"p"]];
        
        success(cityArr);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//正在售票
- (void)getOnShowWithLocationId:(NSString *)locationId success:(void(^)(NSArray *showList))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:locationId forKey:@"locationId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:OnShow_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *showArr = [Movie mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"movies"]];
        success(showArr);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//正在热映
- (void)getHotShowWithLocationId:(NSString *)locationId success:(void(^)(NSArray *hotList))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:locationId forKey:@"locationId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:HotShow_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *hotArr = [HotMovie mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"ms"]];
        success(hotArr);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//即将上映
- (void)getComingNewWithLocationId:(NSString *)locationId success:(void(^)(NSArray *newList))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:locationId forKey:@"locationId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:ComingNew_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *newArr = [NewMovie mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"moviecomings"]];
        success(newArr);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//影片详情
- (void)getMovieDetailWithLocationId:(NSString *)locationId movieId:(NSString *)movieId success:(void(^)(MovieBasic *basic, MovieBoxOffice *boxOffice, NSArray *actorList))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:locationId forKey:@"locationId"];
    [params setObject:movieId forKey:@"movieId"];
    
//    NSString *url = [NSString stringWithFormat:@"%@?locationId=%@&movieId=%@", MovieDetail_PATH, locationId, movieId];
    
    [self requestWithMethod:GET withType:0 WithUrl:MovieDetail_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSDictionary *basicDic = [data objectForKey:@"basic"];
        NSArray *actorArr = [Actor mj_objectArrayWithKeyValuesArray:[basicDic objectForKey:@"actors"]];
        MovieBasic *basic = [MovieBasic mj_objectWithKeyValues:basicDic];
        MovieBoxOffice *box = [MovieBoxOffice mj_objectWithKeyValues:[data objectForKey:@"boxOffice"]];
        success(basic, box, actorArr);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//演员表
- (void)getActorListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *actorArr))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:movieId forKey:@"movieId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:Aoctor_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *types = [dic objectForKey:@"types"];
        NSArray *actors = [NSArray array];
        for (NSDictionary *typeDic in types) {
            if ([[typeDic objectForKey:@"typeName"] isEqualToString:@"演员"]) {
//                NSArray *arr = [typeDic objectForKey:@"persons"];
                actors = [Actor mj_objectArrayWithKeyValuesArray:[typeDic objectForKey:@"persons"]];
            }
        }
        
        success(actors);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//影片详情-短评
- (void)getHotCommentWithMovieId:(NSString *)movieId success:(void(^)(NSArray *hotCommentArr))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:movieId forKey:@"movieId"];
    
    [self requestWithMethod:GET withType:0 WithUrl:HotComment_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSDictionary *mini = [data objectForKey:@"mini"];
        NSArray *list = [ShortComment mj_objectArrayWithKeyValuesArray:[mini objectForKey:@"list"]];
        success(list);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//短评列表
- (void)getCommentListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *commentArr))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:movieId forKey:@"movieId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:ShortComments_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSArray *comments = [Comment mj_objectArrayWithKeyValuesArray:[data objectForKey:@"cts"]];
        success(comments);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//预告片
- (void)getVideoListWithMovieId:(NSString *)movieId success:(void(^)(NSArray *trailerArr))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:movieId forKey:@"movieId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:Video_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *videos = [Trailer mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"videoList"]];
        success(videos);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//剧照
- (void)getImageAllWithMovieId:(NSString *)movieId success:(void(^)(NSArray *stillsArr))success failure:(void(^)(NSString *errorStr))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:movieId forKey:@"movieId"];
    
    [self requestWithMethod:GET withType:1 WithUrl:ImageAll_PATH WithParams:params WithSuccessBlock:^(NSDictionary *dic) {
        NSArray *images = [Stills mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"images"]];
        success(images);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}


#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                 withType:(int)type
                  WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure {
    
    if (type) {
        url = [NSString stringWithFormat:@"%@%@", BaseAPIURL, url];
    } else {
        url = [NSString stringWithFormat:@"%@%@", BaseTicketURL, url];
    }
    
    NSLog(@"url --> %@", url);
    
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end
