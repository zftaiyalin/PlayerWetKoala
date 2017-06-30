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
@import Firebase;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UMConfigInstance.appKey = @"59550dcc9f06fd1ad300003c";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-3676267735536366~1990082537"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSError *error = nil;
    
    NSString *ss = [NSString stringWithFormat:@"http://opmams01o.bkt.clouddn.com/WetKoala.json?v=%@",currentDateString];
    NSURL *xcfURL = [NSURL URLWithString:ss];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    
    AppModel *model = [AppModel yy_modelWithJSON:htmlString];
    
    [AppUnitl sharedManager].ssmodel = model;
    [AppUnitl sharedManager].isGame = NO;
    [AppUnitl sharedManager].ssmodel.appstatus.isShow = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController =[[UINavigationController alloc] initWithRootViewController:[[NewViewController alloc] init]] ;
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // pause sprite kit
    if ([AppUnitl sharedManager].isGame) {
        SKView *view = (SKView *)self.window.rootViewController.view;
        view.paused = YES;
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // resume sprite kit
    if ([AppUnitl sharedManager].isGame) {
    SKView *view = (SKView *)self.window.rootViewController.view;
    view.paused = NO;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
