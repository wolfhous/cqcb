//
//  SYVRSingleModel.h
//  cqcb
//
//  Created by 侯帅 on 2017/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYVRSingleModel : NSObject

/**
 id
 */
@property (nonatomic,copy)NSString *ID;
/** 视频地址*/
@property (nonatomic,copy)NSString *videourl;
/** 阅读量*/
@property (nonatomic,copy)NSString *asdfg;
/** 类型 egVR图片*/
@property (nonatomic,copy)NSString *titletype;
/** 评论数量*/
@property (nonatomic,copy)NSString *plnum;
/** 主图*/
@property (nonatomic,copy)NSString *titlepic;
/** 更多图片数量*/
@property (nonatomic,copy)NSString *morepicnum;
/** 时间*/
@property (nonatomic,copy)NSString *newstime;
/** 说明*/
@property (nonatomic,copy)NSString *smalltext;
/** 来源*/
@property (nonatomic,copy)NSString *befrom;
/** */
@property (nonatomic,copy)NSString *onclick;
/** 标题*/
@property (nonatomic,copy)NSString *title;
/** */
@property (nonatomic,copy)NSString *ftitle;
/** 是否为url*/
@property (nonatomic,copy)NSString *isurl;
/** <#Description#>*/
@property (nonatomic,copy)NSString *writer;
/** <#Description#>*/
@property (nonatomic,copy)NSString *titleurl;
@end
