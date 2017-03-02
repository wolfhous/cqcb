//
//  SYVRVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYVRVC.h"
#import "SYVRSingleModel.h"
@interface SYVRVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray<SYVRSingleModel *> *arrayVR;
@end

@implementation SYVRVC
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
        _tableView.mj_header = [SYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
        _tableView.mj_footer = [SYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HSRandomColor;
    [self loadFirstData];
}
-(void)loadFirstData{
    self.pageIndex = 1;
    [self loadData];
}
-(void)loadMoreData{
    self.pageIndex ++;
    [self loadData];
    
}
-(void)loadData{
    [HS_Http hs_postAPIName:api_vrList(self.pageIndex) parameters:nil succes:^(id responseObject) {
        
        
        DLog(@"%@",responseObject);
        
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayVR.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aa"];
    }
    cell.textLabel.text = self.arrayVR[indexPath.row].title;
    return cell;
}
@end
