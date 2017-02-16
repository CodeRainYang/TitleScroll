//
//  HYDisplayViewController.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "HYDisplayViewController.h"
#import "HYDisplayViewHeader.h"
#import "HYFlowLayout.h"
#import "UIView+Frame.h"
#import "HYDisplayTitleLabel.h"

static NSString * ID = @"CONTENTCELL";

@interface HYDisplayViewController ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    UIColor *_norColor;
    UIColor *_selectColor;
}

/**
    下标宽度是否等于标题宽度
 */
@property(nonatomic, assign) BOOL isUnderLineEqualTitleWidth;

/**
    标题滚动视图背景颜色
 */
@property(nonatomic, strong) UIColor *titleScrollerViewColor;

/**
    标题宽度
 */
@property(nonatomic, assign)  CGFloat titleWidth;

/**
    标题高度
 */
@property(nonatomic, assign)  CGFloat titleHeight;

/**
    普通标题颜色
 */
@property(nonatomic, strong) UIColor *norColor;

/**
    选中标题颜色
 */
@property(nonatomic, strong) UIColor *selectColor;

/**
    标题字体
 */
@property(nonatomic, strong) UIFont *titleFont;

/**
    整体内容view,包含滚动标题和滚动内容
 */
@property(nonatomic, weak)  UIView *contentView;

/**
    标题滚动视图
 */
@property(nonatomic, weak)  UIScrollView *titleScrollView;

/**
    内容滚动视图
 */
@property(nonatomic, weak)  UICollectionView *contentScrollView;

/**
    所有标题数组
 */
@property(nonatomic, strong) NSMutableArray *titleLabelsArrM;

/**
    所有标题宽度数组
 */
@property(nonatomic, strong) NSMutableArray *titleWidthsArrM;

/**
    下标视图
 */
@property(nonatomic, weak)  UIView *underLine;

/**
    是否需要下标
 */
@property(nonatomic, assign)  BOOL isShowUnderLine;

/**
    字体是否渐变
 */
@property(nonatomic, assign)  BOOL isShowTitleGradient;

/**
    字体是否放缩
 */
@property(nonatomic, assign)  BOOL isShowTitleScale;

/**
    是否显示遮盖
 */
@property(nonatomic, assign)  BOOL isShowTitleCover;

/**
    记录是否点击标题
 */
@property(nonatomic, assign)  BOOL isClickTitle;

/**
    记录是否在动画
 */
@property(nonatomic, assign)  BOOL isAniming;

/**
    是否初始化
 */
@property(nonatomic, assign)  BOOL isInitial;

/**
    标题遮盖视图
 */
@property(nonatomic, weak)  UIView *corverView;

/**
    记录上一次内容滚动视图偏移量
 */
@property(nonatomic, assign) CGFloat laseOffsetX;

/**
    标题间距
 */
@property(nonatomic, assign) CGFloat titleMargin;

/**
    上一次选中标题角标
 */
@property(nonatomic, assign)  NSInteger selIndex;

/**
    标题颜色渐变样式
 */
@property(nonatomic, assign) HYTitleColorGradientStyle titleColorGradientStyle;

/**
    标题字体缩放比例
 */
@property(nonatomic, assign) CGFloat titleScale;

/**
    是否延迟滚动下标
 */
@property(nonatomic, assign)  BOOL isDelayScroll;

/**
    标题遮盖视图背景色
 */
@property(nonatomic, strong) UIColor *corverColor;

/**
    标题遮盖视图圆角大小
 */
@property(nonatomic, assign) CGFloat corverCornerRadius;

/**
    下标颜色
 */
@property(nonatomic, strong) UIColor *underLineColor;

/**
    下标高度
 */
@property(nonatomic, assign) CGFloat underLineH;

/**
    开始颜色RGB值,取值范围0~1
 */
@property(nonatomic, assign) CGFloat startR;

@property(nonatomic, assign) CGFloat startG;

@property(nonatomic, assign)  CGFloat startB;

/**
    结束颜色RGB值,取值范围0~1
 */
@property(nonatomic, assign) CGFloat endR;

@property(nonatomic, assign) CGFloat endG;

@property(nonatomic, assign) CGFloat endB;

@end

@implementation HYDisplayViewController

- (void)initial {
    //初始化标题高度
    _titleHeight = HYTtileScrollViewH;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}
#pragma mark - 懒加载

- (UIFont *)titleFont {
    if (_titleFont == nil) {
        _titleFont = HYTitleFont
    }
    return _titleFont;
}

