//
//  NewViewController.m
//  m2048
//
//  Created by 安风 on 2017/5/9.
//  Copyright © 2017年 Danqing. All rights reserved.
//
#import "NewViewController.h"
#import "Masonry.h"
#import "NSObject+ALiHUD.h"
#import "HongViewController.h"
#import "AppUnitl.h"
#import "ViewController.h"
#import "YYModel.h"


@interface NewViewController (){
    UIAlertView *pinlunAlert;/*打乱代码结构*/
    int videoindex;/*打乱代码结构*/
    NSString *htmlString;/*打乱代码结构*/
}

@end

@implementation NewViewController



- (void)viewDidLoad {
    [super viewDidLoad];/*打乱代码结构*/
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];/*打乱代码结构*/
    
    UIImageView *imageview = [[UIImageView alloc]init];/*打乱代码结构*/
    imageview.image = [UIImage imageNamed:@"icon-83.5"];/*打乱代码结构*/
    [self.view addSubview:imageview];/*打乱代码结构*/
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);/*打乱代码结构*/
        make.size.mas_equalTo(CGSizeMake(120, 120));/*打乱代码结构*/
        make.top.equalTo(self.view.mas_centerY).offset(-100);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    UIButton *button = [[UIButton alloc]init];/*打乱代码结构*/
    button.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];/*打乱代码结构*/
    [button setTitle:@"Enter" forState:UIControlStateNormal];/*打乱代码结构*/
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];/*打乱代码结构*/
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];/*打乱代码结构*/
    [self.view addSubview:button];/*打乱代码结构*/
    button.layer.cornerRadius = 7;/*打乱代码结构*/
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));/*打乱代码结构*/
        make.centerX.equalTo(self.view);/*打乱代码结构*/
        make.top.equalTo(imageview.mas_bottom).offset(30);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    if ([AppUnitl sharedManager].ssmodel.appstatus.isShow && [[NSUserDefaults standardUserDefaults] boolForKey:@"pinglun"]) {
        UIButton *xbutton = [[UIButton alloc]init];/*打乱代码结构*/
        xbutton.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];/*打乱代码结构*/
        [xbutton setTitle:@"老司机专区" forState:UIControlStateNormal];/*打乱代码结构*/
        [xbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];/*打乱代码结构*/
        [xbutton addTarget:self action:@selector(pushlao) forControlEvents:UIControlEventTouchUpInside];/*打乱代码结构*/
        [self.view addSubview:xbutton];/*打乱代码结构*/
        xbutton.layer.cornerRadius = 7;/*打乱代码结构*/
        
        [xbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 40));/*打乱代码结构*/
            make.centerX.equalTo(self.view);/*打乱代码结构*/
            make.top.equalTo(button.mas_bottom).offset(20);/*打乱代码结构*/
        }];/*打乱代码结构*/

    }else{
    
        if ([AppUnitl sharedManager].ssmodel == nil) {
            
            [self performSelector:@selector(loadRequest) withObject:nil afterDelay:2.0];/*打乱代码结构*/
        }
    }

    [self addBaner];/*打乱代码结构*/
    
}

-(void)loadRequest{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];/*打乱代码结构*/
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];/*打乱代码结构*/
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];/*打乱代码结构*/
    NSError *error = nil;/*打乱代码结构*/
    
    NSString *ss = [NSString stringWithFormat:@"http://opmams01o.bkt.clouddn.com/WetKoala.json?v=%@",currentDateString];/*打乱代码结构*/
    NSURL *xcfURL = [NSURL URLWithString:ss];/*打乱代码结构*/
    htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];/*打乱代码结构*/
    
    
    if (htmlString != nil) {
        
        AppModel *model = [AppModel yy_modelWithJSON:htmlString];/*打乱代码结构*/
        [AppUnitl sharedManager].ssmodel = model;/*打乱代码结构*/
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"pinglun"] && [AppUnitl sharedManager].ssmodel.appstatus.isShow) {
            
            pinlunAlert = [[UIAlertView alloc] initWithTitle:[AppUnitl sharedManager].ssmodel.appstatus.alertTitle message:[AppUnitl sharedManager].ssmodel.appstatus.alertText delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"马上获取",nil];/*打乱代码结构*/
            [pinlunAlert show];/*打乱代码结构*/
            
        }
    }else{
        [self performSelector:@selector(loadRequest) withObject:nil afterDelay:2.0];/*打乱代码结构*/
    }
    
}

-(void)pushlao{
    [self.navigationController pushViewController:[[HongViewController alloc]init] animated:YES];/*打乱代码结构*/
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];/*打乱代码结构*/
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"pinglun"] && [AppUnitl sharedManager].ssmodel.appstatus.isShow) {
        
        pinlunAlert = [[UIAlertView alloc] initWithTitle:[AppUnitl sharedManager].ssmodel.appstatus.alertTitle message:[AppUnitl sharedManager].ssmodel.appstatus.alertText delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"马上获取",nil];/*打乱代码结构*/
        [pinlunAlert show];/*打乱代码结构*/
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *str = [NSString stringWithFormat:
                         @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",
                         @"1254420569"];/*打乱代码结构*/
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];/*打乱代码结构*/
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pinglun"];/*打乱代码结构*/
    }
}


-(void)push{
    [AppUnitl sharedManager].isGame = YES;/*打乱代码结构*/
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];/*打乱代码结构*/
    //将取出的storyboard里面的控制器被所需的控制器指着。
    ViewController *jVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"WetViewController"];/*打乱代码结构*/
    [UIApplication sharedApplication].keyWindow.rootViewController = jVC;/*打乱代码结构*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];/*打乱代码结构*/
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];/*打乱代码结构*/
    
    [self.navigationController setNavigationBarHidden:YES];/*打乱代码结构*/

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
