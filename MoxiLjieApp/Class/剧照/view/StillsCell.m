//
//  StillsCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "StillsCell.h"

@interface StillsCell()

@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation StillsCell

- (void)setDetailDataWithModel:(Stills *)model {
    UIImage *picimg = [LJUtil cutPicWithPicUrl:model.imgUrl bigOrSmall:0.1 picLocationType:1];
    if (picimg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picView.image = picimg;
        });
    }
}

- (void)setStillDataWithModel:(Stills *)model {
    UIImage *picimg = [LJUtil cutPicWithPicUrl:model.image bigOrSmall:0.1 picLocationType:1];
    if (picimg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picView.image = picimg;
        });
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
