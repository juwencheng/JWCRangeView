//
//  JWCRangeTopView.m
//  JWCRangeView
//
//  Created by 鞠汶成 on 2018/9/23.
//

#import "JWCRangeTopView.h"

@interface JWCRangeTopView()

@property (nonatomic, strong) NSLayoutConstraint *valueLeadingConst;

@end

@implementation JWCRangeTopView

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

- (void)commonInit {
    [self addSubview:self.hintLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.indicatorView];
    self.hintLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.indicatorView.widthAnchor constraintEqualToConstant:15] setActive:YES];
    [[self.indicatorView.heightAnchor constraintEqualToConstant:8] setActive:YES];
    
    [[self.hintLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];
    [[self.hintLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.valueLabel.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[valueLabel]-(>=0@1000)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"valueLabel": self.valueLabel}]];
//    [[self.valueLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor] setActive:YES];
    [[self.valueLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.hintLabel.trailingAnchor constant:0] setActive:YES];
    [[self.indicatorView.centerXAnchor constraintEqualToAnchor:self.valueLabel.centerXAnchor constant:0] setActive:YES];
    [[self.indicatorView.topAnchor constraintEqualToAnchor:self.valueLabel.bottomAnchor constant:4] setActive:YES];
    [[self.indicatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    [self.valueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.hintLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh+2 forAxis:UILayoutConstraintAxisHorizontal];

    
    self.valueLeadingConst = [NSLayoutConstraint constraintWithItem:self.valueLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
}

- (void)updateValueLabelPosition:(CGFloat)position value:(NSInteger)value{
    self.indicatorView.hidden = NO;
    self.valueLabel.text = [NSString stringWithFormat:@"%ld", (long) value];
    [self.valueLabel sizeToFit];
    self.valueLeadingConst.constant = position  - self.valueLabel.frame.size.width/2;
    [self.valueLeadingConst setActive:YES];
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [UILabel new];
        _hintLabel.text = @"适宜心率";
    }
    return _hintLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
    }
    return _valueLabel;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 8)];
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_indicatorView.bounds.size.width, 0)];
        [path addLineToPoint:CGPointMake(_indicatorView.bounds.size.width/2, _indicatorView.bounds.size.height)];
        [path closePath];
        layer.path = path.CGPath;
        layer.lineJoin = kCALineJoinRound;
        _indicatorView.layer.mask = layer;
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

@end
