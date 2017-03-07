//
//  SYMeVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYMeVC.h"
#define headerViewH 100

@interface SYMeVC ()<UITableViewDelegate,UITableViewDataSource>
/**
 主表视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 头部视图
 */
@property (nonatomic, strong) UIView *headerView;
/**
 标题数组
 */
@property (nonatomic, strong) NSMutableArray *arrayTitles;



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
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"img_usercenter_bg_246x126_"];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
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
    if (point.y < -headerViewH) {
        self.headerView.xmg_y = point.y;
        self.headerView.xmg_height = -point.y;
    }
}

@end
