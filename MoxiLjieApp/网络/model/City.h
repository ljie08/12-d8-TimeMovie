//
//  City.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *n;//城市名称
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *pinyinFull;//全拼
@property (nonatomic, copy) NSString *pinyinShort;//简拼

@end
