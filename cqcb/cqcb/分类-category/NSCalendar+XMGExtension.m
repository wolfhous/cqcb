//
//  NSCalendar+XMGExtension.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/20.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "NSCalendar+XMGExtension.h"

@implementation NSCalendar (XMGExtension)
+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }

}
@end
