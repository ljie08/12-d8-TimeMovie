//
//  Movie.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/3.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, copy) NSString *actorName1;//
@property (nonatomic, copy) NSString *actorName2;//
@property (nonatomic, copy) NSString *btnText;//
@property (nonatomic, copy) NSString *commonSpecial;//
@property (nonatomic, copy) NSString *directorName;//
@property (nonatomic, copy) NSString *img;//
@property (nonatomic, assign) BOOL is3D;//
@property (nonatomic, assign) BOOL isDMAX;//
@property (nonatomic, assign) BOOL isFilter;//
@property (nonatomic, assign) BOOL isHot;//
@property (nonatomic, assign) BOOL isIMAX;//
@property (nonatomic, assign) BOOL isIMAX3D;//
@property (nonatomic, assign) BOOL isNew;//
@property (nonatomic, assign) int length;//
@property (nonatomic, copy) NSString *movieId;//
@property (nonatomic, copy) NSString *nearestShowTime;//
@property (nonatomic, assign) BOOL preferentialFlag;//
@property (nonatomic, copy) NSString *rDay;//
@property (nonatomic, copy) NSString *rMonth;//
@property (nonatomic, copy) NSString *rYear;//
@property (nonatomic, copy) NSString *ratingFinal;//
@property (nonatomic, copy) NSString *titleCn;//
@property (nonatomic, copy) NSString *titleEn;//
@property (nonatomic, copy) NSString *type;//
@property (nonatomic, copy) NSString *wantedCount;//

@end
