//
//  ShortComment.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/3.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShortComment : NSObject

@property (nonatomic, copy) NSString *commentDate;//
@property (nonatomic, copy) NSString *commentId;//
@property (nonatomic, copy) NSString *content;//
@property (nonatomic, copy) NSString *headImg;//
@property (nonatomic, copy) NSString *img;//
@property (nonatomic, assign) BOOL isHot;//
@property (nonatomic, assign) BOOL isPraise;//
@property (nonatomic, copy) NSString *locationName;//
@property (nonatomic, copy) NSString *nickname;//
@property (nonatomic, copy) NSString *praiseCount;//
@property (nonatomic, copy) NSString *rating;//
@property (nonatomic, copy) NSString *replyCount;//

@end
