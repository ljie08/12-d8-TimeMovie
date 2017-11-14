//
//  PeopleCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TotalActorDelegate <NSObject>

- (void)gotoActorVc;

@end

@interface PeopleCell : UITableViewCell

@property (nonatomic, assign) id <TotalActorDelegate> delegate;

+ (instancetype)myCellWithTableview:(UITableView *)tableview withPeopleArr:(NSArray *)peopleArr;

@property (nonatomic, strong) UICollectionView *peopleCollectionview;

@property (nonatomic, strong) NSArray *peopleArr;

//collectionview相关
- (void)setCollectionviewLayout;

@end
