//
//  SYNewsBasicVC.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsBasicVC.h"
#import "SYNewsAdModel.h"//新闻广告ad模型
#import "SYNewsSingleModel.h"//单个新闻模型

#import "SYNewsType1Cell.h"//右侧图片cell
#import "SYNewsType2Cell.h"//三张图片类型cell
#import "SYNewsType3Cell.h"//cell
#import "SYNewsType4Cell.h"//cell

#import "SYNewsDetailWebVC.h"//新闻详情--网页类型
@interface SYNewsBasicVC ()<UITableViewDelegate,UITableViewDataSource>

/**
 主表视图
 */
@property (nonatomic, strong)UITableView *tabeleView;

/**
 新闻模型数组
 */
@property (nonatomic, strong)NSMutableArray<SYNewsSingleModel *> *arrayNews;
/**
 广告模型数组
 */
@property (nonatomic, strong)NSMutableArray<SYNewsAdModel *> *arrayAD;


@end

@implementation SYNewsBasicVC

static NSString *type1cellID = @"newSingleType1Cell";
static NSString *type2cellID = @"newSingleType2Cell";
static NSString *type3cellID = @"newSingleType3Cell";
static NSString *type4cellID = @"newSingleType4Cell";

#pragma mark - [懒加载]==========
-(UITableView *)tabeleView{
    if (!_tabeleView) {
        _tabeleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.xmg_width, self.view.xmg_height) style:UITableViewStylePlain];
        _tabeleView.delegate = self;
        _tabeleView.dataSource = self;
        _tabeleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tabeleView.tableFooterView = [UIView new];
        _tabeleView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        [_tabeleView registerNib:[UINib nibWithNibName:@"SYNewsType1Cell" bundle:nil] forCellReuseIdentifier:type1cellID];
        [_tabeleView registerNib:[UINib nibWithNibName:@"SYNewsType2Cell" bundle:nil] forCellReuseIdentifier:type2cellID];
        [_tabeleView registerNib:[UINib nibWithNibName:@"SYNewsType3Cell" bundle:nil] forCellReuseIdentifier:type3cellID];
        [_tabeleView registerNib:[UINib nibWithNibName:@"SYNewsType4Cell" bundle:nil] forCellReuseIdentifier:type4cellID];
        [self.view addSubview:_tabeleView];
    }
    return _tabeleView;
}
-(NSMutableArray<SYNewsSingleModel *> *)arrayNews{
    if (!_arrayNews) {
        _arrayNews = [NSMutableArray array];
    }
    return _arrayNews;
}


-(NSMutableArray<SYNewsAdModel *> *)arrayAD{
    if (!_arrayAD) {
        _arrayAD = [NSMutableArray array];
    }
    return _arrayAD;
}
#pragma mark - [viewDidLoad]==========
- (void)viewDidLoad {
    [super viewDidLoad];
    //开始加载数据
    [self loadFirstData];
}
#pragma mark - <UITableViewDataSource>========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.arrayNews[indexPath.row].showtype == cellTypeRightImage ) {//右侧一张图片
        SYNewsType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else if (self.arrayNews[indexPath.row].showtype == cellTypeThreeImage){//三张图片类型新闻
        SYNewsType2Cell *cell = [tableView dequeueReusableCellWithIdentifier:type2cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else if (self.arrayNews[indexPath.row].showtype == cellTypeBigImage){//大图类型新闻
        SYNewsType3Cell *cell = [tableView dequeueReusableCellWithIdentifier:type3cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else{
        DLog(@"未知类型新闻====%ld",self.arrayNews[indexPath.row].showtype);
        SYNewsType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }
    
}

#pragma mark 预估高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark 实际高度 （实际高度实现重点 1赋值模型数据就开始强制布局 2在awakeFromNib实现cell里面label的preferredMaxLayoutWidth最大宽度）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayNews[indexPath.row].cellHeight) {
        return self.arrayNews[indexPath.row].cellHeight;
    }else{
        return 100;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SYNewsDetailWebVC *vc = [SYNewsDetailWebVC new];
    vc.urlStr = self.arrayNews[indexPath.row].titleurl;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <加载数据>========
-(void)loadFirstData{
    [HS_Http hs_postAPIName:api_newsList(self.model.classpath) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        self.arrayNews = [SYNewsSingleModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
        [self.tabeleView reloadData];
    } error:^(id error) {
        
    }];
    
    
    [HS_Http hs_postAPIName:api_newsAD(self.model.classid) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        self.arrayAD = [SYNewsAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
//        [self.tabeleView reloadData];
    } error:^(id error) {
        
    }];
}

@end
