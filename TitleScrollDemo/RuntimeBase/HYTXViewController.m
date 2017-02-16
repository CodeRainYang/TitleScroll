//
//  HYTXViewController.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/14.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYTXViewController.h"
#import "ChildViewController.h"
@interface HYTXViewController ()

@end

@implementation HYTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"腾讯视频";
    
    CGFloat y = self.navigationController?64:0;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 设置搜索框
    CGFloat searchH = 44;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, y, screenW, searchH)];
    [self.view addSubview:searchBar];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    // 设置整体内容尺寸（包含标题滚动视图和底部内容滚动视图）
    [self setupContViewFrame:^(UIView *contentView) {
        CGFloat contentX = 0;
        
        CGFloat contentY = CGRectGetMaxY(searchBar.frame);
        
        CGFloat contentH = screenH - contentY;
        
        contentView.frame = CGRectMake(contentX, contentY, screenW, contentH);
    }];
    
    [self setupTitleGradient:^(HYTitleColorGradientStyle *titleColotGradientStyle, UIColor *__autoreleasing*norColor, UIColor *__autoreleasing*selectColor) {
        *norColor = [UIColor blackColor];
        *selectColor = [UIColor redColor];
    }];
    
    [self setupCoverEffect:^(UIColor **coverColor, CGFloat *coverCornerRadius) {
        *coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
        *coverCornerRadius = 13;
    }];


    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.selectIndex = 0;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"小码哥";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"iOS培训";
    [self addChildViewController:wordVc2];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"啊峥";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"吖了个峥";
    [self addChildViewController:wordVc4];
    
    // 全部
    ChildViewController *allVc = [[ChildViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // 视频
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    // 图片
    ChildViewController *pictureVc = [[ChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    ChildViewController *wordVc = [[ChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
