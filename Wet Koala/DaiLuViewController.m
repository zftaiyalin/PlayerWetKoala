//
//  DaiLuViewController.m
//  XiaoShuoTool
//
//  Created by 安风 on 2017/5/11.
//  Copyright © 2017年 TheLastCode. All rights reserved.
//

#import "DaiLuViewController.h"
#import "YYCategories.h"
#import "Masonry.h"
#import "AppUnitl.h"
@interface DaiLuViewController (){
    
}

@property(nonatomic,strong) UIButton *wechatBtu;/*打乱代码结构*/
@property(nonatomic,strong) UITextField *textField;/*打乱代码结构*/
@property(nonatomic,strong) UIButton *tijiaoBtu;/*打乱代码结构*/
@property(nonatomic,strong) UILabel *jgLabel;/*打乱代码结构*/
@end

@implementation DaiLuViewController


-(void)dealloc{
    NSLog(@"释放控制器");/*打乱代码结构*/
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];/*打乱代码结构*/
    [[UIApplication sharedApplication] setStatusBarHidden:YES];/*打乱代码结构*/
}
- (void)viewDidLoad {
    [super viewDidLoad];/*打乱代码结构*/
    // Do any additional setup after loading the view.

    self.title = @"添加微信";/*打乱代码结构*/
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];/*打乱代码结构*/
    
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

    
    
    _wechatBtu = [UIButton buttonWithType:UIButtonTypeCustom];/*打乱代码结构*/
    _wechatBtu.backgroundColor = [UIColor whiteColor];/*打乱代码结构*/
    [_wechatBtu addTarget:self action:@selector(copyWechat) forControlEvents:UIControlEventTouchUpInside];/*打乱代码结构*/
    [self.view addSubview:_wechatBtu];/*打乱代码结构*/
    
    [_wechatBtu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);/*打乱代码结构*/
        make.top.equalTo(self.view).offset(64+13);/*打乱代码结构*/
        make.height.mas_equalTo(44);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    
    UILabel *label = [[UILabel alloc]init];/*打乱代码结构*/
    label.text = [AppUnitl sharedManager].ssmodel.appstatus.weiChatName;/*打乱代码结构*/
    label.textColor = [UIColor colorWithHexString:@"#FF6A6A"];/*打乱代码结构*/
    [_wechatBtu addSubview:label];/*打乱代码结构*/
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(_wechatBtu).insets(UIEdgeInsetsMake(0, 13, 0, 13));/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    
    UILabel *xlabel = [[UILabel alloc]init];/*打乱代码结构*/
    xlabel.text = @"点击上方微信号添加老司机";/*打乱代码结构*/
    xlabel.textColor = [UIColor blackColor];/*打乱代码结构*/
    xlabel.font = [UIFont systemFontOfSize:13];/*打乱代码结构*/
    [_wechatBtu addSubview:xlabel];/*打乱代码结构*/
    
    [xlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(13);/*打乱代码结构*/
        make.top.equalTo(_wechatBtu.mas_bottom).offset(7);/*打乱代码结构*/
        make.right.equalTo(self.view);/*打乱代码结构*/
        make.height.mas_equalTo(20);/*打乱代码结构*/
    }];/*打乱代码结构*/
    
}


-(void)backHome{
    
    [self.navigationController popViewControllerAnimated:YES];/*打乱代码结构*/
}
-(void)copyWechat{
    

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];/*打乱代码结构*/
        pasteboard.string = [AppUnitl sharedManager].ssmodel.appstatus.weiChatName;/*打乱代码结构*/
        
        UIAlertView *infoAlert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"已复制老司机微信号，是否前往寻找老司机？" delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"前往",nil];/*打乱代码结构*/
        [infoAlert show];/*打乱代码结构*/
  
    

}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        
        NSString *str = @"weixin:/";/*打乱代码结构*/
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];/*打乱代码结构*/
    }
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


@end
