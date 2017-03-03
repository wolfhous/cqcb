//
//  SYDialogueVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYDialogueVC.h"
#import "SYDialogueSingleModel.h"
#import "SYDialogueCell.h"
@interface SYDialogueVC ()<UITableViewDelegate,UITableViewDataSource>

/**
 主表视图
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 vr列表数组
 */
@property (nonatomic,strong)NSMutableArray<SYDialogueSingleModel *> *arrayDialogue;


@end

@implementation SYDialogueVC

static NSString *dialogueCellID = @"DialogueCellID";


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [SYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
//        _tableView.mj_footer = [SYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SYDialogueCell" bundle:nil] forCellReuseIdentifier:dialogueCellID];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSMutableArray<SYDialogueSingleModel *> *)arrayDialogue{
    if (!_arrayDialogue) {
        _arrayDialogue = [NSMutableArray array];
    }
    return _arrayDialogue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"对话";
    [self loadFirstData];

}
#pragma mark  [下拉刷新]
-(void)loadFirstData{
    [self loadData];
}
#pragma mark  [上拉刷新]
-(void)loadMoreData{
    [self loadData];
    
}
#pragma mark  [加载数据]
-(void)loadData{
    [HS_Http hs_postAPIName:api_dialoggue parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        self.arrayDialogue = [SYDialogueSingleModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } error:^(id error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDialogue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYDialogueCell *cell = [tableView dequeueReusableCellWithIdentifier:dialogueCellID];
    
    cell.model = self.arrayDialogue[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayDialogue[indexPath.row].cellHeight) {
        return self.arrayDialogue[indexPath.row].cellHeight;
    }else{
        return 350;
    }
}

@end
