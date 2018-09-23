//
//  JWCRangeTopView.h
//  JWCRangeView
//
//  Created by 鞠汶成 on 2018/9/23.
//

#import <UIKit/UIKit.h>

@interface JWCRangeTopView : UIView

- (void)updateValueLabelPosition:(CGFloat)position value:(NSInteger)value;


@property(nonatomic, strong) UILabel *hintLabel;
@property(nonatomic, strong) UILabel *valueLabel;
@property(nonatomic, strong) UIView *indicatorView;

@end
