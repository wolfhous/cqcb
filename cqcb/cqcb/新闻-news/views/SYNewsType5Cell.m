//
//  SYNewsType5Cell.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsType5Cell.h"
#import "UILabel+HSLabel.h"
#import "UIButton+HSButton.h"
#import <AVFoundation/AVFoundation.h>

@interface SYNewsType5Cell()

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 大图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;

/**
 阅读量
 */
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;

/**
 时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 是否原创等等
 */
@property (weak, nonatomic) IBOutlet UILabel *titleTypeLabel;

/**
 大图高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftHeight;

/**
 图片数量按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *imgNumBtn;

/**
 小图 只做隐藏和显示
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall;


@property (nonatomic,strong)AVPlayer *player;
@end



@implementation SYNewsType5Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.readNumLabel hs_setRoundRadius:4];
    
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    self.imageViewLeftHeight.constant = (SCREEN_WIDTH - 30) *9 /16;
    
    [self.imgNumBtn hs_setRoundRadius:self.imgNumBtn.xmg_height/2];
    [self.titleTypeLabel hs_setRoundRadius:4 borderWidth:0.5 borderColor:HSMainColor bgColor:[UIColor whiteColor] textColor:HSMainColor fontSize:12];
    
    
}

-(void)setModel:(SYNewsSingleModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.title;
    
    self.readNumLabel.text = [NSString stringWithFormat:@"%@ 阅读",model.asdfg];
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:model.titlepic] placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
    self.timeLabel.text = model.newstime;
    
    //判断是否显示 图片数量 等
    if (model.imgnum.integerValue > 1) {
        self.imgNumBtn.hidden = NO;
        self.imageViewSmall.hidden = NO;
        self.imageViewSmall.image = [UIImage imageNamed:@"btn_images_big_50x50_"];
        [self.imgNumBtn setTitle:[NSString stringWithFormat:@"%@图",model.imgnum] forState:UIControlStateNormal];
    }else{
        self.imgNumBtn.hidden = YES;
        self.imageViewSmall.hidden = YES;
    }
    
    //如果是视频类型
    if ([model.video isEqualToString:@"1"] && model.videourl != nil) {
        self.imgNumBtn.hidden = NO;
        self.imageViewSmall.hidden = NO;
        self.imageViewSmall.image = [UIImage imageNamed:@"btn_video_play_big_50x50_"];
        [self.imgNumBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
    
    
    
    //判断是否显示 原创 等
    if ([model.titletype isEqualToString:@"无"]) {
        self.titleTypeLabel.hidden = YES;
    }else{
        self.titleTypeLabel.text = model.titletype;
    }
    
    
    //强制布局
    [self layoutIfNeeded];
    _model.cellHeight = CGRectGetMaxY(self.readNumLabel.frame) + 10;
    
    self.player = nil;
}

-(AVPlayer *)player{
    if (_player == nil) {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.videourl]];
        _player = [AVPlayer playerWithPlayerItem:item];
        AVPlayerLayer *playerlayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerlayer.frame = CGRectMake(0, 0, self.imageViewBig.xmg_width, self.imageViewBig.xmg_height);
        playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.imageViewBig.layer addSublayer:playerlayer];
    }
    return _player;
}
- (IBAction)clickBFbtn:(id)sender {
    [self.player play];
    self.imgNumBtn.hidden = YES;
    self.imageViewSmall.hidden = YES;
}






@end
