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
#import "SYNewsType3Cell.h"//大图类型新闻
#import "SYNewsType4Cell.h"//文字类型新闻
#import "SYNewsType5Cell.h"//大图类型新闻 + 评论和阅读

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

/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end

@implementation SYNewsBasicVC

static NSString *type1cellID = @"newSingleType1Cell";
static NSString *type2cellID = @"newSingleType2Cell";
static NSString *type3cellID = @"newSingleType3Cell";
static NSString *type4cellID = @"newSingleType4Cell";
static NSString *type5cellID = @"newSingleType5Cell";

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
        [_tabeleView registerNib:[UINib nibWithNibName:@"SYNewsType5Cell" bundle:nil] forCellReuseIdentifier:type5cellID];
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
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 100;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w - 64 - 44)/2, w, w)];
        _activityIndicatorView.color = HSMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}



#pragma mark - [viewDidLoad]==========
- (void)viewDidLoad {
    [super viewDidLoad];
    //开始转圈
    [self.activityIndicatorView startAnimating];
    //开始加载数据
    [self loadFirstData];
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
    }
    
    else{
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
    
    //新闻列表数据
    [HS_Http hs_postAPIName:api_newsList(self.model.classpath) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        self.arrayNews = [SYNewsSingleModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
        
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        [self.tabeleView reloadData];
        
    } error:^(id error) {
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
    }];
    
    //新闻广告数据
    [HS_Http hs_postAPIName:api_newsAD(self.model.classid) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        self.arrayAD = [SYNewsAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"newslist"]];
    } error:^(id error) {
        
    }];
}

@end
