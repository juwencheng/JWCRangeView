//
//  JWCRangeView.h
//  JWCRangeView_Example
//
//  Created by 鞠汶成 on 2018/9/22.
//  Copyright © 2018年 Owen Ju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCRangeViewStyle : NSObject

/**
 * 上面label文字
 */
@property(nonatomic, copy, nullable) NSString *topHint;
/**
 * 下面label文字
 */
@property(nonatomic, copy, nullable) NSString *bottomHint;
/**
 * 高亮激活的颜色
 */
@property(nonatomic, copy) UIColor *highlightColor;
/**
 * 普通的颜色
 */
@property(nonatomic, copy) UIColor *normalColor;
/**
 * label的颜色
 */
@property(nonatomic, copy) UIColor *hintColor;

/*
 * label 字体
 */
@property(nonatomic, copy) UIFont *hintFont;


/*
 * 值的字体
 */
@property(nonatomic, copy) UIFont *valueFont;

/**
 * 块的数量
 */
@property(nonatomic, assign) NSUInteger numberOfBlock;

/**
 * 最大值和最小值的区间
 */
@property(nonatomic, assign) NSRange minmaxRange;

/**
 * 有效区间
 */
@property(nonatomic, assign) NSRange validRange;

/**
 * 块之间的间距
 */
@property(nonatomic, assign) CGFloat blockSpacing;

@end

@interface JWCRangeView : UIView

/**
 * 当前值
 */
@property(nonatomic, assign) NSInteger value;

/*
 * 应用样式
 */
- (void)applyStyle:(JWCRangeViewStyle *)style;

@end
