//
//  TabViewController.m
//  BigMouse
//
//  Created by ARIST on 15/8/19.
//  Copyright (c) 2015年 深圳市葵花子科技有限公司. All rights reserved.
//

#import "TabViewController.h"
#import "ViewController.h"


@interface TabViewController ()

@end

@implementation TabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    [self initViewControllers];
    [self initCustomTabBar];
    
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// 首页、个人中心、更多
- (void)initViewControllers{
//    ViewController *vc1 = [[ViewController alloc] init];
//    ViewController *vc2 = [[ViewController alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    ViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    NSArray *array = @[vc1, vc2];
    _vcArrs = [[NSMutableArray alloc] init];
    [_vcArrs addObjectsFromArray:array];
    
    [self setViewControllers:_vcArrs animated:NO];
}

- (void)initCustomTabBar{
    _tabBarBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.height-kTabBarHeight, ScreenWidth, kTabBarHeight)];
    
    _tabBarBack.backgroundColor = [UIColor whiteColor];
    _tabBarBack.userInteractionEnabled = YES;
    [self.view addSubview:_tabBarBack];

    
    NSArray *arrImageNormal = @[@"tabHomeoff", @"tabDiscoveryoff"];
    NSArray *arrImagePressed = @[@"tabHomeon", @"tabDiscoveryon"];

    NSInteger count = [_vcArrs count];
    for (int index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.frame = CGRectMake(index * (ScreenWidth/count), 0, (ScreenWidth/count), kTabBarHeight);
        [button setImage:[UIImage imageNamed:arrImageNormal[index]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:arrImagePressed[index]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:arrImagePressed[index]] forState:UIControlStateSelected];
        
       
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.imageView.clipsToBounds = YES;
        if (index == 0) {
            [button setSelected:YES];
        }
        [button addTarget:self action:@selector(changeTabBarButtonBackground:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarBack addSubview:button];
        
    }
    
}

- (void)changeTabBarButtonBackground:(UIButton *)button {
    
    self.selectedIndex = button.tag;
    
    for (UIButton *btn in _tabBarBack.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setSelected:NO];
        }
    }
    [button setSelected:YES];
}







@end
