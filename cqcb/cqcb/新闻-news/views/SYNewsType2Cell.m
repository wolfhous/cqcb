//
//  SYNewsType2Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType2Cell.h"
#import "UILabel+HSLabel.h"


@interface SYNewsType2Cell()

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


/**
 第一张图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

/**
 第二张图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

/**
 第三张图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

/**
 阅读数量
 */
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;

/**
 时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 图片高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftHeight;

@end







@implementation SYNewsType2Cell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    self.imageViewLeftHeight.constant = (SCREEN_WIDTH - 40)/3 * 3/4;
    [self.readNumLabel hs_setRoundRadius:4];
}
-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.title;
    
    
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.smalltitlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:model.titlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:model.smalltitlepic3] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    
    self.readNumLabel.text = [NSString stringWithFormat:@"%@ 阅读",model.asdfg];
    self.timeLabel.text = model.newstime;
    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.timeLabel.frame) + 10;
    
}

@end
