//
//  SYDialogueSingleModel.h
//  cqcb
//
//  Created by 壹号商圈 on 17/3/3.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDialogueSingleModel : NSObject

/** 已结束*/
@property (nonatomic,copy)NSString *status;
/** 路径*/
@property (nonatomic,copy)NSString *classpath;
/** id*/
@property (nonatomic,copy)NSString *classid;
/** 简介*/
@property (nonatomic,copy)NSString *classintro;
/** 类型标题*/
@property (nonatomic,copy)NSString *classname;
/** 联系人*/
@property (nonatomic,copy)NSString *expertname;
/** 2016年重庆高考理科第一名*/
@property (nonatomic,copy)NSString *experttype;
/** /d/file/p/2016-06-29/fe7bf627ef8bbe06559d9be3532cc3c0.jpg*/
@property (nonatomic,copy)NSString *expertheadimgurl;
/** 21*/
@property (nonatomic,copy)NSString *infos;
/** 详细介绍*/
@property (nonatomic,copy)NSString *expertmemo;
/** /d/file/p/2016-06-29/bfddd13a1b172b0a9d0d59eb4d67ba34.jpg*/
@property (nonatomic,copy)NSString *expertpic;





//===========自定义添加数据==============

/** cell 的高度*/
@property (nonatomic,assign)CGFloat cellHeight;

@end



/*
     status : 已结束,
	classpath : /interlocution/recommendation/zywdh/,
	classid : 159,
	classintro : 我是重庆高考理科第一名郑雅文，您有学习方面的问题，可问我！,
	classname : 郑雅文对话,
	expertname : 郑雅文,
	experttype : 2016年重庆高考理科第一名,
	expertheadimgurl : /d/file/p/2016-06-29/fe7bf627ef8bbe06559d9be3532cc3c0.jpg,
	infos : 21,
	expertmemo : 郑雅文，重庆一中高三（9）班毕业，2016年重庆高考理科第一名（语文131分，数学150分，外语147分，理综292分，总分720分）。生日：1998年1月。爱好：钢琴、阅读、旅游。,
	expertpic : /d/file/p/2016-06-29/bfddd13a1b172b0a9d0d59eb4d67ba34.jpg
*/


















