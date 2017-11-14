//
//  TrailerCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TrailerCell.h"

@interface TrailerCell()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation TrailerCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"TrailerCell";
    TrailerCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TrailerCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(Trailer *)model {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:BigPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.title;
    self.timeLab.text = [NSString stringWithFormat:@"片长：%@秒", model.length];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *img = [UIImage imageNamed:@"play"];
    img = [img imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    
    [self.playBtn setImage:img forState:UIControlStateNormal];
    [self.playBtn setTintColor:WhiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
