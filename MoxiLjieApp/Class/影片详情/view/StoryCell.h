//
//  StoryCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;
- (void)setDataWithModel:(MovieBasic *)model;
+ (CGFloat)cellHeightWithString:(NSString *)string;

@end
