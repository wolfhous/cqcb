//
//  HSManager.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HSManager : NSObject
/** 检测网络*/
+(void)hs_getExistenceNetwork;
/** 检测网络，返回一个布尔值 有网YES，无网NO*/
+(BOOL)hs_isExistenceNetwork;

/** 判断是否为手机号码*/
+ (BOOL)hs_isPhone:(NSString *)phoneStr;


/**
 *  浏览头像效果
 *
 *  @param selectedImageView 头像所在的imageView
 */
+ (void)hs_showBigImage:(UIImageView *)selectedImageView;

/**
 *  时间戳转 --> 时间字符串
 *
 *  @param stampStr 传入的时间戳
 *
 *  @return 返回的时间字符串
 */
+(NSString *)hs_getTimeStrForTimeStampStr:(NSString *)stampStr withFormate:(NSString *)formate;


/**
 时间字符串 -->时间戳转

 @param timeStr 传入的时间字符串
 @return 返回时间戳
 */
+(NSString *)hs_getTimeStampForTimeStr:(NSString *)timeStr withFormate:(NSString *)formate;





/**
 *  MD5加密
 *
 *  @param str 需要加密的字符串
 *
 *  @return 返回一个加密完的字符串
 */
+(NSString *)hs_getMd5Str:(NSString *)str;

/**
 获取时间戳

 @return 返回时间戳字符串
 */
+(NSString *)hs_getTimeStamp;



/**
 获取一个正确的url

 @param url 传入需要判断/拼接的url
 @return 返回一个正确的url
 */
+(NSString *)hs_getCorrectURL:(NSString *)url;





/**
 编码

 @param obj 编码对象
 @param pathStr 编码路径 可传nil
 @param key 编码对应存储的key值 建议为api接口宏地址
 */
+(void)hs_encodeArchiver_obj:(id)obj path:(NSString *)pathStr encodeKey:(NSString *)key;

/**
 解码

 @param pathStr 解码路径 可传nil
 @param key 解码对应存储的key值 建议为api接口宏地址
 */
+(id)hs_decodeArchiver_path:(NSString *)pathStr decodeKey:(NSString *)key;


@end
