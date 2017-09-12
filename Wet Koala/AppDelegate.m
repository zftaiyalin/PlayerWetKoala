//
//  AppDelegate.m
//  Wet Koala
//
//  Created by ed on 12/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "AppDelegate.h"
#import <SpriteKit/SpriteKit.h>
#import "YYModel.h"
#import "RedBoxModel.h"
#import "AppUnitl.h"
#import "NewViewController.h"
#import "ViewController.h"
@import Firebase;/*打乱代码结构*/

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    /*
     打乱代码结构
     */
    UMConfigInstance.appKey = @"59550dcc9f06fd1ad300003c";/*打乱代码结构*/
    UMConfigInstance.channelId = @"App Store";/*打乱代码结构*/
    [MobClick startWithConfigure:UMConfigInstance];/*打乱代码结构*///配置以上参数后调用此方法初始化SDK！
    
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-3676267735536366~1990082537"];/*打乱代码结构*/
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];/*打乱代码结构*/
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];/*打乱代码结构*/
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];/*打乱代码结构*/
    NSError *error = nil;/*打乱代码结构*/
    
    NSString *ss = [NSString stringWithFormat:@"http://opmams01o.bkt.clouddn.com/WetKoala.json?v=%@",currentDateString];/*打乱代码结构*/
    NSURL *xcfURL = [NSURL URLWithString:ss];/*打乱代码结构*/
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];/*打乱代码结构*/
    
    AppModel *model = [AppModel yy_modelWithJSON:htmlString];/*打乱代码结构*/
    
    [AppUnitl sharedManager].ssmodel = model;/*打乱代码结构*/
    [AppUnitl sharedManager].isGame = NO;/*打乱代码结构*/
    
    if (![AppUnitl getPreferredLanguage:[AppUnitl sharedManager].ssmodel.appstatus.language]) {
        [AppUnitl sharedManager].ssmodel.appstatus.isShow = NO;/*打乱代码结构*/
    }
//    [AppUnitl sharedManager].ssmodel.appstatus.isShow = YES;/*打乱代码结构*/
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];/*打乱代码结构*/
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];/*打乱代码结构*/
    self.window.backgroundColor = [UIColor whiteColor];/*打乱代码结构*/
   
    
    
    if (![AppUnitl sharedManager].ssmodel.appstatus.isShow) {
        [AppUnitl sharedManager].isGame = YES;/*打乱代码结构*/
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];/*打乱代码结构*/
        //将取出的storyboard里面的控制器被所需的控制器指着。
        ViewController *jVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"WetViewController"];/*打乱代码结构*/
//        [UIApplication sharedApplication].keyWindow.rootViewController = jVC;/*打乱代码结构*/
        
        self.window.rootViewController = jVC;/*打乱代码结构*/
        [self.window makeKeyAndVisible];/*打乱代码结构*/
    }else{
    
        self.window.rootViewController =[[UINavigationController alloc] initWithRootViewController:[[NewViewController alloc] init]] ;/*打乱代码结构*/
        [self.window makeKeyAndVisible];/*打乱代码结构*/
    }
    
    return YES;/*打乱代码结构*/
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // pause sprite kit
    if ([AppUnitl sharedManager].isGame) {
        SKView *view = (SKView *)self.window.rootViewController.view;/*打乱代码结构*/
        view.paused = YES;/*打乱代码结构*/
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state;/*打乱代码结构*/ here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // resume sprite kit
    if ([AppUnitl sharedManager].isGame) {
    SKView *view = (SKView *)self.window.rootViewController.view;/*打乱代码结构*/
    view.paused = NO;/*打乱代码结构*/
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
