//
//  Actor.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/3.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Actor : NSObject

@property (nonatomic, copy) NSString *actorID;//
@property (nonatomic, copy) NSString *name;//
@property (nonatomic, copy) NSString *nameEn;//

#pragma mark - 详情
@property (nonatomic, copy) NSString *img;//
@property (nonatomic, copy) NSString *roleName;//

#pragma mark - 列表
@property (nonatomic, copy) NSString *image;//
@property (nonatomic, copy) NSString *personnate;//
@property (nonatomic, copy) NSString *personnateCn;//
@property (nonatomic, copy) NSString *personnateEn;//
@property (nonatomic, copy) NSString *roleCover;//


@end