- (UIColor *)norColor {
    if (_norColor == nil) {
        _norColor = [UIColor blackColor];
    }
    return _norColor;
}

- (UIColor *)selectColor {
    if (_selectColor == nil) {
        _selectColor = [UIColor redColor];
    }
    return _selectColor;
}

- (UIView *)corverView {
    if (_corverView == nil) {
        UIView *corverView = [[UIView alloc] init];
        corverView.backgroundColor = _corverColor ? _corverColor : [UIColor lightGrayColor];
        corverView.layer.cornerRadius = _corverCornerRadius;
        [self.titleScrollView insertSubview:corverView atIndex:0];
        _corverView = corverView;
    }
    return _isShowTitleCover?_corverView:nil;

}

- (UIView *)underLine {
    if (_underLine == nil) {
        UIView *underLine = [[UIView alloc] init];
        underLine.backgroundColor = _underLineColor ? _underLineColor : [UIColor redColor];
        [self.titleScrollView addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (NSMutableArray *)titleLabelsArrM {
    if (_titleLabelsArrM == nil) {
        _titleLabelsArrM = [NSMutableArray array];
    }
    return _titleLabelsArrM;
}

- (NSMutableArray *)titleWidthsArrM {
    if (_titleWidthsArrM == nil) {
        _titleWidthsArrM = [NSMutableArray array];
    }
    return _titleWidthsArrM;
}

#pragma mark - 懒加载标题滚动视图
- (UIScrollView *)titleScrollView {
    if (_titleScrollView == nil) {
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.backgroundColor = _titleScrollerViewColor ? _titleScrollerViewColor : [UIColor colorWithWhite:1 alpha:0.7];
        [self.contentView addSubview:titleScrollView];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

#pragma mark - 懒加载内容滚动视图

- (UICollectionView *)contentScrollView {
    if (_contentScrollView == nil) {
        HYFlowLayout *layout = [[HYFlowLayout alloc] init];
        UICollectionView *contentScrollView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentScrollView = contentScrollView;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        _contentScrollView.scrollsToTop = NO;
        [_contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        _contentScrollView.backgroundColor = self.view.backgroundColor;
        [self.contentView insertSubview:_contentScrollView belowSubview:self.titleScrollView];
    }
    return _contentScrollView;
}

#pragma mark - 懒加载整个内容view
- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self.view addSubview:contentView];
    }
    return _contentView;
}

#pragma mark - 属性setter方法

- (void)setIsShowTitleScale:(BOOL)isShowTitleScale {
    if (_isShowUnderLine) {
        NSException *excp = [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"字体缩放效果和下标不能同时使用" userInfo:nil];
        [excp raise];
    }
    _isShowTitleScale = isShowTitleScale;
}

- (void)setIsShowUnderLine:(BOOL)isShowUnderLine {
    if (_isShowTitleScale) {
        NSException *excp = [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"字体缩放效果和下标不能同时使用" userInfo:nil];
        [excp raise];
    }
    _isShowUnderLine = isShowUnderLine;
}

- (void)setTitleScrollerViewColor:(UIColor *)titleScrollerViewColor {
    _titleScrollerViewColor = titleScrollerViewColor;
    self.titleScrollView.backgroundColor = titleScrollerViewColor;
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    self.contentView.frame = CGRectMake(0, 0, HYScreenW, HYScreenH);
}

#pragma mark - 设置整体内容属性
- (void)setupContViewFrame:(void (^)(UIView *))contentBlock {
    if (contentBlock) {
        contentBlock(self.contentView);
    }
}

#pragma mark - 一次性设置所有颜色渐变属性
- (void)setupTitleGradient:(void (^)(HYTitleColorGradientStyle *titleColorGradientStyle, UIColor **norColor, UIColor **selColor))titleGradientBlock {
    _isShowTitleGradient = YES;
    UIColor *norColor;
    UIColor *selColor;
    if (titleGradientBlock) {
        titleGradientBlock(&_titleColorGradientStyle,&norColor,&selColor);
        if (norColor) {
            self.norColor = norColor;
        }
        if (selColor) {
            self.selectColor = selColor;
        }
    }
    
    if (_titleColorGradientStyle == HYTitleColorGradientStyleFill && _titleWidth > 0) {
        @throw [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"标题颜色填充不需要设置标题宽度" userInfo:nil];
    }
}

#pragma mark - 一次性设置所有遮盖属性 
- (void)setupCoverEffect:(void (^)(UIColor **, CGFloat*))coverEffectBlock {
    UIColor *color;
    _isShowTitleCover = YES;
    if (coverEffectBlock) {
        coverEffectBlock(&color,&_corverCornerRadius);
        if (color) {
            _corverColor = color;
        }
    }
}

#pragma mark - 一次性设置所有字体缩放属性
- (void)setupTitleScale:(void (^)(CGFloat *))titleScaleblock {
    _isShowTitleScale = YES;
    if (_isShowUnderLine) {
        @throw [NSException exceptionWithName:@"HY_Error" reason:@"字体缩放效果和下标不能同时使用" userInfo:nil];
    }
    if (titleScaleblock) {
        titleScaleblock(&_titleScale);
    }
}

#pragma mark - 一次性设置所有下标属性
- (void)setupUnderLineEffect:(void (^)(BOOL *, CGFloat *, UIColor **, BOOL *))underBlock {
    _isShowUnderLine = YES;
    if (_isShowTitleScale) {
        @throw [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"字体缩放效果和下标不能同时使用" userInfo:nil];
    }
    
    UIColor *underLineColor;
    if (underBlock) {
        underBlock(&_isDelayScroll,&_underLineH,&underLineColor,&_isUnderLineEqualTitleWidth);
        _underLineColor = underLineColor;
    }
}

#pragma mark - 一次性设置所有标题属性
- (void)setupTitleEffect:(void (^)(UIColor **, UIColor **, UIColor **, UIFont **, CGFloat *, CGFloat *))titleEffectBlock {
    UIColor *titleScrollViewColor;
    UIColor *norColor;
    UIColor *selColor;
    UIFont *titleFont;
    if (titleEffectBlock) {
        titleEffectBlock(&titleScrollViewColor,&norColor,&selColor,&titleFont,&_titleHeight,&_titleWidth);
        if (norColor) {
            self.norColor = norColor;
        }
        if (selColor) {
            self.selectColor = selColor;
        }
        if (titleScrollViewColor) {
            self.titleScrollerViewColor = titleScrollViewColor;
        }
        _titleFont = titleFont;
    }
    if (_titleColorGradientStyle == HYTitleColorGradientStyleFill && _titleWidth > 0) {
        @throw [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"标题颜色填充不需要设置标题宽度" userInfo:nil];
    }
    
}

#pragma mark - 控制器view生命周期
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    if (_isInitial == NO) {
        self.selectIndex = self.selectIndex;
        _isInitial = YES;
        CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat titleY = self.navigationController.navigationBarHidden == NO ? HYNavBarH : statusH;
        
        if (_isFullScreen) {
            //整体contentView尺寸
            self.contentView.frame = CGRectMake(0, 0, HYScreenW, HYScreenH);
            //顶部标题view尺寸
            self.titleScrollView.frame = CGRectMake(0, titleY, HYScreenW, self.titleHeight);
            //内容view尺寸
            self.contentScrollView.frame = self.contentView.bounds;
            return;
        }
        
        // 顶部标题View尺寸
       
        if (self.contentView.frame.size.height == 0) {
            self.contentView.frame = CGRectMake(0, titleY, HYScreenW, HYScreenH - titleY);
        }
         self.titleScrollView.frame = CGRectMake(0, 0, HYScreenW, self.titleHeight);
        CGFloat contentY = CGRectGetMaxY(self.titleScrollView.frame);
        CGFloat contentH = self.contentView.hy_height - contentY;
        self.contentScrollView.frame = CGRectMake(0, contentY, HYScreenW, contentH);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        if (self.childViewControllers.count == 0) {
            return;
        }
        if (_titleColorGradientStyle == HYTitleColorGradientStyleFill || _titleWidth == 0) {
            [self setupTitleWidth];
        }
        [self setupAllTitle];
    }
}

- (void)setupTitleWidth {
    NSUInteger count = self.childViewControllers.count;
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    CGFloat totalWidth = 0;
    
    for (NSString *title in titles) {
        if ([title isKindOfClass:[NSNull class]]) {
            //抛出异常
            NSException *excp = [NSException exceptionWithName:@"HYDisplayViewControllerException" reason:@"没有设置Controller.title属性，应该把子标题保存到对应子控制器中" userInfo:nil];
            [excp raise];
        }
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil];
        CGFloat width = titleBounds.size.width;
        [self.titleWidthsArrM addObject:@(width)];
        totalWidth += width;
    }
    
    if (totalWidth > HYScreenW) {
        _titleMargin = margin;
        self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
        return;
    }
    CGFloat titleMargin = (HYScreenW - totalWidth) / (count + 1);
    _titleMargin = titleMargin < margin ? margin :titleMargin;
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}

- (void)setupAllTitle {
    NSUInteger count = self.childViewControllers.count;
    
    //添加所有标题
    CGFloat labelW = _titleWidth;
    CGFloat labelH = self.titleHeight;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i ++) {
        UIViewController *vc = self.childViewControllers[i];
        UILabel *label = [[HYDisplayTitleLabel alloc] init];
        label.tag = i;
        label.textColor = self.norColor;
        label.font = self.titleFont;
        //设置按钮标题
        label.text = vc.title;
        if (_titleColorGradientStyle == HYTitleColorGradientStyleFill || _titleWidth == 0) {
            labelW = [self.titleWidthsArrM[i] floatValue];
            
            //设置按钮位置
            UILabel *lastLabel = self.titleLabelsArrM.lastObject;
            labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        } else {
            labelX = i * labelW;
        }
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        
        [label addGestureRecognizer:tap];
        //保存到数组
        [self.titleLabelsArrM addObject:label];
        [_titleScrollView addSubview:label];
        if (i == _selectIndex) {
            [self titleClick:tap];
        }
    }
    
    UILabel *lastLabel = self.titleLabelsArrM.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.contentSize = CGSizeMake(count * HYScreenW, 0);
    
}

