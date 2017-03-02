//
//  SYNewsType4Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType4Cell.h"
#import "UILabel+HSLabel.h"

@interface SYNewsType4Cell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation SYNewsType4Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    [self.readNumLabel hs_setRoundRadius:4];
}

-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.title;
    
    self.readNumLabel.text = [NSString stringWithFormat:@"%@ 阅读",model.asdfg];
    
    self.timeLabel.text = model.newstime;
    //强制布局
    [self layoutIfNeeded];
    
    _model.cellHeight = CGRectGetMaxY(self.readNumLabel.frame) + 10;
}

@end
