//
//  StillsViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface StillsViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *stillsArr;

//获取剧照列表
- (void)getStillsListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
