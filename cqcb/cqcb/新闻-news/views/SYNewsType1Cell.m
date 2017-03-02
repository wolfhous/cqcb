//
//  SYNewsType1Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType1Cell.h"
#import "UILabel+HSLabel.h"


@interface SYNewsType1Cell()

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 右侧图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

/**
 阅读量
 */
@property (weak, nonatomic) IBOutlet UILabel *redeNumLabel;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 右侧图片宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewWidth;

/**
 右侧图片高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageViewHeight;

@end


@implementation SYNewsType1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rightImageViewWidth.constant = (SCREEN_WIDTH - 40)/3;
    self.rightImageViewHeight.constant = (SCREEN_WIDTH - 40)/3 * 3/4;
    [self.redeNumLabel hs_setRoundRadius:4];
    
}



-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.title;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.smalltitlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    self.redeNumLabel.text = [NSString stringWithFormat:@"%@ 阅读",model.asdfg];
    self.timeLabel.text = model.newstime;
    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.rightImageView.frame) + 15;
    
}


@end