#pragma mark - 设置标题渐变效果
- (void)setupTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(HYDisplayTitleLabel *)rightLabel leftLable:(HYDisplayTitleLabel *)leftLable {
    if (_isShowTitleGradient == NO) {
        return;
    }
    //获取右边放缩
    CGFloat rightScale = offsetX / HYScreenW - leftLable.tag;
    CGFloat leftScale = 1 - rightScale;
    
    //RGB渐变
    if (_titleColorGradientStyle == HYTitleColorGradientStyleRGB) {
        CGFloat r = _endR - _startR;
        CGFloat g = _endG - _startG;
        CGFloat b = _endB - _startB;
        
        //rightColor 1 0 0
        UIColor *rightColor = [UIColor colorWithRed:_startR + r * rightScale green:_startG + g * rightScale blue:_startB + b * rightScale alpha:1];
        
        UIColor *leftColor = [UIColor colorWithRed:_startR + r * leftScale green:_startG + g * leftScale blue:_startB + b * leftScale alpha:1];
        rightLabel.textColor = rightColor;
        leftLable.textColor = leftColor;
        return;
    }
    
    if (_titleColorGradientStyle == HYTitleColorGradientStyleFill) {
        //获取移动距离
        CGFloat offsetDelta = offsetX - _laseOffsetX;
        if (offsetDelta > 0) {//往右边
            rightLabel.textColor = self.norColor;
            rightLabel.fillColor = self.selectColor;
            rightLabel.progress = rightScale;
            
            leftLable.textColor = self.selectColor;
            leftLable.fillColor = self.norColor;
            leftLable.progress = rightScale;
        } else {//往左边
            rightLabel.textColor = self.norColor;
            rightLabel.fillColor = self.selectColor;
            rightLabel.progress = rightScale;
            
            leftLable.textColor = self.selectColor;
            leftLable.fillColor = self.norColor;
            leftLable.progress = rightScale;

        }
    }
    
}

