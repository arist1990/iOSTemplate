//
//  MyNavigationController.h
//  BigMouse
//
//  Created by ARIST on 15/8/19.
//  Copyright (c) 2015年 深圳市葵花子科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;

@property (nonatomic, retain) UIPanGestureRecognizer *recognizer;

@property (nonatomic,retain) NSMutableArray *screenShotsList;

@end
