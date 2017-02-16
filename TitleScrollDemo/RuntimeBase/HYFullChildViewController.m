//
//  HYFullChildViewController.m
//  RuntimeBase
//
//  Created by DengHengYu on 17/2/15.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYFullChildViewController.h"

@interface HYFullChildViewController ()

@end

@implementation HYFullChildViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
    
    // 设置额外滚动区域,如果当前是全屏
    // 如果有导航控制器，顶部需要添加额外滚动区域
    // 添加额外滚动区域   导航条高度 + 标题高度
    if (self.navigationController) {
        // 导航条上面高度
        CGFloat navBarH = 64;
        
        // 查看自己标题滚动视图设置的高度，我这里设置为44
        CGFloat titleScrollViewH = 44;
        
        self.tableView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
    }
    
    
    // 如果有tabBarController，底部需要添加额外滚动区域
    //    self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);
    
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %ld",self.title,indexPath.row];
    
    return cell;
}


@end
