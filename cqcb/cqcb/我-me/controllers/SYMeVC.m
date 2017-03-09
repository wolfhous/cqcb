//
//  SYMeVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYMeVC.h"
#import "SYMeHeaderViewBtn.h"
#define headerViewH 200

@interface SYMeVC ()<UITableViewDelegate,UITableViewDataSource>
/**
 主表视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 头部视图
 */
@property (nonatomic, strong) UIView *headerView;


/** 积分等级说明*/
@property (nonatomic,strong) UILabel *scoreLabel;
/** 用户名*/
@property (nonatomic,strong) UILabel *userNameLabel;
/** 头像按钮*/
@property (nonatomic,strong) UIButton *userPhotoBtn;


/**
 cell标题数组
 */
@property (nonatomic, strong) NSMutableArray *arrayTitles;

/**
 头部视图按钮数组
 */
@property (nonatomic, strong) NSMutableArray *arrayHeaderViewTitles;



@end

@implementation SYMeVC
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = HSLineColor;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.rowHeight = 44;
        [_tableView addSubview:self.headerView];
    }
    return _tableView;
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewH)];
        
        //添加图片背景
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"img_usercenter_bg_246x126_"];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        //添加按钮
        CGFloat w = SCREEN_WIDTH / self.arrayHeaderViewTitles.count;
        CGFloat h = w * 0.75;
        UIView *btnBgView = [[UIView alloc]init];
        btnBgView.backgroundColor = HSLineColor;
        [_headerView addSubview:btnBgView];
        [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(h);
        }];
        for (NSInteger i = 0; i < self.arrayHeaderViewTitles.count; i ++) {
            SYMeHeaderViewBtn *btn = [SYMeHeaderViewBtn buttonWithType:0];
            [btn setTitle:self.arrayHeaderViewTitles[i][@"title"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.arrayHeaderViewTitles[i][@"imageName"]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [btn addTarget:self action:@selector(clickHederViewBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btnBgView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(i * (w +1));
                make.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(w);
            }];
        }
        
        //添加积分
        UILabel *scoreLabel = [[UILabel alloc]init];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.font = [UIFont systemFontOfSize:15.0];
        scoreLabel.text = @"积分";
        self.scoreLabel = scoreLabel;
        [_headerView addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(btnBgView.mas_top).mas_equalTo(-5);
            make.height.mas_equalTo(20);
        }];
        //添加用户名
        UILabel *userNameLabel = [[UILabel alloc]init];
        userNameLabel.textAlignment = NSTextAlignmentCenter;
        userNameLabel.font = [UIFont systemFontOfSize:15.0];
        userNameLabel.text = @"用户名";
        self.userNameLabel = userNameLabel;
        [_headerView addSubview:userNameLabel];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(scoreLabel.mas_top).mas_equalTo(-5);
            make.height.mas_equalTo(20);
        }];
        //添加头像和用户名
        UIButton *userPhotoBtn = [[UIButton alloc]init];
        [userPhotoBtn setImage:[UIImage imageNamed:HS_placeholderImageName] forState:UIControlStateNormal];
        self.userPhotoBtn = userPhotoBtn;
        [_headerView addSubview:userPhotoBtn];
        [userPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(70);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(userNameLabel.mas_top).mas_equalTo(-5);
        }];

        
    }
    return _headerView;
}

-(NSMutableArray *)arrayTitles{
    if (!_arrayTitles) {
        _arrayTitles = [NSMutableArray array];
        
        NSMutableDictionary *dic00 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"积分商城",@"imageName":@"img_usercenter_jifen_20x20_"}];
        NSMutableDictionary *dic01 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"我要积分",@"imageName":@"img_usercenter_getjifen_20x20_"}];
        
        NSMutableDictionary *dic10 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"个性设置",@"imageName":@"img_usercenter_setup_20x20_"}];
        NSMutableDictionary *dic11 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"清除缓存",@"imageName":@"img_usercenter_clear_20x20_"}];
        NSMutableDictionary *dic12 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"关于上游",@"imageName":@"img_usercenter_aboutus_20x20_"}];
        NSMutableDictionary *dic13 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":[NSString stringWithFormat:@"当前版本 %@",[SYAppSingleton sharedSYAppSingleton].currentVersion],@"imageName":@"img_usercenter_update_20x20_"}];
        
        [_arrayTitles addObjectsFromArray:@[@[dic00,dic01],@[dic10,dic11,dic12,dic13]]];
        
    }
    return _arrayTitles;
}

-(NSMutableArray *)arrayHeaderViewTitles{
    if (!_arrayHeaderViewTitles) {
        _arrayHeaderViewTitles = [NSMutableArray array];
        NSMutableDictionary *dic00 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"我的收藏",@"imageName":@"btn_my_favorite_black_35x35_"}];
        NSMutableDictionary *dic01 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"我的积分",@"imageName":@"btn_my_jifen_black_35x35_"}];
        NSMutableDictionary *dic02 = [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"我的消息",@"imageName":@"btn_my_message_black_35x35_"}];
        [_arrayHeaderViewTitles addObjectsFromArray:@[dic00,dic01,dic02]];
    }
    return _arrayHeaderViewTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.jz_navigationBarBackgroundAlpha = 0;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"btn_scanCode_20x20_" highImage:@"btn_scanCode_20x20_" target:self action:@selector(clickMeVcRightItem)];
    //添加表视图
    [self.view addSubview:self.tableView];
}
-(void)clickMeVcRightItem{
    DLogFunc
}

-(void)clickHederViewBtn:(SYMeHeaderViewBtn *)btn{
    DLog(@"%@",btn.currentTitle);
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrayTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.arrayTitles[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCenterCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"meCenterCellID"];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    if ([self.arrayTitles[indexPath.section][indexPath.row][@"title"] hasPrefix:@"当前版本"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.arrayTitles[indexPath.section][indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:self.arrayTitles[indexPath.section][indexPath.row][@"imageName"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    DLog(@"%f",point.y)
    if (point.y < -headerViewH) {
        self.headerView.xmg_y = point.y;
        self.headerView.xmg_height = -point.y;
    }
}

@end
