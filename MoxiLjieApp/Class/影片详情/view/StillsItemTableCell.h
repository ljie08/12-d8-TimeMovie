//
//  StillsItemTableCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/2.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StillsItemDelegate <NSObject>

- (void)gotoStillsVc;

@end

@interface StillsItemTableCell : UITableViewCell

@property (nonatomic, assign) id <StillsItemDelegate> delegate;

+ (instancetype)myCellWithTableview:(UITableView *)tableview withStillsArr:(NSArray *)peopleArr;

@property (nonatomic, strong) UICollectionView *stillsCollectionview;

@property (nonatomic, strong) NSArray *stillsArr;

//collectionview相关
- (void)setCollectionviewLayout;

@end
