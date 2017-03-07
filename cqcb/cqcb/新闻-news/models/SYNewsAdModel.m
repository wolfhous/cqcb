//
//  SYNewsAdModel.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsAdModel.h"

@implementation SYNewsAdModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}
-(NSString *)titlepic{
    _titlepic = [HSManager hs_getCorrectURL:_titlepic];
    
    return _titlepic;
}
-(NSString *)titleurl{
    _titleurl = [HSManager hs_getCorrectURL:_titleurl];
    
    return _titleurl;
}



#pragma mark - NSCoding
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.buyfen forKey:@"buyfen"];
    [aCoder encodeObject:self.titlepic forKey:@"titlepic"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.titletype forKey:@"titletype"];
    [aCoder encodeObject:self.video forKey:@"video"];
    [aCoder encodeObject:self.titleurl forKey:@"titleurl"];
}
//对属性进行解码(时机:控制器执行decodeObject方法)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.buyfen = [aDecoder decodeObjectForKey:@"buyfen"];
        self.titlepic = [aDecoder decodeObjectForKey:@"titlepic"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.titletype = [aDecoder decodeObjectForKey:@"titletype"];
        self.video = [aDecoder decodeObjectForKey:@"video"];
        self.titleurl = [aDecoder decodeObjectForKey:@"titleurl"];
    }
    return self;
}




@end
