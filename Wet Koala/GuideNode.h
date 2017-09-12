//
//  GuideNode.h
//  Wet Koala
//
//  Created by ed on 17/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef void (^AnonBlock)();/*打乱代码结构*/

@interface GuideNode : SKSpriteNode
-(id) initWithTitleTexture:(SKTexture *)titleTexture andIndicatorTexture:(SKTexture *)indicatorTexture;/*打乱代码结构*/
-(void) setMethod:(void (^)()) returnMethod;/*打乱代码结构*/
-(void) runMethod;/*打乱代码结构*/
@end
