//
//  SYNewsSingleModel.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsSingleModel.h"

@implementation SYNewsSingleModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
/**
 *  在第一次使用SYNewsSingleModel类时调用1次
 */
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}
-(NSString *)newstime{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_newstime];
    
    if (createdAtDate.isThisYear) { // 今年
        if (createdAtDate.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        } else { // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _newstime;
    }

}
#pragma mark - NSCoding
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.showtype forKey:@"showtype"];
    [aCoder encodeObject:self.istop forKey:@"istop"];
    [aCoder encodeObject:self.newstime forKey:@"newstime"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.asdfg forKey:@"asdfg"];
    [aCoder encodeObject:self.videourl forKey:@"videourl"];
    [aCoder encodeObject:self.sptime forKey:@"sptime"];
    [aCoder encodeObject:self.smalltitlepic forKey:@"smalltitlepic"];
    [aCoder encodeObject:self.titlepic forKey:@"titlepic"];
    [aCoder encodeObject:self.smalltitlepic3 forKey:@"smalltitlepic3"];
    [aCoder encodeObject:self.smalltext forKey:@"smalltext"];
    [aCoder encodeObject:self.expertheadimgurl forKey:@"expertheadimgurl"];
    [aCoder encodeObject:self.video forKey:@"video"];
    [aCoder encodeObject:self.imgnum forKey:@"imgnum"];
    [aCoder encodeObject:self.titleurl forKey:@"titleurl"];
    [aCoder encodeObject:self.onclick forKey:@"onclick"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.classid forKey:@"classid"];
    [aCoder encodeObject:self.isurl forKey:@"isurl"];
    [aCoder encodeObject:self.titletype forKey:@"titletype"];
    [aCoder encodeObject:self.writer forKey:@"writer"];
    [aCoder encodeObject:self.plnum forKey:@"plnum"];
    [aCoder encodeObject:self.befrom forKey:@"befrom"];
    [aCoder encodeObject:self.expertname forKey:@"expertname"];
    [aCoder encodeFloat:self.cellHeight forKey:@"cellHeight"];
}
//对属性进行解码(时机:控制器执行decodeObject方法)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.showtype = [aDecoder decodeIntegerForKey:@"showtype"];
        self.istop = [aDecoder decodeObjectForKey:@"istop"];
        self.newstime = [aDecoder decodeObjectForKey:@"newstime"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.asdfg = [aDecoder decodeObjectForKey:@"asdfg"];
        self.videourl = [aDecoder decodeObjectForKey:@"videourl"];
        self.sptime = [aDecoder decodeObjectForKey:@"sptime"];
        self.smalltitlepic = [aDecoder decodeObjectForKey:@"smalltitlepic"];
        self.titlepic = [aDecoder decodeObjectForKey:@"titlepic"];
        self.smalltitlepic3 = [aDecoder decodeObjectForKey:@"smalltitlepic3"];
        self.smalltext = [aDecoder decodeObjectForKey:@"smalltext"];
        self.expertheadimgurl = [aDecoder decodeObjectForKey:@"expertheadimgurl"];
        self.video = [aDecoder decodeObjectForKey:@"video"];
        self.imgnum = [aDecoder decodeObjectForKey:@"imgnum"];
        self.titleurl = [aDecoder decodeObjectForKey:@"titleurl"];
        self.onclick = [aDecoder decodeObjectForKey:@"onclick"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.classid = [aDecoder decodeObjectForKey:@"classid"];
        self.isurl = [aDecoder decodeObjectForKey:@"isurl"];
        self.titletype = [aDecoder decodeObjectForKey:@"titletype"];
        self.writer = [aDecoder decodeObjectForKey:@"writer"];
        self.plnum = [aDecoder decodeObjectForKey:@"plnum"];
        self.befrom = [aDecoder decodeObjectForKey:@"befrom"];
        self.expertname = [aDecoder decodeObjectForKey:@"expertname"];
        self.cellHeight = [aDecoder decodeFloatForKey:@"cellHeight"];
    }
    return self;
}
@end
