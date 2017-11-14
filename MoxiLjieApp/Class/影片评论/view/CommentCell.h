//
//  CommentCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/11/1.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview;

+ (CGFloat)cellHeightWithString:(NSString *)string;

- (void)setHotCommentWithModel:(ShortComment *)model;
- (void)setShortCommentWithModel:(Comment *)model;

@end
