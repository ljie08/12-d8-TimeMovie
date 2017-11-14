//
//  LynnLocationManager.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/10/31.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LynnLocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *localCity;//定位到的城市

+ (instancetype)shareInstance;
- (void)startLocation;

@end
