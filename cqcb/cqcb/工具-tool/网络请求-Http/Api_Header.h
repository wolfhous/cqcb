//
//  Api_Header.h
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#ifndef Api_Header_h
#define Api_Header_h


//==========新闻分类  新闻类型===========
#define api_newsTypes @"https://www.cqcb.com/newsclasslist.html"

//==========新闻分类  新闻类型===========
//#define api_newsList(classpath) [NSString stringWithFormat:@"https://www.cqcb.com%@index.json",classpath]
#define api_newsList(classpath,pageindex) pageindex < 2?[NSString stringWithFormat:@"https://www.cqcb.com%@index.json",classpath] : [NSString stringWithFormat:@"https://www.cqcb.com%@index_%ld.json",classpath,pageindex]
//==========新闻广告===========timer=1488380130.526970
#define api_newsAD(classid) [NSString stringWithFormat:@"https://www.cqcb.com/d/js/class/class%@_firstnews.js",classid]



//==========上游号新闻==========
#define api_dyh @"https://www.cqcb.com/dyh/index.json"
//==========上游号”广告“appkey=89e4bb773e5ac2fa16cc2c7b3e3577b0&enews=getuserdyh&udid=09a3f59a2bdd379a0ecae470898ae2bc
#define api_getUserDyh @"https://www.cqcb.com/e/member/getUserDyh.php"


//==========VR==========

#define api_vrList(pageindex) pageindex < 2?@"https://www.cqcb.com/vision/vr/index.json" : [NSString stringWithFormat:@"https://www.cqcb.com/vision/vr/index_%ld.json",pageindex]



//==========对话==========
#define api_dialoggue @"https://www.cqcb.com/interlocution/recommendation/index.json"


//==========活动==========
#define api_activityList(pageindex) pageindex < 2?@"https://www.cqcb.com/activity/index.json" : [NSString stringWithFormat:@"https://www.cqcb.com/activity/index_%ld.json",pageindex]



#endif /* Api_Header_h */
