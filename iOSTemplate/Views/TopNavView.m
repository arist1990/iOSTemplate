//
//  TopNavView.m
//  BigMouse
//
//  Created by ARIST on 15/8/19.
//  Copyright (c) 2015年 深圳市葵花子科技有限公司. All rights reserved.
//

#import "TopNavView.h"

@implementation TopNavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"TopNavView" owner:self options:nil] lastObject];
        self.height = 64;
        view.frame = CGRectMake(0, 20, ScreenWidth, 44);
        
        _titleLabel.text = @"";
        
        _viewSep.backgroundColor = [UIColor clearColor];
        _leftNavBtn.tintColor = [UIColor whiteColor];
        _rightNavBtn.tintColor = [UIColor whiteColor];
        
        [_leftNavBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_rightNavBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        
        _constantViewSepHeight.constant = .5;
        
        self.backgroundColor = kColorStyle;
        
        [self addSubview:view];
    }
    return self;
}

@end
