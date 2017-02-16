//
//  HYXMViewController.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/14.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYXMViewController.h"
#import "HYFullChildViewController.h"

@interface HYXMViewController ()

@end

@implementation HYXMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"喜马拉雅";
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    // 设置标题字体
    // 推荐方式
    [self setupTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight,CGFloat *titleWidth) {
        
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:20];
        
    }];
    
    // 推荐方式（设置下标）
    [self setupUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        // 标题填充模式
        *underLineColor = [UIColor redColor];
    }];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isFullScreen = YES;
    // Do any additional setup after loading the view.
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    HYFullChildViewController *wordVc1 = [[HYFullChildViewController alloc] init];
    wordVc1.title = @"小码哥";
    [self addChildViewController:wordVc1];
    
    // 段子
    HYFullChildViewController *wordVc2 = [[HYFullChildViewController alloc] init];
    wordVc2.title = @"M了个J";
    [self addChildViewController:wordVc2];
    
    // 段子
    HYFullChildViewController *wordVc3 = [[HYFullChildViewController alloc] init];
    wordVc3.title = @"啊峥";
    [self addChildViewController:wordVc3];
    
    HYFullChildViewController *wordVc4 = [[HYFullChildViewController alloc] init];
    wordVc4.title = @"吖了个峥";
    [self addChildViewController:wordVc4];
    
    // 全部
    HYFullChildViewController *allVc = [[HYFullChildViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // 视频
    HYFullChildViewController *videoVc = [[HYFullChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    HYFullChildViewController *voiceVc = [[HYFullChildViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    // 图片
    HYFullChildViewController *pictureVc = [[HYFullChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
     //段子
    HYFullChildViewController *wordVc = [[HYFullChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
    
    
}

@end
