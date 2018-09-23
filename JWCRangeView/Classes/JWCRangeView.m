//
//  JWCRangeView.m
//  JWCRangeView_Example
//
//  Created by 鞠汶成 on 2018/9/22.
//  Copyright © 2018年 Owen Ju. All rights reserved.
//

#import "JWCRangeView.h"
#import "JWCRangeViewBlockBarView.h"
#import "JWCRangeBottomView.h"
#import "JWCRangeTopView.h"

@interface JWCRangeView () <JWCRangeViewBlockBarViewDelegate>

@property(nonatomic, strong) JWCRangeViewStyle *style;
// 每个块的值
@property(nonatomic, assign) NSInteger valuePerBlock;

//@property(nonatomic, assign) NSRange minmaxRange;

//@property(nonatomic, assign) NSRange validRange;

@property(nonatomic, strong) JWCRangeViewBlockBarView *blockBarView;

@property(nonatomic, strong) JWCRangeTopView *topView;
@property(nonatomic, strong) JWCRangeBottomView *bottomView;

@end

/**
 * 问题
 * 1. block由layer构成，block width = (frame width - blockSpacing * (numberOfblock - )) / numberOfBlock;
 * 2. 支持自动布局的话，需要在 layoutsubview 里面重写布局的frame，不支持的话，无法支持旋转操作，还是支持吧，判断frame有没有改变，如果没有就不改变里面的值
 * 3. 最麻烦的是箭头指向，可能和label冲突
 * 4. 构成：blockView indicatorView 4个label
 */
@implementation JWCRangeView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)commonInit {
    [self addSubview:self.bottomView];
    [self addSubview:self.topView];
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.topView.heightAnchor constraintEqualToConstant:30] setActive:YES];
    [[self.topView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[self.topView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.topView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
    if (_blockBarView == nil) {
        _blockBarView = [[JWCRangeViewBlockBarView alloc] initWithFrame:CGRectZero];
        _blockBarView.delegate = self;
        [self addSubview:_blockBarView];
        _blockBarView.translatesAutoresizingMaskIntoConstraints = NO;
        [[_blockBarView.heightAnchor constraintEqualToConstant:12] setActive:YES];
        [[_blockBarView.topAnchor constraintEqualToAnchor:self.topView.bottomAnchor constant:8] setActive:YES];
        [[_blockBarView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
        [[_blockBarView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
    }

    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.bottomView.heightAnchor constraintEqualToConstant:20] setActive:YES];
    [[self.bottomView.topAnchor constraintEqualToAnchor:self.blockBarView.bottomAnchor constant:8] setActive:YES];
    [[self.bottomView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.bottomView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
    [[self.bottomView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
}

- (void)applyStyle:(JWCRangeViewStyle *)style {
    _style = style;
    [self validateParameter];
    self.blockBarView.blockSpacing = self.style.blockSpacing;
    self.blockBarView.numberOfBlock = self.style.numberOfBlock;
    self.blockBarView.normalColor = self.style.normalColor;
    self.blockBarView.highlightColor = self.style.highlightColor;
    self.blockBarView.minmaxRange = self.style.minmaxRange;
    self.blockBarView.validRange = self.style.validRange;

    self.bottomView.hintLabel.font = self.style.hintFont;
    self.bottomView.hintLabel.textColor = self.style.hintColor;

    self.bottomView.minLabel.font = self.style.valueFont;
    self.bottomView.minLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) self.style.validRange.location];
    self.bottomView.minLabel.textColor = self.style.highlightColor;

    self.bottomView.maxLabel.font = self.style.valueFont;
    self.bottomView.maxLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) (self.style.validRange.location + self.style.validRange.length)];
    self.bottomView.maxLabel.textColor = self.style.highlightColor;

    self.topView.indicatorView.backgroundColor = self.style.highlightColor;
    self.topView.hintLabel.textColor = self.style.hintColor;
    self.topView.hintLabel.font = self.style.hintFont;
    self.topView.valueLabel.textColor = self.style.highlightColor;
    self.topView.valueLabel.font = self.style.valueFont;
}

- (void)validateParameter {
    if (self.style.numberOfBlock == 0)
        @throw [NSException exceptionWithName:@"参数异常" reason:@"numberOfBloc 不能为0" userInfo:nil];
    if (self.style.minmaxRange.length == 0)
        @throw [NSException exceptionWithName:@"参数异常" reason:@"minmaxRange 区间不能为0" userInfo:nil];
    if (self.style.validRange.length == 0)
        @throw [NSException exceptionWithName:@"参数异常" reason:@"validRange 区间不能为0" userInfo:nil];
    if (self.style.minmaxRange.length < (self.style.validRange.length + self.style.validRange.location))
        @throw [NSException exceptionWithName:@"参数异常" reason:@"validRange 区间超过 minmax 区间" userInfo:nil];
    self.valuePerBlock = (self.style.minmaxRange.location + self.style.minmaxRange.location) / self.style.numberOfBlock;
    if (self.style.validRange.location % self.style.numberOfBlock != 0 || (self.style.validRange.location + self.style.validRange.length) % self.style.numberOfBlock != 0) {
        @throw [NSException exceptionWithName:@"参数异常" reason:@"validRange 的开始区间和结束区间必须能整除" userInfo:nil];
    }
}

- (void)layoutFinished {
    [self.bottomView updateMinLabelPosition:[self.blockBarView calculateXPositionWithValue:self.style.validRange.location]];
    [self.bottomView updateMaxLabelPosition:[self.blockBarView calculateXPositionWithValue:(self.style.validRange.location + self.style.validRange.length)]];
}

- (void)setValue:(NSInteger)value {
    _value = value;
    [self.topView updateValueLabelPosition:[self.blockBarView calculateXPositionWithValue:value] value:value];
}

- (JWCRangeTopView *)topView {
    if (!_topView) {
        _topView = [JWCRangeTopView new];
        _topView.hintLabel.text = @"目前心率";
    }
    return _topView;
}

- (JWCRangeBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JWCRangeBottomView alloc] init];
        _bottomView.hintLabel.text = @"适宜心率";
        _bottomView.hintLabel.font = [UIFont systemFontOfSize:12];
    }
    return _bottomView;
}
@end

@implementation JWCRangeViewStyle

@end


