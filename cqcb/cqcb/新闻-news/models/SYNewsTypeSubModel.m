//
//  SYNewsTypeSubModel.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsTypeSubModel.h"

@implementation SYNewsTypeSubModel
-(NSString *)classimg{
    _classimg = [HSManager hs_getCorrectURL:_classimg];
    
    return _classimg;
}
#pragma mark - NSCoding
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.classid forKey:@"classid"];
    [aCoder encodeObject:self.classpath forKey:@"classpath"];
    [aCoder encodeObject:self.classimg forKey:@"classimg"];
    [aCoder encodeObject:self.classname forKey:@"classname"];
    [aCoder encodeObject:self.showtype forKey:@"showtype"];
}
//对属性进行解码(时机:控制器执行decodeObject方法)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.classid = [aDecoder decodeObjectForKey:@"classid"];
        self.classpath = [aDecoder decodeObjectForKey:@"classpath"];
        self.classimg = [aDecoder decodeObjectForKey:@"classimg"];
        self.classname = [aDecoder decodeObjectForKey:@"classname"];
        self.showtype = [aDecoder decodeObjectForKey:@"showtype"];
    }
    return self;
}

@end
