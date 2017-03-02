//
//  SYNewsSingleModel.h
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,cellType) {
    /** 右侧图片类型新闻  或者 没有图片  具体有无图片根据模型的imgnum来判断*/
    cellTypeRightImage = 0,
    /** 三张图片类型新闻*/
    cellTypeThreeImage = 1,
    /** 大图类型新闻*/
    cellTypeBigImage = 3,
    /** 大图类型新闻 + 评论和阅读*/
    cellTypeBigImageAndRed = 2,
    
    
};
@interface SYNewsSingleModel : NSObject

/** <#Description#>*/
@property (nonatomic,copy)NSString *isSYN;
/** 0:右侧一张图片  1:3张图片   3:一张大图*/
@property (nonatomic,assign)cellType showtype;
/** <#Description#>*/
@property (nonatomic,copy)NSString *istop;
/** 时间*/
@property (nonatomic,copy)NSString *newstime;
/** 标题*/
@property (nonatomic,copy)NSString *title;
/** 阅读量？*/
@property (nonatomic,copy)NSString *asdfg;
/** 视频地址*/
@property (nonatomic,copy)NSString *videourl;
/** <#Description#>*/
@property (nonatomic,copy)NSString *sptime;


/** 第1张 （小图）*/
@property (nonatomic,copy)NSString *smalltitlepic;//第一张
/** 第2张（大图）*/
@property (nonatomic,copy)NSString *titlepic;//第二张
/** 第3张（小图）*/
@property (nonatomic,copy)NSString *smalltitlepic3;//第三张

/** <#Description#>*/
@property (nonatomic,copy)NSString *smalltext;
/** <#Description#>*/
@property (nonatomic,copy)NSString *expertheadimgurl;
/** <#Description#>*/
@property (nonatomic,copy)NSString *video;
/** 有几张图片*/
@property (nonatomic,copy)NSString *imgnum;
/** 标题链接地址*/
@property (nonatomic,copy)NSString *titleurl;
/** <#Description#>*/
@property (nonatomic,copy)NSString *ID;
/** <#Description#>*/
@property (nonatomic,copy)NSString *onclick;
/** 分类id*/
@property (nonatomic,copy)NSString *classid;
/** <#Description#>*/
@property (nonatomic,copy)NSString *isurl;
/** <#Description#>*/
@property (nonatomic,copy)NSString *titletype;
/** <#Description#>*/
@property (nonatomic,copy)NSString *writer;
/** 评论数量*/
@property (nonatomic,copy)NSString *plnum;
/** 来源*/
@property (nonatomic,copy)NSString *befrom;
/** <#Description#>*/
@property (nonatomic,copy)NSString *expertname;

//===========自定义添加数据==============

/** cell 的高度*/
@property (nonatomic,assign)CGFloat cellHeight;

@end
