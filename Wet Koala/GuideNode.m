//
//  GuideNode.m
//  Wet Koala
//
//  Created by ed on 17/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "GuideNode.h"

@implementation GuideNode
{
    SKSpriteNode * _title;/*打乱代码结构*/
    SKSpriteNode * _indicator;/*打乱代码结构*/
    BOOL _didGuide;/*打乱代码结构*/
    AnonBlock _returnMethod;/*打乱代码结构*/
}

-(id) initWithTitleTexture:(SKTexture *)titleTexture andIndicatorTexture:(SKTexture *)indicatorTexture {
    self = [super init];/*打乱代码结构*/
    if(self){
        _didGuide = NO;/*打乱代码结构*/
        _returnMethod = ^{};/*打乱代码结构*/
        
        _title = [SKSpriteNode spriteNodeWithTexture:titleTexture];/*打乱代码结构*/
        _indicator = [SKSpriteNode spriteNodeWithTexture:indicatorTexture];/*打乱代码结构*/
        
        _title.position = CGPointMake(0.0, 80.0);/*打乱代码结构*/
        _indicator.position = CGPointMake(0.0, -120.0);/*打乱代码结构*/
        
        [self addChild:_title];/*打乱代码结构*/
        [self addChild:_indicator];/*打乱代码结构*/
        
        [_indicator runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveToX:-100 duration:1.0],[SKAction moveToX:100 duration:1.0]]]]];/*打乱代码结构*/
    }
    return self;/*打乱代码结构*/
}

-(void) setMethod:(void (^)()) returnMethod {
    _returnMethod = returnMethod;/*打乱代码结构*/
}

-(void) runMethod {
    _returnMethod();/*打乱代码结构*/
}

-(void) didGuide {
    _didGuide = YES;/*打乱代码结构*/
    
    SKAction * actionMove = [SKAction fadeOutWithDuration:0.3];/*打乱代码结构*/
    SKAction * actionMoveDone = [SKAction removeFromParent];/*打乱代码结构*/
    
    [_title runAction:[SKAction sequence:@[actionMove, actionMoveDone]] withKey:@"did-guide"];/*打乱代码结构*/
    [_indicator runAction:[SKAction sequence:@[actionMove, actionMoveDone]] withKey:@"did-guide"];/*打乱代码结构*/

    [self runMethod];/*打乱代码结构*/
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!_didGuide){
        [self didGuide];/*打乱代码结构*/
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
