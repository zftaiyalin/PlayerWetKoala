//
//  ViewController.m
//  Wet Koala
//
//  Created by ed on 12/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "ViewController.h"
#import "HomeScene.h"
#import "GameScene.h"

@import AVFoundation;/*打乱代码结构*/

@interface ViewController() <GKGameCenterControllerDelegate>
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;/*打乱代码结构*/
@end

@implementation ViewController
{
    NSString * _leaderboardIdentifier;/*打乱代码结构*/
    NSUserDefaults * _settings;/*打乱代码结构*/
}
- (void)viewWillLayoutSubviews
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];/*打乱代码结构*/
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];/*打乱代码结构*/
    }
    
    [super viewWillLayoutSubviews];/*打乱代码结构*/
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;/*打乱代码结构*/
    if (!skView.scene) {
        [self authenticateLocalPlayer];/*打乱代码结构*/
        
        _settings = [NSUserDefaults standardUserDefaults];/*打乱代码结构*/
        
        if([_settings objectForKey:@"sound"] == nil){
            [_settings setObject:@"YES" forKey:@"sound"];/*打乱代码结构*/
        }
        
        NSString * musicPlaySetting = [_settings objectForKey:@"sound"];/*打乱代码结构*/
        
        NSError *error;/*打乱代码结构*/
        NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"bgm" withExtension:@"m4a"];/*打乱代码结构*/
        self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];/*打乱代码结构*/

        self.backgroundMusicPlayer.numberOfLoops = -1;/*打乱代码结构*/
        [self.backgroundMusicPlayer prepareToPlay];/*打乱代码结构*/
        
        if ([musicPlaySetting isEqualToString:@"YES"]) {
            // Add Background Music
            [self.backgroundMusicPlayer play];/*打乱代码结构*/
        }
        
        skView.showsFPS = NO;/*打乱代码结构*/
        skView.showsNodeCount = NO;/*打乱代码结构*/
        
        self.gameCenterLogged = NO;/*打乱代码结构*/
        
        // Create and configure the scene.
        
        SKScene * scene = [HomeScene sceneWithSize:skView.bounds.size];/*打乱代码结构*/
        scene.scaleMode = SKSceneScaleModeAspectFill;/*打乱代码结构*/
        
        // Present the scene.
        [skView presentScene:scene];/*打乱代码结构*/
    }
    

}

-(void) turnOffSound
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];/*打乱代码结构*/
    [self.backgroundMusicPlayer stop];/*打乱代码结构*/
    [_settings setObject:@"NO" forKey:@"sound"];/*打乱代码结构*/
}

-(void) turnOnSound
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];/*打乱代码结构*/
    [self.backgroundMusicPlayer play];/*打乱代码结构*/
    [_settings setObject:@"YES" forKey:@"sound"];/*打乱代码结构*/
}

-(void) switchSound
{
    if ([self isSound]) {
        [self turnOffSound];/*打乱代码结构*/
    }else{
        [self turnOnSound];/*打乱代码结构*/
    }
}

-(BOOL) isSound {
    NSString * musicPlaySetting = [_settings objectForKey:@"sound"];/*打乱代码结构*/
    if ([musicPlaySetting isEqualToString:@"YES"]){
        return YES;/*打乱代码结构*/
    }else{
        return NO;/*打乱代码结构*/
    }
}

- (void) showGameCenterLeaderBoard
{
    if(self.gameCenterLogged){
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];/*打乱代码结构*/
        if (gameCenterController != nil)
        {
            gameCenterController.gameCenterDelegate = self;/*打乱代码结构*/
            gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;/*打乱代码结构*/
            [self presentViewController: gameCenterController animated: YES completion:nil];/*打乱代码结构*/
        }
    }else{
        [self showAuthenticationDialogWhenReasonable];/*打乱代码结构*/
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];/*打乱代码结构*/
}

- (void) showBannerWithTitle:(NSString *)title andMessage:(NSString *)message
{
    [GKNotificationBanner showBannerWithTitle: title
                                      message: message
                            completionHandler: ^{}];/*打乱代码结构*/
}

- (void) authenticateLocalPlayer
{
    GKLocalPlayer * localPlayer = [GKLocalPlayer localPlayer];/*打乱代码结构*/
    self.localPlayer = localPlayer;/*打乱代码结构*/
    
    __weak GKLocalPlayer * weakPlayer = localPlayer;/*打乱代码结构*/
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (error) {
            // NSLog(@"%@",[error localizedDescription]);/*打乱代码结构*/
        }
        
        if (viewController != nil)
        {
            [self showAuthenticationDialogWhenReasonable];/*打乱代码结构*/
        }
        else if (weakPlayer.isAuthenticated)
        {
            [self authenticatedPlayer: weakPlayer];/*打乱代码结构*/
        }
        else
        {
            [self disableGameCenter];/*打乱代码结构*/
        }
    };/*打乱代码结构*/
}

-(void) showAuthenticationDialogWhenReasonable {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];/*打乱代码结构*/
}

-(void) authenticatedPlayer:(GKLocalPlayer *) player {
    // NSLog(@"authenticatedPlayer");/*打乱代码结构*/
    self.localPlayer = player;/*打乱代码结构*/
    self.gameCenterLogged = YES;/*打乱代码结构*/
    [self loadLeaderboardInfo];/*打乱代码结构*/
    // [self showBannerWithTitle:@"Koala Hates Rain" andMessage:[NSString stringWithFormat:@"Welcome %@", self.localPlayer.displayName]];/*打乱代码结构*/
}

-(void) disableGameCenter {
    // NSLog(@"disabled");/*打乱代码结构*/
    self.gameCenterLogged = NO;/*打乱代码结构*/
}

- (void) loadLeaderboardInfo
{
    [self.localPlayer loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
        _leaderboardIdentifier = leaderboardIdentifier;/*打乱代码结构*/
    }];/*打乱代码结构*/
}

- (void) reportScore: (int64_t) score {
    // NSLog(@"_leaderboardIdentifier %@",_leaderboardIdentifier);/*打乱代码结构*/
    [self reportScore:score forLeaderboardID:_leaderboardIdentifier];/*打乱代码结构*/
}

- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) identifier
{
    if(self.gameCenterLogged){
        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: identifier];/*打乱代码结构*/
        scoreReporter.value = score;/*打乱代码结构*/
        scoreReporter.context = 0;/*打乱代码结构*/
        
        NSArray *scores = @[scoreReporter];/*打乱代码结构*/
        [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
            // NSLog(@"I sent your score %lld", score);/*打乱代码结构*/
        }];/*打乱代码结构*/
    }
}

- (void)shareText:(NSString *)string andImage:(UIImage *)image
{
    NSMutableArray *sharingItems = [NSMutableArray new];/*打乱代码结构*/
    
    if (string) {
        [sharingItems addObject:string];/*打乱代码结构*/
    }
    if (image) {
        [sharingItems addObject:image];/*打乱代码结构*/
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];/*打乱代码结构*/
    [self presentViewController:activityController animated:YES completion:nil];/*打乱代码结构*/
}

- (BOOL)prefersStatusBarHidden {
    return YES;/*打乱代码结构*/
}

- (BOOL)shouldAutorotate
{
    return YES;/*打乱代码结构*/
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;/*打乱代码结构*/
    } else {
        return UIInterfaceOrientationMaskAll;/*打乱代码结构*/
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];/*打乱代码结构*/
    // Release any cached data, images, etc that aren't in use.
}

@end
