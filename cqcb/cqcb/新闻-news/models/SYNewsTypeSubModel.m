//
//  SYNewsTypeSubModel.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsTypeSubModel.h"

@implementation SYNewsTypeSubModel
-(NSString *)classimg{
    _classimg = [HSManager hs_getCorrectURL:_classimg];
    
    return _classimg;
}


@end
