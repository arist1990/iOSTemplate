//
//  ViewController.h
//  iOSTemplate
//
//  Created by ARIST on 2017/8/23.
//  Copyright © 2017年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) NSURLSessionTask *task;

@property (weak, nonatomic) IBOutlet CardView *cardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardViewHeightConstraint;


@end

