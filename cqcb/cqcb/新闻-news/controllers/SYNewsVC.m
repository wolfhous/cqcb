//
//  SYNewsVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsVC.h"
#import "SYSearchVC.h"//搜索
#import "SYNewsTitleBtn.h"//滚动标题按钮
#import "SYNewsTypeModel.h"// 新闻分类模型
#import "SYNewsBasicVC.h"
@interface SYNewsVC ()<UIScrollViewDelegate>
//标题滚动视图
@property (nonatomic,strong)UIScrollView *titleScrollView;
//标题按钮
@property (nonatomic,strong)SYNewsTitleBtn *selectBtn;
//主滚动视图
@property (nonatomic,strong)UIScrollView *scrollView;

/**新闻分类数组 */
@property (nonatomic,strong)NSMutableArray<SYNewsTypeModel *> *arrayNewsTypes;


@end

@implementation SYNewsVC
#pragma mark - [懒加载] 懒加载====================
-(NSMutableArray<SYNewsTypeModel *> *)arrayNewsTypes{
    if (!_arrayNewsTypes) {
        _arrayNewsTypes = [NSMutableArray array];
    }
    return _arrayNewsTypes;
}
-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH - 44, 44)];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.bounces = NO;
        _titleScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:_titleScrollView];
        
    }
    return _titleScrollView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titleScrollView.xmg_bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleScrollView.xmg_bottom)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
#pragma mark - [viewDidLoad]====================
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    /***  设置导航栏相关 ****/
    [self setupNewsVCNavBar];
    /***  加载分类数据 ****/
    [self loadNewsCategoryData];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
#pragma mark - [初始化] 设置导航栏相关====================
-(void)setupNewsVCNavBar{
    self.view.backgroundColor = HSRandomColor;
    self.jz_wantsNavigationBarVisible = true;
    self.jz_navigationBarBackgroundAlpha = 1.f;
    self.jz_navigationBarTintColor = HSMainColor;
    self.navigationItem.title = @"上游新闻";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"btn_search_white_22x22_" highImage:@"btn_search_white_22x22_" target:self action:@selector(clickNewsVCLeftItem)];
}
#pragma mark  [事件] 点击左侧leftItem
-(void)clickNewsVCLeftItem{
    SYSearchVC *searchVC = [[SYSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - [加载数据] 加载分类数据====================
-(void)loadNewsCategoryData{
    
    [HS_Http hs_postAPIName:api_newsTypes parameters:nil succes:^(id responseObject) {
        
        self.arrayNewsTypes = [SYNewsTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
        /***  设置新闻分类栏目 ****/
        [self setupSYXWCatogaryTitleScrollView];
        /***  设置基础滚动视图 ****/
        [self setupBasicScrollView];
        /***  添加子控制器 ****/
        [self addChildVcInScrollView];
        
    } error:^(id error) {
        
    }];
  
}

#pragma mark [设置新闻分类栏目]
-(void)setupSYXWCatogaryTitleScrollView{
    //指示器高度
    CGFloat indicateViewHeight = 0;
    //标题按钮
    CGFloat h = self.titleScrollView.xmg_height - indicateViewHeight;
    SYNewsTitleBtn *lastBtn;
    for (NSInteger i = 0; i < self.arrayNewsTypes.count; i++) {
        SYNewsTitleBtn *btn = [SYNewsTitleBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:self.arrayNewsTypes[i].classname forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.xmg_x = lastBtn.xmg_right + 10;
        btn.xmg_y = 0;
        btn.xmg_height = h;
        [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        lastBtn = btn;
    }
    self.titleScrollView.contentSize = CGSizeMake(lastBtn.xmg_right + 5, self.titleScrollView.xmg_height);
    //首个选中按钮
    self.selectBtn = self.titleScrollView.subviews.firstObject;
    self.selectBtn.selected = YES;
    [self.selectBtn.titleLabel sizeToFit];
}
#pragma mark [事件]点击导航标题
-(void)clickTitleBtn:(SYNewsTitleBtn *)btn{
    DLog(@"%@",btn.currentTitle);
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    // 让UIScrollView滚动到对应位置
    CGPoint point = self.scrollView.contentOffset;
    point.x = btn.tag * self.scrollView.xmg_width;
    [self.scrollView setContentOffset:point animated:YES];
}
#pragma mark [设置基础滚动视图]
-(void)setupBasicScrollView{
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.arrayNewsTypes.count, self.scrollView.xmg_height);
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //添加子控制器
    for (NSInteger i = 0; i < self.arrayNewsTypes.count; i ++) {
        //切勿在此设置vc的view图层，只能新建。否则会调用vc的ViewLoaded，浪费性能
        SYNewsBasicVC *vc = [SYNewsBasicVC new];
        vc.model = self.arrayNewsTypes[i];
        [self addChildViewController:vc];
    }
}
#pragma mark [添加子控制器]
- (void)addChildVcInScrollView{
    NSUInteger index = self.scrollView.contentOffset.x/self.scrollView.xmg_width;
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) {
        return;
    }
    childVC.view.backgroundColor = HSRandomColor;
    childVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVC.view];
}



#pragma mark - <UIScrollViewDelegate> =============
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcInScrollView];
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    SYNewsTitleBtn *titleButton = self.titleScrollView.subviews[index];
    [self clickTitleBtn:titleButton];
    // 添加子控制器的view
    [self addChildVcInScrollView];
}






@end
