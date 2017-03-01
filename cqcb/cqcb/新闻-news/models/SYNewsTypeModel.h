//
//  SYNewsTypeModel.h
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  新闻类型分类

#import <Foundation/Foundation.h>

@interface SYNewsTypeModel : NSObject

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
 新闻列表接口中间拼接的 类型路径
 */
@property (nonatomic, copy) NSString *classpath;
/**
 类型说明
 */
@property (nonatomic, copy) NSString *subscribe;
/**
 类型其他？
 */
@property (nonatomic, copy) NSString *subscribetag;

/**
 子分类-字典
 */
@property (nonatomic, copy) NSDictionary *sub;


@end
/*
 subscribetag : ,
	classpath : /hot/,
	classid : 2,
	classimg : ,
	classname : 重庆,
	sub : [
	{
	classid : 0,
	classname : 找公厕,
	classpath : http://www.cqsz12319.com/gwx/mobile/toilet,
	classimg : /images/toilet.png,
	showtype : 外链
 },
	{
	classid : 0,
	classname : 停车位,
	classpath : http://www.cqsz12319.com/gwx/mobile/park,
	classimg : /images/park.png,
	showtype : 外链
 }
 ],
	subscribe : 强制订阅
 
 */
