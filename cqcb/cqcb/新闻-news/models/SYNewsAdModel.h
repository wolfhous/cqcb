//
//  SYNewsAdModel.h
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  轮播图模型

#import <Foundation/Foundation.h>

@interface SYNewsAdModel : NSObject
/**
 ？？？
 */
@property (nonatomic, copy) NSString *buyfen;
/**
 图片地址
 */
@property (nonatomic, copy) NSString *titlepic;
/**
 id
 */
@property (nonatomic, copy) NSString *ID;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 标题说明
 */
@property (nonatomic, copy) NSString *titletype;
/**
 ？？
 */
@property (nonatomic, copy) NSString *video;
/**
 标题链接
 */
@property (nonatomic, copy) NSString *titleurl;
@end
