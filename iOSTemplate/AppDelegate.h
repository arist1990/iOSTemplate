//
//  AppDelegate.h
//  iOSTemplate
//
//  Created by ARIST on 2017/8/23.
//  Copyright © 2017年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMDrawerController.h"
#import "TabViewController.h"
#import "ViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) MMDrawerController * drawerController;


@end

