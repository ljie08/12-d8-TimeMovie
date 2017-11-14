//
//  ActorCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ActorCell.h"

@interface ActorCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *enNameLab;
@property (weak, nonatomic) IBOutlet UILabel *actorLab;

@end

@implementation ActorCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"ActorCell";
    ActorCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ActorCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(Actor *)model {
    [self.iconImg setImage:[LJUtil cutPicWithPicUrl:model.image bigOrSmall:0.1 picLocationType:0]];
    
    self.nameLab.text = model.name;
    self.enNameLab.text = model.nameEn;
    self.actorLab.text = model.personnate;
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
