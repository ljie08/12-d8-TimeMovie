//
//  BoxOfficeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BoxOfficeCell.h"

@interface BoxOfficeCell()

@property (weak, nonatomic) IBOutlet UILabel *rankingLab;//票房排名
@property (weak, nonatomic) IBOutlet UILabel *todayLab;//今日实时
@property (weak, nonatomic) IBOutlet UILabel *totalLab;//累计票房

@end

@implementation BoxOfficeCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"BoxOfficeCell";
    BoxOfficeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BoxOfficeCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(MovieBoxOffice *)model {
    self.rankingLab.text = model.ranking;
    self.todayLab.text = model.todayBoxDes.length?model.todayBoxDes:@"暂无";
    self.totalLab.text = model.totalBoxDes.length?model.totalBoxDes:@"暂无";
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
