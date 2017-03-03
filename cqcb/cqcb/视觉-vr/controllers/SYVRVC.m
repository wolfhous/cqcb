//
//  SYVRVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYVRVC.h"
#import "SYVRSingleModel.h"//单个视觉模型
#import "SYVRCell.h"//vr主cell
@interface SYVRVC ()<UITableViewDelegate,UITableViewDataSource>

/**
 主表视图
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 页码
 */
@property (nonatomic,assign)NSInteger pageIndex;

/**
 vr列表数组
 */
@property (nonatomic,strong)NSMutableArray<SYVRSingleModel *> *arrayVR;
@end

@implementation SYVRVC


static NSString *vrCellID = @"SYVRCellID";

#pragma mark - [懒加载]

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [SYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
        _tableView.mj_footer = [SYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SYVRCell" bundle:nil] forCellReuseIdentifier:vrCellID];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSMutableArray<SYVRSingleModel *> *)arrayVR{
    if (!_arrayVR) {
        _arrayVR = [NSMutableArray array];
    }
    return _arrayVR;
}

#pragma mark - [viewDidLoad]
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"VR";
    [self loadFirstData];
}
#pragma mark  [下拉刷新]
-(void)loadFirstData{
    self.pageIndex = 1;
    [self loadData];
}
#pragma mark  [上拉刷新]
-(void)loadMoreData{
    self.pageIndex ++;
    [self loadData];
    
}
#pragma mark  [加载数据]
-(void)loadData{
    
    [HS_Http hs_postAPIName:api_vrList(self.pageIndex) parameters:nil succes:^(id responseObject) {
        NSArray *array = [SYVRSingleModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
        if (self.pageIndex == 1) {
            self.arrayVR = [NSMutableArray arrayWithArray:array];
        }else{
            [self.arrayVR addObjectsFromArray:array];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
    } error:^(id error) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayVR.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYVRCell *cell = [tableView dequeueReusableCellWithIdentifier:vrCellID];
    
    cell.model = self.arrayVR[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayVR[indexPath.row].cellHeight) {
        return self.arrayVR[indexPath.row].cellHeight;
    }else{
        return 200;
    }
}


























@end
