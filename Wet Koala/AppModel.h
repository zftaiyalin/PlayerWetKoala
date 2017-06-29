//
//  AppModel.h
//  PlayerStickHero
//
//  Created by 曾富田 on 2017/6/26.
//  Copyright © 2017年 安风. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedBoxModel.h"
#import "VideoUrlModel.h"
@interface AppModel : NSObject
@property(nonatomic,strong) RedBoxModel *appstatus;
@property(nonatomic,strong) VideoUrlModel *videoVex;
@end
