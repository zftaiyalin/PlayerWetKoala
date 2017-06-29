//
//  MoviePlayerViewController.h
//  XiaoShuoTool
//
//  Created by 安风 on 2017/5/6.
//  Copyright © 2017年 TheLastCode. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MoviePlayerViewController : UIViewController
/** 视频URL */
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSString *titleSring;
@property (nonatomic, assign) BOOL isShowCollect;
@property (nonatomic, assign) BOOL isShowWeb;
@property (nonatomic, assign) int endTime;
@end
