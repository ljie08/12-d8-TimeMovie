//
//  TrailerViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface TrailerViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *trailerArr;

//获取预告片列表
- (void)getTrailerListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
