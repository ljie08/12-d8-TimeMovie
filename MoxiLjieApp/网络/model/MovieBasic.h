//
//  MovieBasic.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/3.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieBasic : NSObject

@property (nonatomic, strong) NSArray<Actor *> *actors;
@property (nonatomic, strong) NSDictionary *stageImg;

@property (nonatomic, copy) NSString *commentSpecial;//
@property (nonatomic, copy) NSString *hotRanking;//
@property (nonatomic, copy) NSString *img;//
@property (nonatomic, assign) BOOL is3D;//
@property (nonatomic, assign) BOOL isDMAX;//
@property (nonatomic, assign) BOOL isEggHunt;//
@property (nonatomic, assign) BOOL isFilter;//
@property (nonatomic, assign) BOOL isIMAX;//
@property (nonatomic, assign) BOOL isIMAX3D;//
@property (nonatomic, assign) BOOL isTicket;//
@property (nonatomic, copy) NSString *mins;//

@property (nonatomic, copy) NSString *movieId;//
@property (nonatomic, copy) NSString *name;//
@property (nonatomic, copy) NSString *nameEn;//
@property (nonatomic, copy) NSString *overallRating;//
@property (nonatomic, copy) NSString *personCount;//
@property (nonatomic, copy) NSString *releaseArea;//
@property (nonatomic, copy) NSString *releaseDate;//
@property (nonatomic, copy) NSString *showCinemaCount;//
@property (nonatomic, copy) NSString *showDay;//
@property (nonatomic, copy) NSString *showtimeCount;//
@property (nonatomic, copy) NSString *story;//
@property (nonatomic, strong) NSArray *type;//
@property (nonatomic, copy) NSString *url;//

@property (nonatomic, strong) MovieBoxOffice *boxOffice;//

@end