#pragma mark - 标题缩放 
- (void)setupTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(HYDisplayTitleLabel *)rightLabel leftLabel:(HYDisplayTitleLabel *)leftLabel {
    if (_isShowTitleScale == NO) {
        return;
    }
    //获取右边缩放
    CGFloat rightScale = offsetX / HYScreenW - leftLabel.tag;
    CGFloat leftScale = 1 - rightScale;
    CGFloat scaleTransform = _titleScale ? _titleScale : HYTitleTransformScale;
    scaleTransform -= 1;
    
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform +1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform +1);
}

#pragma mark - 获取两个标题按钮宽度差值
- (CGFloat)widthDeltaWithRightLable:(UILabel *)rightLable leftLable:(UILabel *)leftLable {
    CGRect titleBoundsR = [rightLable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil];
    CGRect titleBoundsL = [leftLable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil];
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

#pragma mark - 设置下标偏移
- (void)setupUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLable leftLalbel:(UILabel *)leftLable {
    if (_isClickTitle) {
        return;
    }
    
    //获取两个标题中心点差距
    CGFloat centerDelta = rightLable.hy_x - leftLable.hy_x;
    //标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLable:rightLable leftLable:leftLable];
    //获取移动距离
    CGFloat offsetDelta = offsetX - _laseOffsetX;
    //计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / HYScreenW;
    //宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / HYScreenW;
    self.underLine.hy_width += underLineWidth;
    self.underLine.hy_x += underLineTransformX;
}

#pragma mark - 设置遮盖偏移量
- (void)setupCorverOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLable leftLalbel:(UILabel *)leftLable {
    if (_isClickTitle) {
        return;
    }
    
    //获取两个标题中心点差距
    CGFloat centerDelta = rightLable.hy_x - leftLable.hy_x;
    //标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLable:rightLable leftLable:leftLable];
    //获取移动距离
    CGFloat offsetDelta = offsetX - _laseOffsetX;
    //计算当前下划线偏移量
    CGFloat corverTransformX = offsetDelta * centerDelta / HYScreenW;
    //宽度递增偏移量
    CGFloat corverWidth = offsetDelta * widthDelta / HYScreenW;
    self.corverView.hy_width += corverWidth ;
    self.corverView.hy_x += corverTransformX;
}

#pragma mark - 标题点击处理
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (self.titleLabelsArrM.count) {
        UILabel *label = self.titleLabelsArrM[selectIndex];
        if (_selectIndex > self.titleLabelsArrM.count) {
            @throw [NSException exceptionWithName:@"HY_Error" reason:@"选中控制器的角标越界" userInfo:nil];
        }
        [self titleClick:[label.gestureRecognizers firstObject]];
    }
}

