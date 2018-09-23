//
// Created by 鞠汶成 on 2018/9/23.
// Copyright (c) 2018 Owen Ju. All rights reserved.
//

#import "JWCRangeViewBlockBarView.h"

@interface JWCRangeViewBlockBarView ()
@property(nonatomic, strong) NSArray *cachedFrames;
@property(nonatomic, assign) CGRect preBounds; // 避免layoutsubview在没必要的时候执行重绘操作
@property(nonatomic, assign) NSInteger valuePerBlock;
@end


@implementation JWCRangeViewBlockBarView

+ (Class)class {
    return [CAShapeLayer class];
}

+ (NSArray<NSValue *> *)blockFramesWithFrame:(CGRect)frame numberOfBlock:(NSInteger)numberOfBlock spacing:(CGFloat)spacing {
    if (numberOfBlock == 0) return nil;
    NSMutableArray *frames = [NSMutableArray array];
    CGFloat blockWidth = (frame.size.width - (numberOfBlock - 1) * spacing) / numberOfBlock;
    CGFloat blockHeight = frame.size.height;
    for (NSInteger i = 0; i < numberOfBlock; i++) {
        [frames addObject:[NSValue valueWithCGRect:CGRectMake(i * (blockWidth + spacing), 0, blockWidth, blockHeight)]];
    }
    return [frames copy];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self buildLayers];
}

- (void)buildLayers {
    if (CGRectEqualToRect(self.bounds, self.preBounds) && self.cachedFrames.count > 0) return;
    self.cachedFrames = [[self class] blockFramesWithFrame:self.frame numberOfBlock:self.numberOfBlock spacing:self.blockSpacing];

    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    NSUInteger numberOfBlock = self.numberOfBlock;
    self.valuePerBlock = self.minmaxRange.length / self.numberOfBlock;
    NSUInteger minIndex = self.validRange.location / self.valuePerBlock;
    NSUInteger maxIndex = (self.validRange.location + self.validRange.length) / self.valuePerBlock;
    while (numberOfBlock) {
        [self.layer addSublayer:[self createLayer:[self isHighlightLayer:numberOfBlock - 1 minIndex:minIndex maxIndex:maxIndex] frame:[self.cachedFrames[numberOfBlock - 1] CGRectValue]]];
        numberOfBlock--;
    }
    self.preBounds = self.bounds;
    if ([self.delegate respondsToSelector:@selector(layoutFinished)]) {
        [self.delegate layoutFinished];
    }
}

- (BOOL)isHighlightLayer:(NSUInteger)index minIndex:(NSUInteger)minIndex maxIndex:(NSUInteger)maxIndex {
    return index >= minIndex && index < maxIndex;
}

- (CAShapeLayer *)createLayer:(BOOL)highlight frame:(CGRect)frame {
    CAShapeLayer *blockLayer = [CAShapeLayer layer];
    blockLayer.frame = frame;
    blockLayer.backgroundColor = highlight ? self.highlightColor.CGColor : self.normalColor.CGColor;
    return blockLayer;
}

- (CGFloat)calculateXPositionWithValue:(NSUInteger)value {
    if (self.valuePerBlock == 0) return 0;
    if (value > self.minmaxRange.length) return self.bounds.size.width;
    NSInteger blockIndex = value / self.valuePerBlock;
    double percentageInBlock = (value % self.valuePerBlock) * 1.0 / self.valuePerBlock;
    return (CGFloat) ((self.bounds.size.width / self.numberOfBlock) * (blockIndex + percentageInBlock));
    //+ (percentageInBlock == 0 ? 0 : blockIndex * self.blockSpacing);
}

@end
