//
//  CommentCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@end

@implementation CommentCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"CommentCell";
    CommentCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setHotCommentWithModel:(ShortComment *)model {
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:SmallPlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.nickname;
    self.timeLab.text = [LJUtil timeInterverlToDateStr:model.commentDate];
    self.scoreLab.text = [NSString stringWithFormat:@"%.1f分", [model.rating floatValue]];
    self.commentLab.text = model.content;
}

- (void)setShortCommentWithModel:(Comment *)model {
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.caimg] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = model.ca;
    self.timeLab.text = [LJUtil timeInterverlToDateStr:model.cd];
    self.scoreLab.text = [NSString stringWithFormat:@"%.1f分", [model.cr floatValue]];
    self.commentLab.text = model.ce;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:15].height;
    
    return height+60;
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
