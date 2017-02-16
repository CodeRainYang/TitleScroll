//
//  HYDisplayViewHeader.h
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#ifndef HYDisplayViewHeader_h
#define HYDisplayViewHeader_h

#import "HYDisplayViewController.h"

/*
 
 ********************** 用法 **********************
 一. 导入HYDisplayViewHeader.h
 二. 自定义HYDisplayViewController;
 三. 添加所有自控制器,设置子控制器标题
 四. 查看HYDisplayViewController.h文件,找到需要的效果
 五. 标题被点击或内容滚动完成,会发出这个通知["HYDisplayViewClickOrScrollDidFinish"],监听这个通知,可以做自己想要做的事情
 */

/********************** 使用须知 **********************
 1.字体放大效果和下标不能同时使用.
 2.当前框架,如果标题宽度自定义,就不能使用颜色填充模式(HYTitleColorGradientStyleFill),因为要做今日头条效果,标题宽度比较内部好计算
 3.当前框架已经做了离屏渲染优化和控制器view懒加载
 4.网易效果:颜色渐变 + 字体放缩
 5.今日头条效果:颜色填充渐变
 6.展示tableview的时候,如果有UITabBarController,UINavigationController,就需要自己给tableview顶部添加64额外滚动区域
*/

// 导航条高度
static CGFloat const HYNavBarH = 64.0;

// 标题滚动视图高度
static CGFloat const HYTtileScrollViewH = 44.0;

// 标题缩放比例
static CGFloat const HYTitleTransformScale = 1.3;

// 下划线默认高度
static CGFloat const HYUnderLineH = 2.0;

// 默认标题间距
static CGFloat const margin = 20;

#define HYScreenW [UIScreen mainScreen].bounds.size.width

#define HYScreenH [UIScreen mainScreen].bounds.size.height

// 默认标题字体
#define HYTitleFont [UIFont systemFontOfSize:15];

// 标题被点击或者内容滚动完成，会发出这个通知，监听这个通知，可以做自己想要做的事情，比如加载数据
static NSString * const HYDisplayViewClickOrScrollDidDinishNote = @"HYDisplayViewClickOrScrollDidDinishNote";

// 重复点击通知
static NSString * const HYDisplayViewRepeatClickTitleNote = @"HYDisplayViewRepeatClickTitleNote";

#endif /* HYDisplayViewHeader_h */
