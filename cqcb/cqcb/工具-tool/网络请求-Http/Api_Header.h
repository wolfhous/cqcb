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
#define api_newsList(classpath) [NSString stringWithFormat:@"https://www.cqcb.com%@index.json",classpath]

//==========新闻分类  新闻类型===========timer=1488380130.526970
#define api_newsAD(classid) [NSString stringWithFormat:@"https://www.cqcb.com/d/js/class/class%@_firstnews.js",classid]



//==========上游号新闻==========
#define api_dyh @"https://www.cqcb.com/dyh/index.json"
//==========上游号”广告“appkey=89e4bb773e5ac2fa16cc2c7b3e3577b0&enews=getuserdyh&udid=09a3f59a2bdd379a0ecae470898ae2bc
#define api_getUserDyh @"https://www.cqcb.com/e/member/getUserDyh.php"





#endif /* Api_Header_h */
