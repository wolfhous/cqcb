//
//  SYNewsHeaderViewSubBtn.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsHeaderViewSubBtn.h"

@implementation SYNewsHeaderViewSubBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//重写layoutSubviews 布局内部子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = 30;//图片宽度
    self.imageView.frame = CGRectMake((self.xmg_width - w)/2, 6, w, w);
    self.titleLabel.frame = CGRectMake(0, self.imageView.xmg_bottom, self.xmg_width, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:11];
//    self.imageView.backgroundColor = HSRandomColor;
//    self.titleLabel.backgroundColor = HSRandomColor;
    
    
}



@end
