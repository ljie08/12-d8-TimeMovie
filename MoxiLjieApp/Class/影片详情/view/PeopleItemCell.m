//
//  PeopleItemCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PeopleItemCell.h"

@interface PeopleItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *chNameLab;//中文名
@property (weak, nonatomic) IBOutlet UILabel *enNameLab;//英文名
@property (weak, nonatomic) IBOutlet UILabel *roleNameLab;//饰演角色

@end

@implementation PeopleItemCell

- (void)setDataWithModel:(Actor *)model {
    UIImage *headimg = [LJUtil cutPicWithPicUrl:model.img bigOrSmall:0.1 picLocationType:0];
    if (headimg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headImg.image = headimg;
        });
    }
    
    self.chNameLab.text = model.name;
    self.enNameLab.text = model.nameEn;
    self.roleNameLab.text = [NSString stringWithFormat:@"饰 %@", model.roleName];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
