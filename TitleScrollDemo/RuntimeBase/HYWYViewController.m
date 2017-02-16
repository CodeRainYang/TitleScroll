//
//  HYWYViewController.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/14.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYWYViewController.h"
#import "ChildViewController.h"

@interface HYWYViewController ()

@end

@implementation HYWYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setupTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor lightGrayColor];
        *selColor = [UIColor blackColor];
        *titleWidth = [UIScreen mainScreen].bounds.size.width / 4;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setupTitleGradient:^(HYTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        
    }];
    
//    [self setupUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
//        //        *isUnderLineDelayScroll = YES;
//        *isUnderLineEqualTitleWidth = YES;
//    }];
    
    // 字体缩放
    // 推荐方式 (设置字体缩放)
        [self setupTitleScale:^(CGFloat *titleScale) {
            // 字体缩放比例
            *titleScale = 1.3;
        }];


}

- (void)setUpAllViewController
{
    
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"小码哥";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"M了个J";
    [self addChildViewController:wordVc2];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"啊峥";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"吖了个峥";
    [self addChildViewController:wordVc4];
    
}

@end
