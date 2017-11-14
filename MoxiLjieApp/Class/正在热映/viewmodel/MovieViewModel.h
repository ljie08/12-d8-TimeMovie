//
//  MovieViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface MovieViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *hotArr;
@property (nonatomic, strong) NSMutableArray *newcomingArr;

//获取最热
- (void)getHotMovieWithSuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

//获取即将上映
- (void)getNewMovieWithSuccess:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
