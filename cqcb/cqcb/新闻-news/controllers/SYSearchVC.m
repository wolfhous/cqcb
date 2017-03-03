//
//  SYSearchVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/1.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYSearchVC.h"

@interface SYSearchVC ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation SYSearchVC

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"github/wolfhous/cqcb";
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jz_navigationBarTintColor = [UIColor groupTableViewBackgroundColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchBar;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar endEditing:YES];
}

#pragma mark - UISearchBarDelegate
//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
}
//点击取消搜索按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
