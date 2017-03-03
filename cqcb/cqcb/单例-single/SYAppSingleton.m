//
//  SYAppSingleton.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYAppSingleton.h"

@implementation SYAppSingleton
singleton_implementation(SYAppSingleton)

-(NSString *)currentVersion{
    if (!_currentVersion) {
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        _currentVersion = infoDic[@"CFBundleShortVersionString"];
    }
    return _currentVersion;
}

@end
