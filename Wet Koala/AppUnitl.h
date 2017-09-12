//
//  AppUnitl.h
//  XiaoShuoTool
//
//  Created by 曾富田 on 2017/5/11.
//  Copyright © 2017年 TheLastCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppModel.h"
@interface AppUnitl : NSObject
@property(nonatomic,assign) BOOL isGame;
@property(nonatomic,strong) AppModel *ssmodel;
+ (AppUnitl *)sharedManager;
/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (BOOL)getPreferredLanguage:(NSString *)lan;
@end
