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
@interface SYNewsBasicVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tabeleView;

@end

@implementation SYNewsBasicVC

-(UITableView *)tabeleView{
    if (!_tabeleView) {
        _tabeleView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tabeleView.delegate = self;
        _tabeleView.dataSource = self;
        _tabeleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tabeleView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //开始加载数据
    [self loadFirstData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}
-(void)loadFirstData{
    [HS_Http hs_postAPIName:api_newsList(self.model.classpath) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
    } error:^(id error) {
        
    }];
    
    
    [HS_Http hs_postAPIName:api_newsAD(self.model.classid) parameters:nil succes:^(id responseObject) {
        DLog(@"%@",responseObject);
    } error:^(id error) {
        
    }];
    
    
}

@end
