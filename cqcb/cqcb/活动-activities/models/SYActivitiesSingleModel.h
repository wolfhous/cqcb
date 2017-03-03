//
//  SYActivitiesSingleModel.h
//  cqcb
//
//  Created by 壹号商圈 on 17/3/3.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYActivitiesSingleModel : NSObject

/** 开始时间*/
@property (nonatomic,copy)NSString *starttime;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *isurl;
/** id*/
@property (nonatomic,copy)NSString *ID;
/** 是都头条*/
@property (nonatomic,copy)NSString *istop;
/** 标题*/
@property (nonatomic,copy)NSString *title;
/** 主图地址*/
@property (nonatomic,copy)NSString *titlepic;
/** 新闻创建时间*/
@property (nonatomic,copy)NSString *newstime;
/** 结束时间*/
@property (nonatomic,copy)NSString *endtime;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *smalltext;
/** 查看数量*/
@property (nonatomic,copy)NSString *onclick;
/** 连接地址*/
@property (nonatomic,copy)NSString *titleurl;


//===========自定义添加数据==============

/** cell 的高度*/
@property (nonatomic,assign)CGFloat cellHeight;



@end

/*
     starttime : 2016-12-22 00:00,
	isurl : 1,
	id : 147,
	istop : 1,
	title : 融创中国·2016重庆经济年度人物评选,
	titlepic : http://image.cqcb.com/d/file/activity/2017-02-16/3c06e213ec5d39940a41aae8b1aea289.jpg,
	newstime : 2016-12-22 15:14:43,
	endtime : 2017-02-28 23:59,
	smalltext : ,
	onclick : 3197010,
	titleurl : /vote/jjrw2016/index1.php?from=app
 */




