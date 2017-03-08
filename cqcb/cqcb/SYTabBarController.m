//
//  SYTabBarController.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYTabBarController.h"

#import "SYNavigationController.h"//导航控制器

#import "SYNewsVC.h"//新闻
#import "SYVRVC.h"//VR
#import "SYDialogueVC.h"//对话
#import "SYActivitiesVC.h"//活动
#import "SYMeVC.h"//我

@interface SYTabBarController ()

@end

@implementation SYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HSMainColor;
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    
    [self setupOneChildViewController:[[SYNavigationController alloc]initWithRootViewController:[SYMeVC new]] title:@"我" image:@"btn_tabbar_4_22x22_" selectedImage:@"btn_tabbar_sel_4_22x22_"];
    [self setupOneChildViewController:[[SYNavigationController alloc]initWithRootViewController:[SYNewsVC new]] title:@"新闻" image:@"btn_tabbar_0_22x22_" selectedImage:@"btn_tabbar_sel_0_22x22_"];
    [self setupOneChildViewController:[[SYNavigationController alloc]initWithRootViewController:[SYVRVC new]] title:@"视觉" image:@"btn_tabbar_1_20x20_" selectedImage:@"btn_tabbar_sel_1_20x20_"];
    [self setupOneChildViewController:[[SYNavigationController alloc]initWithRootViewController:[SYDialogueVC new]] title:@"对话" image:@"btn_tabbar_2_22x22_" selectedImage:@"btn_tabbar_sel_2_22x22_"];
    [self setupOneChildViewController:[[SYNavigationController alloc]initWithRootViewController:[SYActivitiesVC new]] title:@"活动" image:@"btn_tabbar_3_22x22_" selectedImage:@"btn_tabbar_sel_3_22x22_"];
}
/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        //渲染颜色
        vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self addChildViewController:vc];
}

@end
