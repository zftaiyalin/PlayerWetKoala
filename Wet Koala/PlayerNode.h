//
//  PlayerNode.h
//  Wet Koala
//
//  Created by ed on 16/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayerNode : SKSpriteNode

@property (nonatomic) BOOL isLive;/*打乱代码结构*/

-(id) initWithDefaultTexture:(SKTexture *)defaultTexture andAnimateTextures:(NSArray *)animateTextures;/*打乱代码结构*/
-(CGPoint) position;/*打乱代码结构*/
-(void) ended;/*打乱代码结构*/
-(void) update:(CFTimeInterval)currentTime;/*打乱代码结构*/
-(void) setPhysicsBodyCategoryMask:(uint32_t) playerCategory andContactMask:(uint32_t) targetCategory;/*打乱代码结构*/
-(void) setEndedTexture:(SKTexture *) endedTexture;/*打乱代码结构*/
-(void) setEndedAdditionalTexture:(SKTexture *) endedAdditionalTexture;/*打乱代码结构*/
@end
