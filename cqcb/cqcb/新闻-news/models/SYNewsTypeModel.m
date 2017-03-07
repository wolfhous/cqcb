//
//  SYNewsTypeModel.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsTypeModel.h"

@interface SYNewsTypeModel()<NSCoding>

@end
@implementation SYNewsTypeModel


/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"sub" : @"SYNewsTypeSubModel"};
}


#pragma mark - NSCoding
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.classid forKey:@"classid"];
    [aCoder encodeObject:self.classpath forKey:@"classpath"];
    [aCoder encodeObject:self.classimg forKey:@"classimg"];
    [aCoder encodeObject:self.classname forKey:@"classname"];
    [aCoder encodeObject:self.subscribe forKey:@"subscribe"];
    [aCoder encodeObject:self.sub forKey:@"sub"];
    [aCoder encodeObject:self.subscribetag forKey:@"subscribetag"];
}
//对属性进行解码(时机:控制器执行decodeObject方法)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.classid = [aDecoder decodeObjectForKey:@"classid"];
        self.classpath = [aDecoder decodeObjectForKey:@"classpath"];
        self.classimg = [aDecoder decodeObjectForKey:@"classimg"];
        self.classname = [aDecoder decodeObjectForKey:@"classname"];
        self.subscribe = [aDecoder decodeObjectForKey:@"subscribe"];
        self.sub = [aDecoder decodeObjectForKey:@"sub"];
        self.subscribetag = [aDecoder decodeObjectForKey:@"subscribetag"];
    }
    return self;
}
@end
