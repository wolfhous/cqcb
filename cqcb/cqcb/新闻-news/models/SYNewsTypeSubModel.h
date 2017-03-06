//
//  SYNewsTypeSubModel.h
//  cqcb
//
//  Created by 壹号商圈 on 17/3/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  新闻分类 子分类模型

#import <Foundation/Foundation.h>

@interface SYNewsTypeSubModel : NSObject
/**
 新闻广告 类型id
 */
@property (nonatomic, copy) NSString *classid;
/**
 类型名字
 */
@property (nonatomic, copy) NSString *classname;
/**
 类型图片
 */
@property (nonatomic, copy) NSString *classimg;
/**
 点击链接
 */
@property (nonatomic, copy) NSString *classpath;
/**
 类型说明
 */
@property (nonatomic, copy) NSString *showtype;
@end
