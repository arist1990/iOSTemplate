//
//  BaseViewController.m
//  BigMouse
//
//  Created by ARIST on 15/8/19.
//  Copyright (c) 2015年 深圳市葵花子科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
//#import "StartUpViewController.h"
#import "MyNavigationController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:[UIView new] atIndex:0];
    
    self.view.backgroundColor = kColorBackground;
    
    _topNavView = [[TopNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:_topNavView];
    
    [_topNavView.leftNavBtn addTarget:self action:@selector(leftEvent) forControlEvents:UIControlEventTouchUpInside];
    [_topNavView.rightNavBtn addTarget:self action:@selector(rightEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar setBarTintColor:kColorStyle];      // 导航栏及状态栏颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];       // 返回按钮那里的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];     // 改变标题字体
    
    
    bShowTip = YES;
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**导航按钮事件
 */
- (void)leftEvent {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightEvent {
    
}

- (void)configLeftBtn:(BOOL)show textNormal:(NSString *)textNormal textHighlighted:(NSString *)textHighlighted {
    _topNavView.leftNavBtn.hidden = !show;
    if (textNormal && textNormal.length > 0) {
        [_topNavView.leftNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_topNavView.leftNavBtn setTitle:textNormal forState:UIControlStateNormal];
        [_topNavView.leftNavBtn setTitle:textNormal forState:UIControlStateDisabled];
    }
    if (textHighlighted && textHighlighted.length > 0) {
        [_topNavView.leftNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_topNavView.leftNavBtn setTitle:textNormal forState:UIControlStateHighlighted];
    }
    _topNavView.constantLeftBtnLeftMargin.constant = -10;
}

- (void)configLeftBtn:(BOOL)show imageNormal:(NSString *)imageNormal imageHighlighted:(NSString *)imageHighlighted {
    _topNavView.leftNavBtn.hidden = !show;
    if (imageNormal && imageNormal.length > 0) {
        [_topNavView.leftNavBtn setImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
        [_topNavView.leftNavBtn setTitle:@"" forState:UIControlStateNormal];
    }
    if (imageHighlighted && imageHighlighted.length > 0) {
        [_topNavView.leftNavBtn setImage:[UIImage imageNamed:imageHighlighted] forState:UIControlStateSelected];
        [_topNavView.leftNavBtn setTitle:@"" forState:UIControlStateHighlighted];
    }
    _topNavView.constantLeftBtnLeftMargin.constant = -18;
}

- (void)configRightBtn:(BOOL)show textNormal:(NSString *)textNormal textHighlighted:(NSString *)textHighlighted {
    _topNavView.rightNavBtn.hidden = !show;
    if (textNormal && textNormal.length > 0) {
        [_topNavView.rightNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_topNavView.rightNavBtn setTitle:textNormal forState:UIControlStateNormal];
        [_topNavView.rightNavBtn setTitle:textNormal forState:UIControlStateDisabled];
    }
    if (textHighlighted && textHighlighted.length > 0) {
        [_topNavView.rightNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_topNavView.rightNavBtn setTitle:textNormal forState:UIControlStateHighlighted];
    }
       
    _topNavView.constantRightBtnRightMargin.constant = -10;
}
- (void)configRightBtn:(BOOL)show imageNormal:(NSString *)imageNormal imageHighlighted:(NSString *)imageHighlighted {
    _topNavView.rightNavBtn.hidden = !show;
    if (imageNormal && imageNormal.length > 0) {
        [_topNavView.rightNavBtn setImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
        [_topNavView.rightNavBtn setTitle:@"" forState:UIControlStateNormal];
    }
    if (imageHighlighted && imageHighlighted.length > 0) {
        [_topNavView.rightNavBtn setImage:[UIImage imageNamed:imageHighlighted] forState:UIControlStateSelected];
        [_topNavView.rightNavBtn setTitle:@"" forState:UIControlStateHighlighted];
    }
    _topNavView.constantRightBtnRightMargin.constant = -10;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    bShowTip = YES;
//    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
    // 若为1级页面，不出现返回按钮
    if (self.navigationController.viewControllers.count == 1) {
        [self configLeftBtn:NO textNormal:nil textHighlighted:nil];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    bShowTip = NO;
//    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
}

/***
 * 此函数用来判断是否网络连接服务器正常
 * 需要导入Reachability类
 */
- (BOOL)isNetworkReachable {
    BOOL isExistenceNetwork = NO;
    Reachability *reachability = [Reachability reachabilityWithHostname:@"http://www.baidu.com"];  // 测试服务器状态
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        default:
            break;
    }
    return  isExistenceNetwork;
}

/** 中间显示提示
 */
- (void)showCenterTip:(NSString *)tip{
    if (bShowTip) {
        [Toast showWithText:tip duration:2];
    }
}

/** 显示提示
 */
- (void)showBottomTip:(NSString *)tip{
    if (bShowTip) {
        [Toast showWithText:tip bottomOffset:80 duration:2];
    }
}

- (void)tapHideProgress:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self hideProgress];
    }
}

/** 显示loading
 */
- (void)showProgress{
    NSLog(@"showProgress");
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    }
//    
//    _progressHUD.labelText = @"加载中...";
//    [self.view addSubview:_progressHUD];
//    [_progressHUD show:YES];
//    [_progressHUD hide:YES afterDelay:5];
    
    if (_viewLoadingWrap == nil) {
        _viewLoadingWrap = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _ivImageLoading = [[UIImageView alloc] initWithFrame:_viewLoadingWrap.frame];
        _ivImageLoading.contentMode = UIViewContentModeScaleAspectFit;
        [_viewLoadingWrap addSubview:_ivImageLoading];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideProgress:)];
        [_viewLoadingWrap addGestureRecognizer:tap];
    }
    
    //设置动画帧
    _ivImageLoading.animationImages=[NSArray arrayWithObjects:
                             [UIImage imageNamed:@"fac_1"],
                             [UIImage imageNamed:@"fac_2"],
                             [UIImage imageNamed:@"fac_3"], nil];
    
    //设置动画总时间
    _ivImageLoading.animationDuration = .6f;
    //设置重复次数，0表示不重复
    _ivImageLoading.animationRepeatCount = NSIntegerMax;
    //开始动画
    [_ivImageLoading startAnimating];
    
    [self.view addSubview:_viewLoadingWrap];
    
}

