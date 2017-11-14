//
//  MainHomeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MainHomeCell.h"

@interface MainHomeCell()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *newmovieLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *wantedLab;
@property (weak, nonatomic) IBOutlet UIView *newview;

@end

@implementation MainHomeCell

- (void)setDataWithModel:(Movie *)model {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:SmallPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.newview.hidden = !model.isNew;
    self.nameLab.text = model.titleCn;
    self.wantedLab.text = [NSString stringWithFormat:@"%@人想看", model.wantedCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
