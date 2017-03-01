//
//  SYRefreshFooter.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYRefreshFooter.h"

@implementation SYRefreshFooter

-(void)prepare{
    [super prepare];
    //一些其他属性设置
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.automaticallyChangeAlpha = YES;
}

@end