#pragma mark - 标题按钮点击
// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 记录是否点击标题
    _isClickTitle = YES;
    
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    // 获取当前角标
    NSInteger i = label.tag;
    
    // 选中label
    [self selectLabel:label];
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * HYScreenW;
    
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _laseOffsetX = offsetX;
    
    // 添加控制器
    UIViewController *vc = self.childViewControllers[i];
    
    // 判断控制器的view有没有加载，没有就加载，加载完在发送通知
    if (vc.view) {
        // 发出通知点击标题通知
        [[NSNotificationCenter defaultCenter] postNotificationName:HYDisplayViewClickOrScrollDidDinishNote object:vc];
        
        // 发出重复点击标题通知
        if (_selIndex == i) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HYDisplayViewRepeatClickTitleNote object:vc];
        }
    }
    
    _selIndex = i;
    
    // 点击事件处理完成
    _isClickTitle = NO;
}

- (void)selectLabel:(UILabel *)label
{
    
    for (HYDisplayTitleLabel *labelView in self.titleLabelsArrM) {
        
        if (label == labelView) continue;
        
        if (_isShowTitleGradient) {
            
            labelView.transform = CGAffineTransformIdentity;
        }
        
        labelView.textColor = self.norColor;
        
        if (_isShowTitleGradient && _titleColorGradientStyle == HYTitleColorGradientStyleFill) {
            
            labelView.fillColor = self.norColor;
            
            labelView.progress = 1;
        }
        
    }
    
    // 标题缩放
    if (_isShowTitleScale) {
        
        CGFloat scaleTransform = _titleScale?_titleScale:HYTitleTransformScale;
        
        label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    }
    
    // 修改标题选中颜色
    label.textColor = self.selectColor;
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标的位置
    if (_isShowUnderLine) {
        [self setUpUnderLine:label];
    }
    
    // 设置cover
    if (_isShowTitleCover) {
        [self setUpCoverView:label];
    }
    
}

// 设置蒙版
- (void)setUpCoverView:(UILabel *)label
{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGFloat border = 5;
    CGFloat coverH = titleBounds.size.height + 2 * border;
    CGFloat coverW = titleBounds.size.width + 2 * border;
    
    self.corverView.hy_y = (label.hy_height - coverH) * 0.5;
    self.corverView.hy_height = coverH;
    
    
    // 最开始不需要动画
    if (self.corverView.hy_x == 0) {
        self.corverView.hy_width = coverW;
        
        self.corverView.hy_x = label.hy_x - border;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.corverView.hy_width = coverW;
        
        self.corverView.hy_x = label.hy_x - border;
    }];
    
    
    
}

// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label
{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGFloat underLineH = _underLineH?_underLineH:HYUnderLineH;
    
    self.underLine.hy_y = label.hy_height - underLineH;
    self.underLine.hy_height = underLineH;
    
    
    // 最开始不需要动画
    if (self.underLine.hy_x == 0) {
        if (_isUnderLineEqualTitleWidth) {
            self.underLine.hy_width = titleBounds.size.width;
        } else {
            self.underLine.hy_width = label.hy_width;
        }
        
        self.underLine.hy_centerX = label.hy_centerX;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        if (_isUnderLineEqualTitleWidth) {
            self.underLine.hy_width = titleBounds.size.width;
        } else {
            self.underLine.hy_width = label.hy_width;
        }
        self.underLine.hy_centerX = label.hy_centerX;
    }];
    
}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - HYScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - HYScreenW + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - 刷新界面方法
// 更新界面
- (void)refreshDisplay
{
    if (self.childViewControllers.count == 0) {
        @throw [NSException exceptionWithName:@"YZ_ERROR" reason:@"请确定添加了所有子控制器" userInfo:nil];
    }
    
    // 清空之前所有标题
    [self.titleLabelsArrM makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.titleLabelsArrM removeAllObjects];
    
    // 刷新表格
    [self.contentScrollView reloadData];
    
    // 重新设置标题
    if (_titleColorGradientStyle == HYTitleColorGradientStyleFill || _titleWidth == 0) {
        
        [self setupTitleWidth];
    }
    
    [self setupAllTitle];
    
    // 默认选中标题
    self.selectIndex = self.selectIndex;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加控制器
    UIViewController *vc = self.childViewControllers[indexPath.row];
    
    vc.view.frame = CGRectMake(0, 0, self.contentScrollView.hy_width, self.contentScrollView.hy_height);
    
    CGFloat bottom = self.tabBarController == nil?0:49;
    CGFloat top = _isFullScreen?CGRectGetMaxY(self.titleScrollView.frame):0;
    if ([vc isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableViewVc = (UITableViewController *)vc;
        tableViewVc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    }
    
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

// 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger offsetXInt = offsetX;
    NSInteger screenWInt = HYScreenW;
    
    NSInteger extre = offsetXInt % screenWInt;
    if (extre > HYScreenW * 0.5) {
        // 往右边移动
        offsetX = offsetX + (HYScreenW - extre);
        _isAniming = YES;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else if (extre < HYScreenW * 0.5 && extre > 0){
        _isAniming = YES;
        // 往左边移动
        offsetX =  offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    // 获取角标
    NSInteger i = offsetX / HYScreenW;
    
    // 选中标题
    [self selectLabel:self.titleLabelsArrM[i]];
    
    // 取出对应控制器发出通知
    UIViewController *vc = self.childViewControllers[i];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HYDisplayViewClickOrScrollDidDinishNote object:vc];
}


// 监听滚动动画是否完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isAniming = NO;  
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 点击和动画的时候不需要设置
    if (_isAniming || self.titleLabelsArrM.count == 0) return;
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取左边角标
    NSInteger leftIndex = offsetX / HYScreenW;
    
    // 左边按钮
    HYDisplayTitleLabel *leftLabel = self.titleLabelsArrM[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    HYDisplayTitleLabel *rightLabel = nil;
    
    if (rightIndex < self.titleLabelsArrM.count) {
        rightLabel = self.titleLabelsArrM[rightIndex];
    }
    
    // 字体放大
    [self setupTitleScaleWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置下标偏移
    if (_isDelayScroll == NO) { // 延迟滚动，不需要移动下标
        
        [self setupUnderLineOffset:offsetX rightLabel:rightLabel leftLalbel:leftLabel];
    }
    
    // 设置遮盖偏移
    [self setupCorverOffset:offsetX rightLabel:rightLabel leftLalbel:leftLabel];
    
    // 设置标题渐变
    [self setupTitleColorGradientWithOffset:offsetX rightLabel:rightLabel leftLable:leftLabel];
    
    // 记录上一次的偏移量
    _laseOffsetX = offsetX;
}

#pragma mark - 颜色操作

- (void)setNorColor:(UIColor *)norColor
{
    _norColor = norColor;
    [self setupStartColor:norColor];
    
}


- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
    [self setupEndColor:selectColor];
}

- (void)setupStartColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _startR = components[0];
    _startG = components[1];
    _startB = components[2];
}

- (void)setupEndColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _endR = components[0];
    _endG = components[1];
    _endB = components[2];
}



/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
