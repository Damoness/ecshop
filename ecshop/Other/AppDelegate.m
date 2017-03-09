//
//  AppDelegate.m
//  ecshop
//
//  Created by jsyh-mac on 15/11/30.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "MyViewController.h"
#import "MyTabBarViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UserGuideViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"
#import "H5ViewController.h"
#import "AlipayApiManager.h"
#import "UserGuideViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyWindow];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *UMSharekey = data[@"UMSharekey"];
    NSString *WXAppId = data[@"WXAppId"];
    NSString *WXappSecret = data[@"WXappSecret"];
    NSString *url = data[@"url"];
    NSString *QQWithAppId = data[@"QQWithAppId"];
    NSString *QQappKey = data[@"QQappKey"];
    
    
    
//    UIImage *backButtonImage = [[UIImage imageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    UIImage *backButtonImage = [[UIImage imageNamed:@"nav_arrow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    //UIImage *backButtonImage  = [UIImage imageNamed:@"nav_arrow"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:kColor_NavigationBar_TitleColor}];
    [UINavigationBar appearance].barTintColor = kColor_NavigationBar_BarTintColor;
    
    //[UINavigationBar appearance].backgroundColor = RGB(230, 37, 137);
    
//    //友盟分享
//    [UMSocialData setAppKey:UMSharekey];
//    //微信分享
//    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXappSecret url:url];
//    //手机qq分享
//    [UMSocialQQHandler setQQWithAppId:QQWithAppId appKey:QQappKey url:url];
//    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    
    //向微信注册wx40fbb60e2d770512
    [WXApi registerApp:MXWechatAPPID];


    
    UIViewController *vc = [self h5RootViewController];
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"kHasLaunched"]) {
        
        
        UserGuideViewController *ugVC =  [[UserGuideViewController alloc]initWithRootViewController:vc];
    
        self.window.rootViewController = ugVC;
        
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"kHasLaunched"];
        
    }else{
        
        self.window.rootViewController = vc;
        
    }
    
    return YES;    
}



//h5版本
-(UIViewController *)h5RootViewController{
    
    
    
    H5ViewController *h5VC = [H5ViewController new];
    
    //UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:h5VC];
    
    //self.window.rootViewController = h5VC;
    
    
    return h5VC;
}


//原生版本
-(UIViewController *)nativeRootViewController{
    
    
    FirstViewController *first=[[FirstViewController alloc]init];
    
    UINavigationController *firstNV = [[UINavigationController alloc]initWithRootViewController:first];
    
    SecondViewController *second=[[SecondViewController alloc]init];
    UINavigationController *secondNV = [[UINavigationController alloc]initWithRootViewController:second];
    ThirdViewController *third=[[ThirdViewController alloc]init];
    
    UINavigationController *thirdNV = [[UINavigationController alloc]initWithRootViewController:third];
    FourthViewController *fourth=[[FourthViewController alloc]init];
    UINavigationController *fourthNV = [[UINavigationController alloc]initWithRootViewController:fourth];
    
    MyViewController *myVC = [[MyViewController alloc]init];
    UINavigationController *myNV = [[UINavigationController alloc]initWithRootViewController:myVC];
    
    NSArray *array=@[firstNV,secondNV,thirdNV,myNV];
    
    MyTabBarViewController *tab=[[MyTabBarViewController alloc]init];
    
    tab.viewControllers=array;
    
    UIButton * button = [[UIButton alloc]init];
    button.tag = 100;
    [tab buttonClicked:button];
    
    //tab.delegate=self;
    
    
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(popUserLogin) name:kNotification_User_UnLogin object:nil];
    
#pragma mark --接收登录通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(loginSuccess:) name:kNotification_Login_Success object:nil];
#pragma mark --接收退出通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(quiteSuccess:) name:@"quite" object:nil];
    

    return tab;
    
}


//-(void)gotoDaoHangYe
//{
//    NSFileManager *manager = [NSFileManager defaultManager];
//    [manager createFileAtPath:[NSHomeDirectory() stringByAppendingString:@"/aa.text"] contents:nil attributes:nil];
//    
//    [UIView animateWithDuration:0.2 animations:^{
//      UIImageView
//        
//    } completion:^(BOOL finished) {
////        [scrollView removeFromSuperview];
////        [pageCtr removeFromSuperview];
//        
//    }];
//}

-(void)popUserLogin{
    
    
    LoginViewController *lVC = [LoginViewController new];
    
    [self.window.rootViewController presentViewController:lVC animated:YES completion:nil];
    
}

-(void)loginSuccess:(NSNotification *)sender{
    NSLog(@"%@",sender.object);
    NSDictionary *dic = sender.object;
    self.tempDic = dic[@"dic"];
    self.userName = dic[@"userName"];
}
-(void)quiteSuccess:(NSNotification *)sender{
    self.tempDic = nil;
    self.userName = nil;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    if ([url.absoluteString hasPrefix:MXWechatAPPID]) {
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    }else if([url.host isEqualToString:@"safepay"]){
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            [[AlipayApiManager sharedManager]handleAlipayResult:resultDic];
            
        }];
        return YES;
    }
    
    return YES;
    
}

-(CGRect)createFrameWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
    {
        return CGRectMake(x * (WIDTH / 375.0), y * (HEIGHT/667.0), width * (WIDTH / 375.0), height * (HEIGHT / 667.0));
    }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.absoluteString hasPrefix:MXWechatAPPID]) {
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    }else if([url.host isEqualToString:@"safepay"]){
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            [[AlipayApiManager sharedManager]handleAlipayResult:resultDic];
            
        }];
        return YES;
    }
             
    return YES;

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    return YES;
}

@end
