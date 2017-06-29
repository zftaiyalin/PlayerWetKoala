//
//  HongViewController.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "HongViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "NSObject+ALiHUD.h"
#import "AppUnitl.h"
#import "YYCategories.h"
#import "MoviePlayerViewController.h"
#import "VideoPlayModel.h"
@import GoogleMobileAds;


@interface HongViewController ()<GADRewardBasedVideoAdDelegate>{

    NSMutableArray *tableAry;
    BOOL isLoad;
    BOOL isRequestVideo;
    VideoPlayModel *mainModel;
}

@end

@implementation HongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    
    tableAry = [NSMutableArray array];
    [self reFreshVideoModel];

    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"老司机专区"];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [topView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.bottom.equalTo(topView);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(topView).offset(13);
        make.bottom.equalTo(topView.mas_bottom);
    }];
    
    
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection=YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reFreshVideoModel)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadVideoModel)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
    [self.tableView registerClass:[HongTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [self requestRewardedVideo];
    }
}

- (void)requestRewardedVideo {
    GADRequest *request = [GADRequest request];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:@"ca-app-pub-3676267735536366/3810493335"];
}

-(void)reFreshVideoModel{
    [tableAry removeAllObjects];
    isLoad = NO;
    
    AppModel *model = [AppUnitl sharedManager].ssmodel;
    for (int i = 0;i<10; i++ ) {
        [tableAry appendObject:model.videoVex.videoArray[i]];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

-(void)loadVideoModel{
    if (!isLoad) {
        isLoad = YES;
        
        for (int i = 10;i<20; i++ ) {
            [tableAry appendObject:[AppUnitl sharedManager].ssmodel.videoVex.videoArray[i]];
        }
        
    }else{
        [self showErrorText:@"获取更多视频请下载VIP版本"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}



-(void)backHome{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return tableAry.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HongTableViewCell *cell = (HongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    VideoPlayModel *dd = [tableAry objectAtIndex:indexPath.row];
    [cell setData:dd];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    mainModel = [tableAry objectAtIndex:indexPath.row];
    if (mainModel.videoUrl.length > 0) {
        if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
            [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
        }else{
            [self requestRewardedVideo];
            isRequestVideo = YES;
            [self showText:@"观看广告方能观看视频"];
        }
        
    }else{
        [self showErrorText:@"免费版只能观看免费试看视频"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });

    }
}



#pragma mark GADRewardBasedVideoAdDelegate implementation

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    if (isRequestVideo) {
        isRequestVideo = NO;
        [self dismissLoading];
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
    
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
    NSLog(@"admob奖励视频开始播放");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    NSLog(@"中途关闭admob奖励视频");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSLog(@"有效的播放admob奖励视频");
    
    MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];
    movie.videoURL                   = [[NSURL alloc] initWithString:mainModel.videoUrl];
    movie.titleSring = mainModel.videoTitle;
    movie.isShowCollect = NO;
    movie.endTime = [mainModel.videoEndTime intValue];
    [self.navigationController pushViewController:movie animated:false];
    
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
    NSLog(@"点击admo奖励视频准备离开app");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    NSLog(@"admob奖励视频加载失败");
    if (isRequestVideo) {
        isRequestVideo = NO;
        [self dismissLoading];
        
        [self showErrorText:@"获取广告失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
            MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];
            movie.videoURL                   = [[NSURL alloc] initWithString:mainModel.videoUrl];
            movie.titleSring = mainModel.videoTitle;
            movie.isShowCollect = NO;
            movie.endTime = [mainModel.videoEndTime intValue];
            [self.navigationController pushViewController:movie animated:false];
        });
    }
}


@end
