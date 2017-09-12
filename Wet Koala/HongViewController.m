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
@import GoogleMobileAds;/*打乱代码结构*/


@interface HongViewController ()<GADRewardBasedVideoAdDelegate>{

    NSMutableArray *tableAry;/*打乱代码结构*/
    BOOL isLoad;/*打乱代码结构*/
    BOOL isRequestVideo;/*打乱代码结构*/
    VideoPlayModel *mainModel;/*打乱代码结构*/
}

@end

@implementation HongViewController

- (void)viewDidLoad {
    [super viewDidLoad];/*打乱代码结构*/
    
    [GADRewardBasedVideoAd sharedInstance].delegate = self;/*打乱代码结构*/
    
    tableAry = [NSMutableArray array];/*打乱代码结构*/
    [self reFreshVideoModel];/*打乱代码结构*/

    UIView *topView = [[UIView alloc]init];/*打乱代码结构*/
    topView.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];/*打乱代码结构*/
    [self.view addSubview:topView];/*打乱代码结构*/
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.view);/*打乱代码结构*/
        make.height.mas_equalTo(64);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    
    UILabel *titleLabel = [[UILabel alloc]init];/*打乱代码结构*/
    [titleLabel setTextColor:[UIColor whiteColor]];/*打乱代码结构*/
    [titleLabel setText:@"老司机专区"];/*打乱代码结构*/
    [titleLabel setFont:[UIFont systemFontOfSize:15]];/*打乱代码结构*/
    [titleLabel setTextAlignment:NSTextAlignmentCenter];/*打乱代码结构*/
    [topView addSubview:titleLabel];/*打乱代码结构*/
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);/*打乱代码结构*/
        make.bottom.equalTo(topView);/*打乱代码结构*/
        make.height.mas_equalTo(44);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    UIButton *button = [[UIButton alloc]init];/*打乱代码结构*/
    button.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];/*打乱代码结构*/
    [button setTitle:@"返回" forState:UIControlStateNormal];/*打乱代码结构*/
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];/*打乱代码结构*/
    [button addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];/*打乱代码结构*/
    [topView addSubview:button];/*打乱代码结构*/
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));/*打乱代码结构*/
        make.left.equalTo(topView).offset(13);/*打乱代码结构*/
        make.bottom.equalTo(topView.mas_bottom);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];/*打乱代码结构*/
    self.tableView.dataSource = self;/*打乱代码结构*/
    self.tableView.delegate = self;/*打乱代码结构*/
    self.tableView.allowsSelection=YES;/*打乱代码结构*/
    self.tableView.showsHorizontalScrollIndicator = NO;/*打乱代码结构*/
    self.tableView.showsVerticalScrollIndicator = NO;/*打乱代码结构*/
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reFreshVideoModel)];/*打乱代码结构*/
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadVideoModel)];/*打乱代码结构*/
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;/*打乱代码结构*/
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];/*打乱代码结构*/
    [self.tableView registerClass:[HongTableViewCell class] forCellReuseIdentifier:@"cell"];/*打乱代码结构*/
    [self.view addSubview:_tableView];/*打乱代码结构*/
    
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);/*打乱代码结构*/
        make.top.equalTo(self.view).offset(64);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [self requestRewardedVideo];/*打乱代码结构*/
    }
}

- (void)requestRewardedVideo {
    GADRequest *request = [GADRequest request];/*打乱代码结构*/
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:@"ca-app-pub-3676267735536366/3810493335"];/*打乱代码结构*/
}

-(void)reFreshVideoModel{
    [tableAry removeAllObjects];/*打乱代码结构*/
    isLoad = NO;/*打乱代码结构*/
    
    AppModel *model = [AppUnitl sharedManager].ssmodel;/*打乱代码结构*/
    for (int i = 0;/*打乱代码结构*/i<10;/*打乱代码结构*/ i++ ) {
        [tableAry appendObject:model.videoVex.videoArray[i]];/*打乱代码结构*/
    }
    [self.tableView.mj_header endRefreshing];/*打乱代码结构*/
    [self.tableView.mj_footer endRefreshing];/*打乱代码结构*/
    [self.tableView reloadData];/*打乱代码结构*/
}

