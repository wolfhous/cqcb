//
//  SYNewsType5Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType5Cell.h"
#import "UILabel+HSLabel.h"
#import "UIButton+HSButton.h"
@interface SYNewsType5Cell()

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 大图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;

/**
 阅读量
 */
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 是否原创等等
 */
@property (weak, nonatomic) IBOutlet UILabel *titleTypeLabel;

/**
 大图高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftHeight;

/**
 图片数量按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *imgNumBtn;

/**
 小图 只做隐藏和显示
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall;


@end



@implementation SYNewsType5Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.readNumLabel hs_setRoundRadius:4];
    
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    self.imageViewLeftHeight.constant = (SCREEN_WIDTH - 30) *9 /16;
    
    [self.imgNumBtn hs_setRoundRadius:self.imgNumBtn.xmg_height/2];
    [self.titleTypeLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:HSMainColor bgColor:[UIColor whiteColor] textColor:HSMainColor fontSize:12];
    
}

-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.title;
    
    self.readNumLabel.text = [NSString stringWithFormat:@"%@ 阅读",model.asdfg];
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:model.titlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    self.timeLabel.text = model.newstime;
    //判断是否显示 图片数量 等
    
    if (model.imgnum.integerValue > 1) {
        self.imgNumBtn.hidden = NO;
        self.imageViewSmall.hidden = NO;
        [self.imgNumBtn setTitle:[NSString stringWithFormat:@"%@图",model.imgnum] forState:UIControlStateNormal];
    }else{
        self.imgNumBtn.hidden = YES;
        self.imageViewSmall.hidden = YES;
    }
    
    
    
    //判断是否显示 原创 等
    if ([model.titletype isEqualToString:@"无"]) {
        self.titleTypeLabel.hidden = YES;
    }else{
        self.titleTypeLabel.text = model.titletype;
    }
    
    
    //强制布局
    [self layoutIfNeeded];
    _model.cellHeight = CGRectGetMaxY(self.readNumLabel.frame) + 10;
}


@end
