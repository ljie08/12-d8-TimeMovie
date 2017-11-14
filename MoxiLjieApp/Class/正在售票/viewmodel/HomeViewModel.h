//
//  HomeViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/31.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *movieArr;

//获取城市
- (void)getCitySuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

//- (NSString *)getLocalCityIDWithCityName:(NSString *)cityName;

//获取电影
- (void)getMovieWithSuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
