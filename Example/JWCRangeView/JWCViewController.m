//
//  JWCViewController.m
//  JWCRangeView
//
//  Created by Owen Ju on 09/22/2018.
//  Copyright (c) 2018 Owen Ju. All rights reserved.
//

#import <JWCRangeView/JWCRangeView.h>
#import "JWCViewController.h"

@interface JWCViewController () {
    NSTimer *timer;
    JWCRangeView *rangeView;
    NSInteger value;
}

@end

@implementation JWCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	rangeView = [[JWCRangeView alloc] initWithFrame:CGRectMake(20, 100, UIScreen.mainScreen.bounds.size.width-40, 10)];
    JWCRangeViewStyle *style = [[JWCRangeViewStyle alloc] init];
	style.blockSpacing = 3;
	style.numberOfBlock = 10;
	style.normalColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
	style.highlightColor = [UIColor colorWithRed:26/255.0 green:209/255.0 blue:163/255.0 alpha:1];
	style.minmaxRange = NSMakeRange(0, 200);
	style.validRange = NSMakeRange(80, 60);
    style.hintFont = [UIFont systemFontOfSize:12];
    style.hintColor = [UIColor colorWithWhite:0.2 alpha:1];
    style.valueFont = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:rangeView];
	rangeView.translatesAutoresizingMaskIntoConstraints = NO;
	[[rangeView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
	[[rangeView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant: 30] setActive:YES];
	[[rangeView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -30] setActive:YES];
    [rangeView applyStyle:style];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.016 target:self selector:@selector(update) userInfo:nil repeats:YES];
//    [timer fire];
}

- (void)update {
    rangeView.value = value;
    value++;
    if (value > 160) {
        [timer invalidate];
    }
}

@end
