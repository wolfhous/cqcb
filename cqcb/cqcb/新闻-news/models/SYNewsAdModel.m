//
//  SYNewsAdModel.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsAdModel.h"

@implementation SYNewsAdModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}
-(NSString *)titlepic{
    _titlepic = [HSManager hs_getCorrectURL:_titlepic];
    
    return _titlepic;
}
-(NSString *)titleurl{
    _titleurl = [HSManager hs_getCorrectURL:_titleurl];
    
    return _titleurl;
}
@end
