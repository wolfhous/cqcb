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
@interface SYNewsVC ()<UIScrollViewDelegate>
//标题滚动视图
@property (nonatomic,strong)UIScrollView *titleScrollView;
//标题按钮
@property (nonatomic,strong)SYNewsTitleBtn *selectBtn;
//主滚动视图
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation SYNewsVC

-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH - 44, 44)];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.bounces = NO;
        _titleScrollView.backgroundColor = HSRandomColor;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /***  设置导航栏相关 ****/
    [self setupNewsVCNavBar];
    /***  设置新闻分类栏目 ****/
    [self setupSYXWCatogaryTitleScrollView];
    /***  设置基础滚动视图 ****/
    [self setupBasicScrollView];
    /***  添加子控制器 ****/
    [self addChildVcInScrollView];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
#pragma mark - [初始化] 设置导航栏相关
-(void)setupNewsVCNavBar{
    self.view.backgroundColor = HSRandomColor;
    self.jz_wantsNavigationBarVisible = true;
    self.jz_navigationBarBackgroundAlpha = 1.f;
    self.jz_navigationBarTintColor = HSMainColor;
    self.navigationItem.title = @"上游新闻";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"btn_search_white_22x22_" highImage:@"btn_search_white_22x22_" target:self action:@selector(clickNewsVCLeftItem)];
}
#pragma mark - [事件] 点击左侧leftItem
-(void)clickNewsVCLeftItem{
    SYSearchVC *searchVC = [[SYSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setupSYXWCatogaryTitleScrollView{
    self.titleScrollView.hidden = NO;
}

-(void)setupBasicScrollView{
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 10, self.scrollView.xmg_height);
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //添加子控制器
    for (NSInteger i = 0; i < 10; i ++) {
        //切勿在此设置vc的view图层，只能新建。否则会调用vc的ViewLoaded，浪费性能
        UIViewController *vc = [UIViewController new];
        [self addChildViewController:vc];
    }
}

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
#pragma mark - <UIScrollViewDelegate>
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
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
//    CQSBHomeTitleBtn *titleButton = self.titleScrollView.subviews[index];
//    [self clickTitleBtn:titleButton];
    
    // 添加子控制器的view
    [self addChildVcInScrollView];
    
}
@end