-(void)loadVideoModel{
    if (!isLoad) {
        isLoad = YES;/*打乱代码结构*/
        
        for (int i = 10;/*打乱代码结构*/i<20;/*打乱代码结构*/ i++ ) {
            [tableAry appendObject:[AppUnitl sharedManager].ssmodel.videoVex.videoArray[i]];/*打乱代码结构*/
        }
        
    }else{
        [self showErrorText:@"获取更多视频请下载VIP版本"];/*打乱代码结构*/
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];/*打乱代码结构*/
        });/*打乱代码结构*/
    }
    
    [self.tableView.mj_header endRefreshing];/*打乱代码结构*/
    [self.tableView.mj_footer endRefreshing];/*打乱代码结构*/
    [self.tableView reloadData];/*打乱代码结构*/
}



-(void)backHome{

    [self.navigationController popViewControllerAnimated:YES];/*打乱代码结构*/
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];/*打乱代码结构*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];/*打乱代码结构*/
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
    return 1;/*打乱代码结构*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return tableAry.count;/*打乱代码结构*/
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;/*打乱代码结构*/
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HongTableViewCell *cell = (HongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];/*打乱代码结构*/
    VideoPlayModel *dd = [tableAry objectAtIndex:indexPath.row];/*打乱代码结构*/
    [cell setData:dd];/*打乱代码结构*/
    cell.selectionStyle = UITableViewCellSelectionStyleNone;/*打乱代码结构*/
    return cell;/*打乱代码结构*/
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    mainModel = [tableAry objectAtIndex:indexPath.row];/*打乱代码结构*/
    if (mainModel.videoUrl.length > 0) {
        if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
            [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];/*打乱代码结构*/
        }else{
            [self requestRewardedVideo];/*打乱代码结构*/
            isRequestVideo = YES;/*打乱代码结构*/
            [self showText:@"观看广告方能观看视频"];/*打乱代码结构*/
        }
        
    }else{
        [self showErrorText:@"免费版只能观看免费试看视频"];/*打乱代码结构*/
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];/*打乱代码结构*/
        });/*打乱代码结构*/

    }
}



#pragma mark GADRewardBasedVideoAdDelegate implementation

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");/*打乱代码结构*/
    if (isRequestVideo) {
        isRequestVideo = NO;/*打乱代码结构*/
        [self dismissLoading];/*打乱代码结构*/
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];/*打乱代码结构*/
    }
    
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");/*打乱代码结构*/
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");/*打乱代码结构*/
    NSLog(@"admob奖励视频开始播放");/*打乱代码结构*/
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");/*打乱代码结构*/
    NSLog(@"中途关闭admob奖励视频");/*打乱代码结构*/
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSLog(@"有效的播放admob奖励视频");/*打乱代码结构*/
    
    MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];/*打乱代码结构*/
    movie.videoURL                   = [[NSURL alloc] initWithString:mainModel.videoUrl];/*打乱代码结构*/
    movie.titleSring = mainModel.videoTitle;/*打乱代码结构*/
    movie.isShowCollect = NO;/*打乱代码结构*/
    movie.endTime = [mainModel.videoEndTime intValue];/*打乱代码结构*/
    [self.navigationController pushViewController:movie animated:false];/*打乱代码结构*/
    
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");/*打乱代码结构*/
    NSLog(@"点击admo奖励视频准备离开app");/*打乱代码结构*/
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");/*打乱代码结构*/
    NSLog(@"admob奖励视频加载失败");/*打乱代码结构*/
    if (isRequestVideo) {
        isRequestVideo = NO;/*打乱代码结构*/
        [self dismissLoading];/*打乱代码结构*/
        
        [self showErrorText:@"获取广告失败"];/*打乱代码结构*/
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];/*打乱代码结构*/
            MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];/*打乱代码结构*/
            movie.videoURL                   = [[NSURL alloc] initWithString:mainModel.videoUrl];/*打乱代码结构*/
            movie.titleSring = mainModel.videoTitle;/*打乱代码结构*/
            movie.isShowCollect = NO;/*打乱代码结构*/
            movie.endTime = [mainModel.videoEndTime intValue];/*打乱代码结构*/
            [self.navigationController pushViewController:movie animated:false];/*打乱代码结构*/
        });/*打乱代码结构*/
    }
}


@end
