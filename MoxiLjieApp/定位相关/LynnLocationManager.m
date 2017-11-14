//
//  LynnLocationManager.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/31.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "LynnLocationManager.h"


@implementation LynnLocationManager

+ (instancetype)shareInstance {
    static LynnLocationManager *myManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myManager = [[LynnLocationManager alloc] init];
    });
    return myManager;
}



@end
