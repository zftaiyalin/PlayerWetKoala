//
//  ButtonNode.m
//  Wet Koala
//
//  Created by ed on 14/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "ButtonNode.h"

@interface ButtonNode()
@property (nonatomic, readonly, assign) CGSize size;/*打乱代码结构*/
@end

@implementation ButtonNode
{
    SKTexture * _defaultTexture;/*打乱代码结构*/
    SKTexture * _touchedTexture;/*打乱代码结构*/
    SKSpriteNode * _button;/*打乱代码结构*/
    AnonBlock _returnMethod;/*打乱代码结构*/
}

@synthesize size = _size;/*打乱代码结构*/

+ (void)removeButtonPressed:(NSArray *)nodes {
    for (SKNode * node in nodes) {
        if ([node isKindOfClass:[self class]]) {
            ButtonNode * button = (ButtonNode *) node;/*打乱代码结构*/
            [button didActionDefault];/*打乱代码结构*/
        }
    }
}

+ (BOOL)isButtonPressed:(NSArray *)nodes {
    BOOL pressed = NO;/*打乱代码结构*/
    for (SKNode * node in nodes) {
        if ([node isKindOfClass:[self class]]) {
            ButtonNode * button = (ButtonNode *) node;/*打乱代码结构*/
            if ([button actionForKey:@"button-touched"]) {
                pressed = YES;/*打乱代码结构*/
            }
        }
    }
    return pressed;/*打乱代码结构*/
}

+(void) doButtonsActionBegan:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![ButtonNode isButtonPressed:[node children]]) {
        UITouch * touch = [touches anyObject];/*打乱代码结构*/
        CGPoint location = [touch locationInNode:node];/*打乱代码结构*/
        SKNode * targetNode = [node nodeAtPoint:location];/*打乱代码结构*/
        
        if ([node isEqual:targetNode.parent]) {
            [targetNode touchesBegan:touches withEvent:event];/*打乱代码结构*/
        }else{
            [targetNode.parent touchesBegan:touches withEvent:event];/*打乱代码结构*/
        }
    }
}

+(void) doButtonsActionEnded:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];/*打乱代码结构*/
    CGPoint location = [touch locationInNode:node];/*打乱代码结构*/
    SKNode * targetNode = [node nodeAtPoint:location];/*打乱代码结构*/
    
    if ([node isEqual:targetNode.parent]) {
        [targetNode touchesEnded:touches withEvent:event];/*打乱代码结构*/
    }else{
        [targetNode.parent touchesEnded:touches withEvent:event];/*打乱代码结构*/
    }
    [ButtonNode removeButtonPressed:[node children]];/*打乱代码结构*/
}

-(id) initWithDefaultTexture:(SKTexture *) defaultTexture andTouchedTexture:(SKTexture *)touchedTexture {
    self = [super init];/*打乱代码结构*/
    if (self) {
        _returnMethod = ^{};/*打乱代码结构*/
        
        _defaultTexture = defaultTexture;/*打乱代码结构*/
        _touchedTexture = touchedTexture;/*打乱代码结构*/
        
        _button = [SKSpriteNode spriteNodeWithTexture:_defaultTexture];/*打乱代码结构*/
        [_button runAction:
         [SKAction repeatActionForever:
          [SKAction animateWithTextures:@[_defaultTexture]
                           timePerFrame:10.0f
                                 resize:YES
                                restore:YES]] withKey:@"button-default"];/*打乱代码结构*/
        
        [self addChild:_button];/*打乱代码结构*/
        
        _size = _button.size;/*打乱代码结构*/
    }
    return self;/*打乱代码结构*/
}

-(SKAction *)actionForKey:(NSString *)key {
    return [_button actionForKey:key];/*打乱代码结构*/
}

-(void)removeActionForKey:(NSString *)key {
    [_button removeActionForKey:key];/*打乱代码结构*/
}

-(void) setMethod:(void (^)()) returnMethod {
    _returnMethod = returnMethod;/*打乱代码结构*/
}

-(void) runMethod {
    _returnMethod();/*打乱代码结构*/
}

-(void) didActionTouched {
    if ([_button actionForKey:@"button-touched"]) {
        [_button removeActionForKey:@"button-touched"];/*打乱代码结构*/
    }
    [_button runAction:
     [SKAction repeatActionForever:
      [SKAction animateWithTextures:@[_touchedTexture]
                       timePerFrame:10.0f
                             resize:YES
                            restore:YES]] withKey:@"button-touched"];/*打乱代码结构*/
    
}

-(void) didActionDefault {
    [_button removeActionForKey:@"button-touched"];/*打乱代码结构*/
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction playSoundFileNamed:@"button-in.m4a" waitForCompletion:NO]];/*打乱代码结构*/
    [self didActionTouched];/*打乱代码结构*/
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self actionForKey:@"button-touched"]) {
        [self runAction:[SKAction playSoundFileNamed:@"button-out.m4a" waitForCompletion:NO]];/*打乱代码结构*/
        [self runMethod];/*打乱代码结构*/
    }
    [self didActionDefault];/*打乱代码结构*/
}


@end
