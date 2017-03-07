//
//  SYNewsBasicVC.m
//  cqcb
//
//  Created by 侯帅 on 2017/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsBasicVC.h"
#import "SYNewsAdModel.h"//新闻广告ad模型   【model】
#import "SYNewsTypeSubModel.h"//新闻广告 子类型（广告下面的按钮类型模型）【model】
#import "SYNewsHeaderViewSubBtn.h"//新闻广告 子类型按钮 【UIButton】
#import "SYNewsSingleModel.h"//单个新闻模型 【model】

#import "SYNewsType1Cell.h"//右侧图片cell            【cell】
#import "SYNewsType2Cell.h"//三张图片类型cell         【cell】
#import "SYNewsType3Cell.h"//大图类型新闻             【cell】
#import "SYNewsType4Cell.h"//文字类型新闻             【cell】
#import "SYNewsType5Cell.h"//大图类型新闻 + 评论和阅读  【cell】

#import "SYNewsDetailWebVC.h"//新闻详情--网页类型 【VC】


#define adHeight SCREEN_WIDTH * 9 / 19//ad高度
#define subBtnHeight 60//子分类按钮高度

@interface SYNewsBasicVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

/**
 主表视图
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 新闻模型数组
 */
@property (nonatomic, strong)NSMutableArray<SYNewsSingleModel *> *arrayNews;
/**
 当前数据页码
 */
@property (nonatomic, assign)NSInteger pageIndex;
/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;


/**
 头部视图 tableView的头部
 */
@property (nonatomic,strong)UIView *headerView;

/**
 headerView 里面的 广告轮播图View
 */
@property (nonatomic,strong)SDCycleScrollView *adView;
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
static NSString *type5cellID = @"newSingleType5Cell";

#pragma mark - [懒加载]==========
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.xmg_width, self.view.xmg_height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        _tableView.mj_header = [SYRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
        _tableView.mj_footer = [SYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [_tableView registerNib:[UINib nibWithNibName:@"SYNewsType1Cell" bundle:nil] forCellReuseIdentifier:type1cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SYNewsType2Cell" bundle:nil] forCellReuseIdentifier:type2cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SYNewsType3Cell" bundle:nil] forCellReuseIdentifier:type3cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SYNewsType4Cell" bundle:nil] forCellReuseIdentifier:type4cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SYNewsType5Cell" bundle:nil] forCellReuseIdentifier:type5cellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
-(NSInteger)pageIndex{
    if (!_pageIndex) {
        _pageIndex = 1;
    }
    return _pageIndex;
}
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 100;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w - 64 - 44)/2, w, w)];
        _activityIndicatorView.color = HSMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(UIView *)headerView{
    if (!_headerView) {
        
        //先计算应该显示的高度
        CGFloat headerViewHeight = 0;
        if (self.arrayAD.count > 0 && self.model.sub.count > 0) {
            headerViewHeight = adHeight + subBtnHeight;
        }else if (self.arrayAD.count > 0 && self.model.sub.count < 1){
            headerViewHeight = adHeight;
        }else if (self.arrayAD.count < 1 && self.model.sub.count > 0){
            headerViewHeight = subBtnHeight;
        }else if (self.arrayAD.count < 1 && self.model.sub.count < 1){
            headerViewHeight = 0;
        }else{
            headerViewHeight = 0;
        }
        //创建headerView视图
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
        //判断是否有ad轮播数组数据，来创建ad滚动视图
        if (self.arrayAD.count > 0) {
            self.adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, adHeight) delegate:self placeholderImage:[UIImage imageNamed:HS_placeholderImageName]];
            
            NSMutableArray *arrayImageStr = [NSMutableArray array];
            for (SYNewsAdModel *adModel in self.arrayAD) {
                [arrayImageStr addObject:adModel.titlepic];
            }
            self.adView.imageURLStringsGroup = arrayImageStr;
            
            NSMutableArray *arrayTitleStr = [NSMutableArray array];
            for (SYNewsAdModel *adModel in self.arrayAD) {
                [arrayTitleStr addObject:adModel.title];
            }
            self.adView.titlesGroup = arrayTitleStr;
    
            self.adView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            self.adView.currentPageDotColor = HSMainColor;
            [_headerView addSubview:self.adView];
        }
        
        //判断是否有子分类数据 来创建子分类按钮
        if (self.model.sub.count > 0) {
            //添加子分类按钮
            CGFloat x = SCREEN_WIDTH / self.model.sub.count;
            CGFloat y = self.adView == nil? 0: self.adView.xmg_bottom;
            
            for (NSInteger i = 0; i < self.model.sub.count; i ++) {
                SYNewsHeaderViewSubBtn *btn = [SYNewsHeaderViewSubBtn buttonWithType:UIButtonTypeCustom];
                [btn sd_setImageWithURL:[NSURL URLWithString:self.model.sub[i].classimg] forState:UIControlStateNormal];
                [btn setTitle:self.model.sub[i].classname forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.frame = CGRectMake(i * x, y, x, subBtnHeight);
                [btn addTarget:self action:@selector(clickHeaderView_subBtn:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i;
                [_headerView addSubview:btn];
            }
            //创建分割线
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerViewHeight - 1, SCREEN_WIDTH, 0.5)];
            lineView.backgroundColor = HSLineColor;
            [_headerView addSubview:lineView];
        }
        //创建完毕
    }
    return _headerView;
}











