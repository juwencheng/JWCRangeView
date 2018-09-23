//
// Created by 鞠汶成 on 2018/9/23.
// Copyright (c) 2018 Owen Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JWCRangeViewBlockBarViewDelegate <NSObject>
- (void)layoutFinished;
@end

@interface JWCRangeViewBlockBarView : UIView

- (CGFloat)calculateXPositionWithValue:(NSUInteger)value;

@property(nonatomic, weak) id <JWCRangeViewBlockBarViewDelegate> delegate;
@property(nonatomic, assign) NSUInteger numberOfBlock;
@property(nonatomic, assign) CGFloat blockSpacing;
@property(nonatomic, copy) UIColor *normalColor;
@property(nonatomic, copy) UIColor *highlightColor;
@property(nonatomic, assign) NSRange minmaxRange;
@property(nonatomic, assign) NSRange validRange;
@end
