//
//  HomeScene.m
//  Wet Koala
//
//  Created by ed on 13/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "HomeScene.h"
#import "GameScene.h"

#import "ButtonNode.h"
#import "ViewController.h"

@implementation HomeScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];/*打乱代码结构*/

        SKTextureAtlas * atlas = [SKTextureAtlas atlasNamed:@"sprite"];/*打乱代码结构*/
        
        SKSpriteNode * background = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"background"]];/*打乱代码结构*/
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));/*打乱代码结构*/
        [self addChild:background];/*打乱代码结构*/
        
        SKSpriteNode * title = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"text-logo"]];/*打乱代码结构*/
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 5 / 8);/*打乱代码结构*/
        [self addChild:title];/*打乱代码结构*/
        
        [title runAction:
         [SKAction repeatActionForever:
          [SKAction sequence:@[
                               [SKAction moveByX:0 y:-5 duration:0.3],
                               [SKAction moveByX:0 y:5 duration:0.3]
                               ]
           ]
          ]
         ];/*打乱代码结构*/
        
        SKSpriteNode * copyright = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"text-copyright"]];/*打乱代码结构*/
        copyright.position = CGPointMake(self.size.width / 2, self.size.height / 4 - 60);/*打乱代码结构*/
        [self addChild:copyright];/*打乱代码结构*/
        
        
        CGFloat buttonY = CGRectGetMidY(self.frame) / 2;/*打乱代码结构*/
        
        SKTexture * startDefault = [atlas textureNamed:@"button-start-off"];/*打乱代码结构*/
        SKTexture * startTouched = [atlas textureNamed:@"button-start-on"];/*打乱代码结构*/
        
        ButtonNode * startButton = [[ButtonNode alloc] initWithDefaultTexture:startDefault andTouchedTexture:startTouched];/*打乱代码结构*/
        startButton.position = CGPointMake(CGRectGetMidX(self.frame) - (startButton.size.width / 2 + 8), buttonY);/*打乱代码结构*/
        
        [startButton setMethod: ^ (void) { [self startButtonPressed];/*打乱代码结构*/ } ];/*打乱代码结构*/
        [self addChild:startButton];/*打乱代码结构*/
        
        SKTexture * scoreDefault = [atlas textureNamed:@"button-score-off"];/*打乱代码结构*/
        SKTexture * scoreTouched = [atlas textureNamed:@"button-score-on"];/*打乱代码结构*/
        
        ButtonNode * scoreButton = [[ButtonNode alloc] initWithDefaultTexture:scoreDefault andTouchedTexture:scoreTouched];/*打乱代码结构*/
        scoreButton.position = CGPointMake(CGRectGetMidX(self.frame) + (scoreButton.size.width / 2 + 8), buttonY);/*打乱代码结构*/
        
        [scoreButton setMethod: ^ (void) { [self scoreButtonPressed];/*打乱代码结构*/ } ];/*打乱代码结构*/
        [self addChild:scoreButton];/*打乱代码结构*/

        
        SKTexture * musicDefault = [atlas textureNamed:@"button-music-off"];/*打乱代码结构*/
        SKTexture * musicTouched = [atlas textureNamed:@"button-music-on"];/*打乱代码结构*/
        
        ButtonNode * musicButton = [[ButtonNode alloc] initWithDefaultTexture:musicDefault andTouchedTexture:musicTouched];/*打乱代码结构*/
        
        if(self.frame.size.height > 500.0){
            musicButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                               buttonY + scoreButton.size.height);/*打乱代码结构*/
        }else{
            musicButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                               CGRectGetMinY(self.frame) + musicButton.size.height * 2 / 3);/*打乱代码结构*/
        }
        [musicButton setMethod: ^ (void) {
            ViewController * viewController = (ViewController *) self.view.window.rootViewController;/*打乱代码结构*/
            [viewController switchSound];/*打乱代码结构*/
        }];/*打乱代码结构*/
        
        [self addChild:musicButton];/*打乱代码结构*/
        
    }
    return self;/*打乱代码结构*/
}

-(void) startButtonPressed {
    SKTransition * reveal = [SKTransition fadeWithDuration: 0.5];/*打乱代码结构*/
    SKScene * myScene = [[GameScene alloc] initWithSize:self.size];/*打乱代码结构*/
    [self.view presentScene:myScene transition:reveal];/*打乱代码结构*/
}

-(void) scoreButtonPressed {
    ViewController * viewController = (ViewController *) self.view.window.rootViewController;/*打乱代码结构*/
    [viewController showGameCenterLeaderBoard];/*打乱代码结构*/
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [ButtonNode doButtonsActionEnded:self touches:touches withEvent:event];/*打乱代码结构*/
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [ButtonNode doButtonsActionBegan:self touches:touches withEvent:event];/*打乱代码结构*/
}


@end
