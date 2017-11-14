//
//  MovieHeaderCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MovieDetailDelegate <NSObject>

- (void)gotoTrailerVc;

@end

@interface MovieHeaderCell : UITableViewCell

@property (nonatomic, assign) id <MovieDetailDelegate> delegate;

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

- (void)setDataWithModel:(MovieBasic *)model;

@end
