//
//  SYActivitiesCell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/3.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYActivitiesCell.h"
#import "UILabel+HSLabel.h"
@interface SYActivitiesCell()
/** 主图*/
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBigH;

/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 点击数量*/
@property (weak, nonatomic) IBOutlet UILabel *onClickNumLabel;
/** 状态*/
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation SYActivitiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置图片高度  16：9
    self.imageViewBigH.constant = SCREEN_WIDTH *9/16;
}


-(void)setFrame:(CGRect)frame{
    //重写cell的setFrame 实现cell间隔效果（tableView不是group的类型情况下）
    frame.size.height -= 20;
    [super setFrame:frame];
}

-(void)setModel:(SYActivitiesSingleModel *)model{
    _model = model;
    
    //主图
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:[HSManager hs_getCorrectURL:model.titlepic]] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    //标题
    self.titleLabel.text = model.title;
    //点击数量
    self.onClickNumLabel.text = model.onclick;
    //状态
    [self starTime:model.starttime endTime:model.endtime];

    
    
    [self layoutIfNeeded];
    _model.cellHeight = CGRectGetMaxY(self.statusLabel.frame)+10 +20;
}


- (IBAction)clickActCellShareBtn:(id)sender {
    DLogFunc
}
//判断时间
-(void)starTime:(NSString *)starTime endTime:(NSString *)endTime{
    
    //获取当前时间 的时间戳
    NSString *curt = [HSManager hs_getTimeStamp];
    //获取开始时间时间戳
    NSString *star = [HSManager hs_getTimeStampForTimeStr:starTime withFormate:@"yyyy-MM-dd HH:mm"];
    //获取结束时间时间戳
    NSString *end = [HSManager hs_getTimeStampForTimeStr:endTime withFormate:@"yyyy-MM-dd HH:mm"];
    
    
    
    if (star.integerValue <curt.integerValue && curt.integerValue < end.integerValue) {
        self.statusLabel.text = @"进行中";
        [self.statusLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:HSMainColor bgColor:nil textColor:HSMainColor fontSize:13.0];
    }else if (curt.integerValue < star.integerValue || starTime.length < 1){//添加判断有无 开始时间，若无开始时间，就设置 预告中
        self.statusLabel.text = @"预告中";
        [self.statusLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:[UIColor greenColor] bgColor:nil textColor:[UIColor greenColor] fontSize:13.0];
    }else if (end.integerValue < curt.integerValue){
        self.statusLabel.text = @"已结束";
        [self.statusLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:[UIColor grayColor] bgColor:nil textColor:[UIColor grayColor] fontSize:13.0];
    }else{
        DLog(@"判断有误");
    }
    
}

@end
