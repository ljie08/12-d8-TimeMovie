//
//  ActorViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface ActorViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *actorArr;

//获取演员列表
- (void)getActorListWithMovieID:(NSString *)movieID success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
