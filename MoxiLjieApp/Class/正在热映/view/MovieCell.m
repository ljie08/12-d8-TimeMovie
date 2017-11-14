//
//  MovieCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MovieCell.h"

@interface MovieCell()

@property (weak, nonatomic) IBOutlet UIImageView *movieImg;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLab;
@property (weak, nonatomic) IBOutlet UILabel *maxLab;
@property (weak, nonatomic) IBOutlet UILabel *dLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLab;
@property (weak, nonatomic) IBOutlet UILabel *actorLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end

@implementation MovieCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"MovieCell";
    MovieCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setHotDataWithModel:(HotMovie *)model {
    [self.movieImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.movieNameLab.text = model.tCn;
    self.maxLab.hidden = !model.isIMAX;
    self.dLabel.hidden = !model.is3D;
    self.introLab.text = model.commonSpecial;
    self.actorLab.text = [NSString stringWithFormat:@"%@/%@", model.aN1, model.aN2];
    self.typeLab.text = model.movieType;
}

- (void)setNewDataWithModel:(NewMovie *)model {
    [self.movieImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.movieNameLab.text = model.title;
    self.maxLab.hidden = YES;
    self.dLabel.hidden = YES;
    self.introLab.text = model.releaseDate;
    if (model.actor1.length && model.actor2.length) {
        self.actorLab.text = [NSString stringWithFormat:@"%@ / %@", model.actor1, model.actor2];
    } else {
        if (!model.actor1.length && !model.actor2.length) {
            self.actorLab.text = @"暂无演员数据";
        } else {
            self.actorLab.text = [NSString stringWithFormat:@"%@%@", model.actor1, model.actor2];
        }
    }
    self.typeLab.text = model.type;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dLabel.layer.borderColor = RedColor.CGColor;
    self.maxLab.layer.borderColor = RedColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
