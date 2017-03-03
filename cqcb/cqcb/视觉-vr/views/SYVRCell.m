//
//  SYVRCell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/3.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYVRCell.h"



@interface SYVRCell()

/**
 主图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewVR;

/** 一些文字说明*/
@property (weak, nonatomic) IBOutlet UILabel *smallTextLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 查看数量*/
@property (weak, nonatomic) IBOutlet UILabel *lookNumLabel;
/** 图片高度 只在aweakFromNib里面设置即可*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewH;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation SYVRCell



- (void)awakeFromNib {
    [super awakeFromNib];
    //设置图片高度  21：9
    self.imageViewH.constant = SCREEN_WIDTH *9/21;
    
}

-(void)setFrame:(CGRect)frame{
    //重写cell的setFrame 实现cell间隔效果（tableView不是group的类型情况下）
    frame.size.height -= 20;
    [super setFrame:frame];
}
//赋值数据
-(void)setModel:(SYVRSingleModel *)model{
    _model = model;
    //主图
    [self.imageViewVR sd_setImageWithURL:[NSURL URLWithString:model.titlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    //文字描述
    self.smallTextLabel.text = model.smalltext;
    //时间
    self.timeLabel.text = model.newstime;
    //查看数量
    self.lookNumLabel.text = model.asdfg;
    
    self.titleLabel.text = model.title;
    
    //强制布局
    [self layoutIfNeeded];
    //设置cell高度 多余的20为 self.frame.size.height -= 20;
    _model.cellHeight = CGRectGetMaxY(self.lookNumLabel.frame) + 10 + 20;
}




#pragma mark - 点击分享按钮
- (IBAction)cliclVrCellShareBtn:(id)sender {
    DLogFunc
}


@end
