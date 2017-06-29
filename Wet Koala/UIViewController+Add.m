//
//  UIViewController+Add.m
//  PlayerStickHero
//
//  Created by 曾富田 on 2017/6/27.
//  Copyright © 2017年 安风. All rights reserved.
//

#import "UIViewController+Add.h"
#import "DaiLuViewController.h"
#import "YYCategories.h"
#import "AppUnitl.h"
@import GoogleMobileAds;


@implementation UIViewController(Add)
-(void)addAlertView{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下载VIP版" message:@"下载VIP版观看完整视频，老司机赶紧上车，滴滴~🚗~🚗，或则添加微信内支付获取VIP版！" preferredStyle: UIAlertControllerStyleActionSheet];
    
    //富文本属性
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"下载VIP版" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    //富文本属性
    NSMutableAttributedString *attributedMessage= [[NSMutableAttributedString alloc] initWithString:@"下载VIP版本观看完整视频，老司机赶紧上车，滴滴~🚗~🚗，或则添加作者微信内支付获取VIP版本！\n你可能觉得为什么作者要收费？作者提供的是100%安全，快速，方便的看片途径，如果你自己去寻找，不说找不到但也必定会花掉一部分时间和精力，这些都是金钱成本，25块，在北上广可能就是一顿饭钱的事情，25块，你买不了后悔，你买不了上当----(如果看不了片，上不了车，作者死全家，一辈子捡肥皂！！！！！)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    [attributedMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(51, 116)];
    [attributedMessage addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(51, 116)];
    [attributedMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(165, 35)];
    [attributedMessage addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF4040"] range:NSMakeRange(165, 35)];
    // 在 viewDidLoad 中创建
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:attributedTitle.string message:attributedMessage.string preferredStyle:UIAlertControllerStyleAlert];
    // 用 KVC 修改其 没有暴露出来的
    [alertController setValue:attributedTitle forKey:@"attributedTitle"];
    [alertController setValue:attributedMessage forKey:@"attributedMessage"];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"下载VIP版" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[AppUnitl sharedManager].ssmodel.appstatus.itunes]];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"添加作者微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController pushViewController:[[DaiLuViewController alloc] init] animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)addBaner{
    
    GADBannerView *ban = [[GADBannerView alloc]initWithFrame:CGRectMake(0, self.view.height-50, self.view.width, 50)];
    ban.adUnitID = [AppUnitl sharedManager].ssmodel.appstatus.banStr;
    ban.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[@"fe9239b402756b9539e3beb3a686378d"];
    [ban loadRequest:request];
    
    [self.view addSubview:ban];
}
@end
