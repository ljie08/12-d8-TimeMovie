//
//  StillsItemTableCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/2.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "StillsItemTableCell.h"
#import "StillsCell.h"

@interface StillsItemTableCell()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation StillsItemTableCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview withStillsArr:(NSArray *)stillsArr {
    static NSString *cellid = @"StillsItemTableCell";
    StillsItemTableCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"StillsItemTableCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.stillsArr = [NSArray arrayWithArray:stillsArr];
    
    return cell;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.itemSize = CGSizeMake(110, 110);
    
    //    CGFloat width;
    //    if (self.stillsArr.count > 0) {
    //        width = Screen_Width;
    //    } else {
    //        width = 115*self.stillsArr.count;
    //    }
    self.stillsCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, 110) collectionViewLayout:flow];
    self.stillsCollectionview.backgroundColor = [UIColor clearColor];
    
    self.stillsCollectionview.delegate = self;
    self.stillsCollectionview.dataSource = self;
    self.stillsCollectionview.showsHorizontalScrollIndicator = NO;
    [self.stillsCollectionview registerNib:[UINib nibWithNibName:@"StillsCell" bundle:nil] forCellWithReuseIdentifier:@"StillsCell"];
    [self.stillsCollectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"moreStills"];
    
    [self.contentView addSubview:self.stillsCollectionview];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stillsArr.count;
//    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.stillsArr.count) {
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moreStills" forIndexPath:indexPath];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, 35, 30)];
//        label.text = @"全部";
//        label.font = FontSize(15);
//        label.textColor = FontColor;
//        [cell.contentView addSubview:label];
//        
//        UIImageView *more = [[UIImageView alloc] initWithFrame:CGRectMake(60, 47, 12, 18)];
//        more.image = [UIImage imageNamed:@"black_you"];
//        [cell.contentView addSubview:more];
//        
//        return cell;
//    }
    StillsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StillsCell" forIndexPath:indexPath];
    if (self.stillsArr.count) {
        [cell setDetailDataWithModel:self.stillsArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.stillsArr.count+1) {
        if ([self.delegate respondsToSelector:@selector(gotoStillsVc)]) {
            [self.delegate gotoStillsVc];
        }
//    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
