//
//  SYNewsTypeModel.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsTypeModel.h"

@implementation SYNewsTypeModel


/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"sub" : @"SYNewsTypeSubModel"};
}


@end