/** 显示loading
 */
- (void)showProgress:(NSString *)text{
    [self showProgress];
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//        _progressHUD.color = kColorStyle;
//    }
//    
//    _progressHUD.labelText = (text == nil || [@"" isEqualToString:text]) ? @"加载中..." : text;
//    [self.view addSubview:_progressHUD];
//    [_progressHUD show:YES];
//    [_progressHUD hide:YES afterDelay:5];
}

- (void)showProgress:(NSString *)text exit:(BOOL)exit{
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    }
//    
//    _progressHUD.labelText = (text == nil || [@"" isEqualToString:text]) ? @"加载中..." : text;
//    [self.view addSubview:_progressHUD];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideProgressWithNotify)];
//    [_progressHUD addGestureRecognizer:tap];
//    
//    [_progressHUD show:YES];
//    if (exit) {
//        [_progressHUD hide:YES afterDelay:5];
//    }
    [self showProgress];
}

/** 隐藏loading
 */
- (void)hideProgress{
    
    NSLog(@"hideProgress");
    
//    if (_progressHUD) {
//        [_progressHUD hide:YES];
//        [_progressHUD removeFromSuperview];
//    }
    
    if (_viewLoadingWrap != nil && _viewLoadingWrap.superview != nil) {
        [_viewLoadingWrap removeFromSuperview];
    }
    if (_ivImageLoading != nil) {
        [_ivImageLoading stopAnimating];
    }
    
}

/** 隐藏loading
 */
- (void)hideProgressWithNotify{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyHUDProgressHide object:nil];
//    if (_progressHUD) {
//        [_progressHUD hide:YES];
//        [_progressHUD removeFromSuperview];
//    }
}

- (void)showTip:(BOOL)show{
    bShowTip = show;
}

//- (void)toLogin{
//    [self showCenterTip:@"请重新登录"];
//    
//    StartUpViewController *ctrl = [[StartUpViewController alloc] init];
//    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:ctrl];
//    nav.navigationBarHidden = YES;
//    nav.interactivePopGestureRecognizer.enabled = NO;
//    
//    [self releaseRootVC];
//    
//    // 注册登录用户信息清楚
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if(!window) {
//        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
//    }
//    window.rootViewController = nav;
//}

- (void)setNavGestureEnable:(BOOL)enable {
    MyNavigationController *nav = (MyNavigationController *)self.navigationController;
    if ([nav isKindOfClass:[MyNavigationController class]]) {
        nav.canDragBack = enable;
    }
}

- (void)releaseRootVC{
    // 释放内存
    MyNavigationController *navCurrent = (MyNavigationController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    if ([navCurrent isKindOfClass:[MyNavigationController class]]) {
        for (NSInteger i=0; i<navCurrent.viewControllers.count; i++) {
            UIViewController *c = navCurrent.viewControllers[i];
            c = nil;
        }
        navCurrent = nil;
    }
}

@end
