//
//  PeopleCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PeopleCell.h"
#import "PeopleItemCell.h"

@interface PeopleCell()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation PeopleCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview withPeopleArr:(NSArray *)peopleArr {
    static NSString *cellid = @"PeopleCell";
    PeopleCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PeopleCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.peopleArr = [NSArray arrayWithArray:peopleArr];
    
    return cell;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(115, 180);
    
//    CGFloat width;
//    if (self.peopleArr.count > 0) {
//        width = Screen_Width;
//    } else {
//        width = 115*self.peopleArr.count;
//    }
    self.peopleCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, Screen_Width, 180) collectionViewLayout:flow];
    self.peopleCollectionview.backgroundColor = [UIColor clearColor];
    
    self.peopleCollectionview.delegate = self;
    self.peopleCollectionview.dataSource = self;
    self.peopleCollectionview.showsHorizontalScrollIndicator = NO;
    [self.peopleCollectionview registerNib:[UINib nibWithNibName:@"PeopleItemCell" bundle:nil] forCellWithReuseIdentifier:@"PeopleItemCell"];
    [self.peopleCollectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"more"];
    
    [self.contentView addSubview:self.peopleCollectionview];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.peopleArr.count;
//    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.peopleArr.count) {
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"more" forIndexPath:indexPath];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 35, 30)];
//        label.text = @"全部";
//        label.font = FontSize(15);
//        label.textColor = FontColor;
//        [cell.contentView addSubview:label];
//
//        UIImageView *more = [[UIImageView alloc] initWithFrame:CGRectMake(60, 67, 12, 18)];
//        more.image = [UIImage imageNamed:@"black_you"];
//        [cell.contentView addSubview:more];
//
//        return cell;
//    }
    PeopleItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PeopleItemCell" forIndexPath:indexPath];
    if (self.peopleArr.count) {
        [cell setDataWithModel:self.peopleArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 4) {
        if ([self.delegate respondsToSelector:@selector(gotoActorVc)]) {
            [self.delegate gotoActorVc];
        }
//    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 50, 20)];
    label.text = @"演职员";
    label.textColor = FontColor;
    label.font = FontSize(15);
    [self.contentView addSubview:label];
    
    UILabel *noLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Screen_Width, 180)];
    noLab.text = @"暂无";
    noLab.textColor = FontColor;
    noLab.font = FontSize(15);
    noLab.hidden = YES;
    noLab.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:noLab];
    if (self.peopleArr.count) {
        noLab.hidden = YES;
    } else {
        noLab.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
