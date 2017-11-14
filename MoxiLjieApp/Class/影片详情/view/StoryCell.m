//
//  StoryCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "StoryCell.h"

@interface StoryCell()

@property (weak, nonatomic) IBOutlet UILabel *storyLab;


@end

@implementation StoryCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"StoryCell";
    StoryCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(MovieBasic *)model {
    self.storyLab.text = model.story;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:15].height;
    
    return height+45;
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
