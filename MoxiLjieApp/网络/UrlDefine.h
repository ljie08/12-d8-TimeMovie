//
//  UrlDefine.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h

//主URL
#define BaseAPIURL @"http://api-m.mtime.cn/"
#define BaseTicketURL @"https://ticket-api-m.mtime.cn/"

//地址
//https://api-m.mtime.cn/Showtime/HotCitiesByCinema.api
#define Location_PATH @"Showtime/HotCitiesByCinema.api"

//正在售票
//https://api-m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=290
#define OnShow_PATH @"PageSubArea/HotPlayMovies.api"

//正在热映
//https://api-m.mtime.cn/Showtime/LocationMovies.api?locationId=290
#define HotShow_PATH @"Showtime/LocationMovies.api"

//即将上映
//https://api-m.mtime.cn/Movie/MovieComingNew.api?locationId=290
#define ComingNew_PATH @"Movie/MovieComingNew.api"

//影片详情
//https://ticket-api-m.mtime.cn/movie/detail.api?locationId=290&movieId=125805
#define MovieDetail_PATH @"movie/detail.api"

//演职员表
//https://api-m.mtime.cn/Movie/MovieCreditsWithTypes.api?movieId=217896
#define Aoctor_PATH @"Movie/MovieCreditsWithTypes.api"

//人员详细信息
//https://ticket-api-m.mtime.cn/person/detail.api?personId=892908&cityId=290
#define PresonDetail_PATH @"person/detail.api"

//影片详情-短评
//https://ticket-api-m.mtime.cn/movie/hotComment.api?movieId=125805
#define HotComment_PATH @"movie/hotComment.api"

//短评列表
//https://api-m.mtime.cn/Showtime/HotMovieComments.api?pageIndex=1&movieId=217896
#define ShortComments_PATH @"Showtime/HotMovieComments.api"

//精选影评
//https://api-m.mtime.cn/Movie/HotLongComments.api?pageIndex=1&movieId=217896
#define LongComments_PATH @"Movie/HotLongComments.api"

//预告片
//https://api-m.mtime.cn/Movie/Video.api?pageIndex=1&movieId=217896
#define Video_PATH @"Movie/Video.api"

//剧照
//https://api-m.mtime.cn/Movie/ImageAll.api?movieId=217896
#define ImageAll_PATH @"Movie/ImageAll.api"


#endif /* UrlDefine_h */
