//
//  SYNewsTitleBtn.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsTitleBtn.h"

@implementation SYNewsTitleBtn

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:HSMainColor forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        
        
    }
    return self;
}



@end
