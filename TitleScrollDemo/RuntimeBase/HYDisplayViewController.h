//
//  HYDisplayViewController.h
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色渐变样式
typedef NS_ENUM (NSInteger, HYTitleColorGradientStyle) {
    HYTitleColorGradientStyleRGB, /* RGB:默认RGB样式**/
    HYTitleColorGradientStyleFill
};

@interface HYDisplayViewController : UIViewController

/********************************************** [内容] *******************************************/
/**
    内容是否需要全屏显示
    YES : 全屏:内容占据整个屏幕,会有穿透导航栏效果,需要手动设置tableView额外滚动区域
    NO : 内容从标题下显示
 */
@property(nonatomic ,assign) BOOL isFullScreen;

/**
    根据角标,选中对应的视图控制器
 */
@property(nonatomic, assign) NSInteger selectIndex;

/**
    如果isFullScreen = YES, 这个方法就不好使.
    设置整体内容的frame,包含:标题滚动视图和内容滚动视图
 */
- (void)setupContViewFrame:(void(^)(UIView *contentView))contentBlock;

/**
    刷新标题和整个界面,在调用之前必须先确定所有的视图控制器
 */
- (void)refreshDisplay;

/********************************************** [顶部标题样式] *******************************************/
- (void)setupTitleEffect:(void(^)(UIColor **titleScrollViewColor,UIColor **norColor, UIColor **selectColor, UIFont **titleFont, CGFloat *titleHeight, CGFloat *titleWidth))titleEffectBlock;

/************************************************ [下标样式] *********************************************/
- (void)setupUnderLineEffect:(void(^)(BOOL *isUnderLineDelayScroll,CGFloat *underLineH, UIColor **underColor, BOOL *isUnderLingEqualTitleWidth))underBlock;

/************************************************ [字体缩放] *********************************************/
- (void)setupTitleScale:(void(^)(CGFloat *titleScale))titleScaleblock;

/************************************************ [颜色渐变] *********************************************/
- (void)setupTitleGradient:(void(^)(HYTitleColorGradientStyle *titleColotGradientStyle, UIColor **norColor, UIColor **selectColor))titleGradientBlock;

/************************************************** [覆盖] ***********************************************/
- (void)setupCoverEffect:(void(^)(UIColor **coverColor, CGFloat *coverCornerRadius))coverEffectBlock;
@end
