//
//  HongViewController.h
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HongTableViewCell.h"

@interface HongViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end
