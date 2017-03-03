//
//  SYDialogueCell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/3.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYDialogueCell.h"
#import "UILabel+HSLabel.h"

@interface SYDialogueCell()
/** 主图*/
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;
/** 主图高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBigH;
/** 用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUserPhoto;
/** 名字|类型*/
@property (weak, nonatomic) IBOutlet UILabel *expertNameAndTypeLabel;

/** 简介label*/
@property (weak, nonatomic) IBOutlet UILabel *classIntroLabel;

/** 交流量*/
@property (weak, nonatomic) IBOutlet UILabel *infosNumLabel;

/** 目前的状态*/
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation SYDialogueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置图片高度  21：9
    self.imageViewBigH.constant = SCREEN_WIDTH *9/21;
    
    self.imageViewUserPhoto.layer.masksToBounds = YES;
    self.imageViewUserPhoto.layer.cornerRadius = self.imageViewUserPhoto.xmg_height/2;
    self.imageViewUserPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageViewUserPhoto.layer.borderWidth = 2.0;
    
    
}

-(void)setFrame:(CGRect)frame{
    //重写cell的setFrame 实现cell间隔效果（tableView不是group的类型情况下）
    frame.size.height -= 20;
    [super setFrame:frame];
}

-(void)setModel:(SYDialogueSingleModel *)model{
    _model = model;
    
    //主图
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:[HSManager hs_getCorrectURL:model.expertpic]] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    //用户头像
    [self.imageViewUserPhoto sd_setImageWithURL:[NSURL URLWithString:[HSManager hs_getCorrectURL:model.expertheadimgurl]] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    //名字和类型
    self.expertNameAndTypeLabel.text = [NSString stringWithFormat:@"%@ | %@",model.expertname,model.experttype];
    //简介简介
    self.classIntroLabel.text = model.classintro;
    //状态
    self.statusLabel.text = model.status;
    if ([model.status isEqualToString:@"进行中"]) {
        [self.statusLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:HSMainColor bgColor:nil textColor:HSMainColor fontSize:13.0];
    }else{
        [self.statusLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:[UIColor grayColor] bgColor:nil textColor:[UIColor grayColor] fontSize:13.0];
    }
    
    //对话数量
    self.infosNumLabel.text = model.infos;
    
    [self layoutIfNeeded];
    _model.cellHeight = CGRectGetMaxY(self.statusLabel.frame) + 10 + 20;
}



- (IBAction)clickDialogueCellShareBtn:(id)sender {
    DLogFunc
}


@end

















