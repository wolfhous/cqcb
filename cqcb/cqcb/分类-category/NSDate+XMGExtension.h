//
//  NSDate+XMGExtension.h
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/20.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)
/**  */
// @property (nonatomic, copy) NSString *name;
//- (NSString *)name;
//- (void)setName:(NSString *)name;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
