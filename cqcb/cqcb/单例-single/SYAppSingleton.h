//
//  SYAppSingleton.h
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface SYAppSingleton : NSObject
singleton_interface(SYAppSingleton)


/**
 当前版本号
 */
@property (nonatomic,strong)NSString *currentVersion;

@end
