//
//  JWCRangeBottomView.h
//  JWCRangeView
//
//  Created by 鞠汶成 on 2018/9/23.
//

#import <UIKit/UIKit.h>

@interface JWCRangeBottomView : UIView

- (void)updateMinLabelPosition:(CGFloat)position;

- (void)updateMaxLabelPosition:(CGFloat)position;

@property(nonatomic, strong) UILabel *hintLabel;
@property(nonatomic, strong) UILabel *minLabel;
@property(nonatomic, strong) UILabel *maxLabel;

@end