#pragma mark - [viewDidLoad]==========
- (void)viewDidLoad {
    [super viewDidLoad];
    //开始转圈
    [self.activityIndicatorView startAnimating];
    //开始加载数据
    [self loadData];
}
-(void)loadFirstData{
    self.pageIndex = 1;
    [self loadData];
}
-(void)loadMoreData{
    self.pageIndex ++;
    [self loadData];
    
}

#pragma mark - <UITableViewDataSource>========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayNews[indexPath.row].showtype == cellTypeRightImage ) {//右侧有一张图片 或者 没有图片
        if (self.arrayNews[indexPath.row].smalltitlepic.length > 1) {//假如有图片，就显示图片
            SYNewsType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
            cell.model = self.arrayNews[indexPath.row];
            return cell;
        }else{//假如没有图片 就只显示文字
            SYNewsType4Cell *cell = [tableView dequeueReusableCellWithIdentifier:type4cellID];
            cell.model = self.arrayNews[indexPath.row];
            return cell;
        }
    }else if (self.arrayNews[indexPath.row].showtype == cellTypeThreeImage){//三张图片类型新闻
        SYNewsType2Cell *cell = [tableView dequeueReusableCellWithIdentifier:type2cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else if (self.arrayNews[indexPath.row].showtype == cellTypeBigImage){//大图类型新闻
        SYNewsType3Cell *cell = [tableView dequeueReusableCellWithIdentifier:type3cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else if (self.arrayNews[indexPath.row].showtype == cellTypeBigImageAndRed){//大图类型新闻 + 阅读评论
        SYNewsType5Cell *cell = [tableView dequeueReusableCellWithIdentifier:type5cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }else{
        DLog(@"======未知类型新闻====%ld",self.arrayNews[indexPath.row].showtype);
        SYNewsType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
        cell.model = self.arrayNews[indexPath.row];
        return cell;
    }
    
}

#pragma mark 预估高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark 实际高度 （实际高度实现重点 1赋值模型数据就开始强制布局 2在awakeFromNib实现cell里面label的preferredMaxLayoutWidth最大宽度）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayNews[indexPath.row].cellHeight) {
        return self.arrayNews[indexPath.row].cellHeight;
    }else{
        return 120;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SYNewsDetailWebVC *vc = [SYNewsDetailWebVC new];
    vc.urlStr = self.arrayNews[indexPath.row].titleurl;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <加载数据>========
-(void)loadData{
    //新闻列表数据
    [HS_Http hs_postAPIName:api_newsList(self.model.classpath,self.pageIndex) parameters:nil succes:^(id responseObject) {
        
        NSArray *array = [SYNewsSingleModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
        
        if (self.pageIndex == 1) {
            self.arrayNews = [NSMutableArray arrayWithArray:array];
        }else{
            [self.arrayNews addObjectsFromArray:array];
        }
        
        
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        //归档
        [HSManager hs_encodeArchiver_obj:self.arrayNews path:[NSString stringWithFormat:@"api_newsList%@",self.model.classid] encodeKey:[NSString stringWithFormat:@"api_newsList%@",self.model.classid]];
        
        
    } error:^(id error) {
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        //没有网络 解码
        if (![HSManager hs_isExistenceNetwork]) {
            //解码操作
            self.arrayNews = (NSMutableArray *)[HSManager hs_decodeArchiver_path:[NSString stringWithFormat:@"api_newsList%@",self.model.classid] decodeKey:[NSString stringWithFormat:@"api_newsList%@",self.model.classid]];
            if (self.arrayNews.count >0) {
                [self.tableView reloadData];
            }
        }

        
    }];
    
    
    //新闻广告数据
    [HS_Http hs_postAPIName:api_newsAD(self.model.classid) parameters:nil succes:^(id responseObject) {
        self.arrayAD = [SYNewsAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
        if (self.arrayAD.count > 0) {
            [self setupTableHeaderView];
        }else{
            DLog(@"%@===无广告轮播图",self.model.classname);
            if (self.model.sub.count > 0) {
                [self setupTableHeaderView];//单纯设置子类别
            }
        }
        //归档
        [HSManager hs_encodeArchiver_obj:self.arrayAD path:[NSString stringWithFormat:@"api_newsAD%@",self.model.classid] encodeKey:[NSString stringWithFormat:@"api_newsAD%@",self.model.classid]];
        
        
        
    } error:^(id error) {
        DLog(@"%@",error);
        //没有网络 解码
        if (![HSManager hs_isExistenceNetwork]) {
            //解码操作
            self.arrayAD = (NSMutableArray *)[HSManager hs_decodeArchiver_path:[NSString stringWithFormat:@"api_newsAD%@",self.model.classid] decodeKey:[NSString stringWithFormat:@"api_newsAD%@",self.model.classid]];
            if (self.arrayAD.count >0) {
                [self setupTableHeaderView];
            }
        }
    }];
}

-(void)setupTableHeaderView{
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - 点击ad图片回调
/** 点击ad图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SYNewsDetailWebVC *vc = [SYNewsDetailWebVC new];
    vc.urlStr = self.arrayAD[index].titleurl;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 点击子分类按钮
-(void)clickHeaderView_subBtn:(SYNewsHeaderViewSubBtn *)btn{
    DLog(@"%@",btn.currentTitle);
    SYNewsDetailWebVC *vc = [SYNewsDetailWebVC new];
    vc.urlStr = self.model.sub[btn.tag].classpath;
    [self.navigationController pushViewController:vc animated:YES];
    
}







@end
