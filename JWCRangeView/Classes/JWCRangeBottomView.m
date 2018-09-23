//
//  JWCRangeBottomView.m
//  JWCRangeView
//
//  Created by 鞠汶成 on 2018/9/23.
//

#import "JWCRangeBottomView.h"

@interface JWCRangeBottomView ()

@property(nonatomic, strong) NSLayoutConstraint *minLabelCenterX;
@property(nonatomic, strong) NSLayoutConstraint *maxLabelCenterX;

@end

@implementation JWCRangeBottomView

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
    [self addSubview:self.hintLabel];
    [self addSubview:self.minLabel];
    [self addSubview:self.maxLabel];
    self.hintLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.minLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.maxLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewDictionary = @{@"hintLabel": self.hintLabel, @"minLabel": self.minLabel, @"maxLabel": self.maxLabel};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[minLabel]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[maxLabel]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[hintLabel]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[hintLabel]-(>=0@1000)-[minLabel]-(>=0@1000)-[maxLabel]-(>=0@1000)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:viewDictionary]];
    self.minLabelCenterX = [NSLayoutConstraint constraintWithItem:self.minLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    self.maxLabelCenterX = [NSLayoutConstraint constraintWithItem:self.maxLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
}

- (void)updateMinLabelPosition:(CGFloat)position {
    // position - width / 2
    self.minLabelCenterX.constant = position - self.minLabel.frame.size.width / 2;
    [self.minLabelCenterX setActive:YES];
}

- (void)updateMaxLabelPosition:(CGFloat)position {
    self.maxLabelCenterX.constant = position - self.maxLabel.frame.size.width / 2;
    [self.maxLabelCenterX setActive:YES];
}


- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [UILabel new];
    }
    return _hintLabel;
}

- (UILabel *)minLabel {
    if (!_minLabel) {
        _minLabel = [UILabel new];
    }
    return _minLabel;
}

- (UILabel *)maxLabel {
    if (!_maxLabel) {
        _maxLabel = [UILabel new];
    }
    return _maxLabel;
}

@end

