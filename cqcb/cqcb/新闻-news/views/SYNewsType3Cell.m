//
//  SYNewsType3Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType3Cell.h"

@interface SYNewsType3Cell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftHeight;

@end


@implementation SYNewsType3Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    self.imageViewLeftHeight.constant = (SCREEN_WIDTH - 30) *9 /21;
}

-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:model.titlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    
    self.titleLabel.text = model.title;
    
    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.titleLabel.frame) + 10;
}


@end
