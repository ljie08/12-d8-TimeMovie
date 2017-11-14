//
//  MovieHeaderCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieHeaderCell.h"

@interface MovieHeaderCell()

@property (weak, nonatomic) IBOutlet UIImageView *baImg;

@property (weak, nonatomic) IBOutlet UIImageView *movieImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *enNameLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *introLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation MovieHeaderCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"MovieHeaderCell";
    MovieHeaderCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MovieHeaderCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(MovieBasic *)model {
    [self.baImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:SmallPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    [self.movieImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:SmallPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.name;
    self.enNameLab.text = model.nameEn;
    self.scoreLab.text = [model.overallRating floatValue] < 0 ? @"" : [NSString stringWithFormat:@"%@", model.overallRating];
    self.scoreLab.hidden = [model.overallRating floatValue] < 0 ? YES : NO;
    self.timeLab.text = model.mins;
    NSString *typeStr;
    if (model.type.count) {
        for (int i = 0; i< model.type.count; i++) {
            typeStr = [typeStr stringByAppendingString:model.type[i]];
            if (i != model.type.count-1) {
                typeStr = [typeStr stringByAppendingString:@"/"];
            }
        }
    }
    self.typeLab.text = typeStr;
    NSString *showdate = [LJUtil timeInterverlToDateStr:model.showDay];
    self.dateLab.text = [NSString stringWithFormat:@"%@%@上映", showdate, model.releaseArea];
    self.introLab.text = model.commentSpecial;
    
}

//查看预告片
- (IBAction)lookTrailer:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(gotoTrailerVc)]) {
        [self.delegate gotoTrailerVc];
    }
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
