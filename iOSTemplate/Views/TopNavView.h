//
//  TopNavView.h
//  BigMouse
//
//  Created by ARIST on 15/8/19.
//  Copyright (c) 2015年 深圳市葵花子科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopNavView : UIView

@property (weak, nonatomic) IBOutlet UIButton *leftNavBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightNavBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *viewSep;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantViewSepHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLeftBtnLeftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantRightBtnRightMargin;


@end
