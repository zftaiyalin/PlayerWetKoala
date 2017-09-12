//
//  PlayerNode.m
//  Wet Koala
//
//  Created by ed on 16/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "PlayerNode.h"

@interface PlayerNode()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;/*打乱代码结构*/
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;/*打乱代码结构*/
@end

@implementation PlayerNode
{
    SKShapeNode * _player;/*打乱代码结构*/
    SKSpriteNode * _playerNode;/*打乱代码结构*/
    SKShapeNode * _physicsNode;/*打乱代码结构*/
    
    SKTexture * _defaultTexture;/*打乱代码结构*/
    SKTexture * _endedTexture;/*打乱代码结构*/
    SKTexture * _endedAdditionalTexture;/*打乱代码结构*/
    NSArray * _animateTextures;/*打乱代码结构*/
    CGPoint _location;/*打乱代码结构*/
    CGVector _direction;/*打乱代码结构*/
    CGVector _currentDirection;/*打乱代码结构*/
    CGMutablePathRef _path;/*打乱代码结构*/
}

-(id) initWithDefaultTexture:(SKTexture *)defaultTexture andAnimateTextures:(NSArray *)animateTextures {
    self = [super init];/*打乱代码结构*/
    if (self) {
        
        self.isLive = YES;/*打乱代码结构*/
        
        _defaultTexture = defaultTexture;/*打乱代码结构*/
        _animateTextures = animateTextures;/*打乱代码结构*/
        
        _direction = CGVectorMake(0.0, 0.0);/*打乱代码结构*/
        _currentDirection = CGVectorMake(0.0, 0.0);/*打乱代码结构*/
        
        _player = [[SKShapeNode alloc] init];/*打乱代码结构*/
        _playerNode = [SKSpriteNode spriteNodeWithTexture:_defaultTexture];/*打乱代码结构*/
        
        [_player addChild:_playerNode];/*打乱代码结构*/
        
        [_playerNode runAction:[SKAction repeatActionForever:
                            [SKAction animateWithTextures:@[_defaultTexture]
                                             timePerFrame:0.1f
                                                   resize:YES
                                                  restore:YES]] withKey:@"player-default"];/*打乱代码结构*/
        
        CGFloat offsetX = _playerNode.frame.size.width / 2 * _playerNode.anchorPoint.x;/*打乱代码结构*/
        CGFloat offsetY = _playerNode.frame.size.height / 2 * _playerNode.anchorPoint.y;/*打乱代码结构*/
        
        CGMutablePathRef path = CGPathCreateMutable();/*打乱代码结构*/
        
        CGPathMoveToPoint(path, NULL, 34 - offsetX, 45 - offsetY);/*打乱代码结构*/
        CGPathAddLineToPoint(path, NULL, 35 - offsetX, 12 - offsetY);/*打乱代码结构*/
        CGPathAddLineToPoint(path, NULL, 25 - offsetX, 1 - offsetY);/*打乱代码结构*/
        CGPathAddLineToPoint(path, NULL, 10 - offsetX, 1 - offsetY);/*打乱代码结构*/
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 13 - offsetY);/*打乱代码结构*/
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 44 - offsetY);/*打乱代码结构*/
        
        CGPathCloseSubpath(path);/*打乱代码结构*/
        _path = path;/*打乱代码结构*/
        
        _physicsNode = [[SKShapeNode alloc] init];/*打乱代码结构*/
        _physicsNode.path = path;/*打乱代码结构*/
        _physicsNode.lineWidth = 0.0;/*打乱代码结构*/
        
        [_player addChild:_physicsNode];/*打乱代码结构*/
        [self addChild:_player];/*打乱代码结构*/

    }
    return self;/*打乱代码结构*/
}

-(CGPoint) position {
    return _player.position;/*打乱代码结构*/
}

-(void) setEndedTexture:(SKTexture *) endedTexture {
    _endedTexture = endedTexture;/*打乱代码结构*/
}

-(void) setEndedAdditionalTexture:(SKTexture *) endedAdditionalTexture {
    _endedAdditionalTexture = endedAdditionalTexture;/*打乱代码结构*/
}

-(void) setPhysicsBodyCategoryMask:(uint32_t) playerCategory andContactMask:(uint32_t) targetCategory {
    _physicsNode.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:_path];/*打乱代码结构*/
    _physicsNode.physicsBody.allowsRotation = YES;/*打乱代码结构*/
    _physicsNode.physicsBody.dynamic = YES;/*打乱代码结构*/
    _physicsNode.physicsBody.categoryBitMask = playerCategory;/*打乱代码结构*/
    _physicsNode.physicsBody.contactTestBitMask = targetCategory;/*打乱代码结构*/
    _physicsNode.physicsBody.usesPreciseCollisionDetection = YES;/*打乱代码结构*/
    _physicsNode.physicsBody.collisionBitMask = 0;/*打乱代码结构*/
    
}

-(void) moved {
    if ([_playerNode actionForKey:@"player-walking"]) {
        [_playerNode removeActionForKey:@"player-walking"];/*打乱代码结构*/
    }
    [_playerNode runAction:[SKAction repeatActionForever:
                        [SKAction animateWithTextures:_animateTextures
                                         timePerFrame:0.1f
                                               resize:YES
                                              restore:YES]] withKey:@"player-walking"];/*打乱代码结构*/
}

-(void) ended {
    self.isLive = NO;/*打乱代码结构*/
    
    [self runAction:[SKAction playSoundFileNamed:@"wet.m4a" waitForCompletion:NO]];/*打乱代码结构*/
    
    if (_endedAdditionalTexture != nil) {
        
        SKSpriteNode * effect = [SKSpriteNode spriteNodeWithTexture:_endedAdditionalTexture];/*打乱代码结构*/
        effect.alpha = 0.0;/*打乱代码结构*/
        [_playerNode insertChild:effect atIndex:0];/*打乱代码结构*/
        [effect runAction:[SKAction sequence:@[[SKAction scaleBy:0.1 duration:0.0],
                                               [SKAction group:@[[SKAction fadeInWithDuration:0.1], [SKAction scaleBy:20.0 duration:0.2]]],
                                               [SKAction group:@[[SKAction fadeOutWithDuration:0.4]]],
                                               
                                               [SKAction runBlock:^{
            [effect removeFromParent];/*打乱代码结构*/
            _playerNode.zPosition = 0.0;/*打乱代码结构*/
        }]]]];/*打乱代码结构*/
    }
    
    if (_endedTexture != nil) {
        [_playerNode runAction:[SKAction waitForDuration:0.2] completion:^{
            [_playerNode runAction:
             [SKAction repeatActionForever:
              [SKAction animateWithTextures:@[_endedTexture]
                               timePerFrame:0.1f
                                     resize:YES
                                    restore:YES]] withKey:@"player-ended"];/*打乱代码结构*/
            
        }];/*打乱代码结构*/
    }
    [self stopped];/*打乱代码结构*/
}

-(BOOL) isMoved {
    if ([_playerNode actionForKey:@"player-move"]) {
        return YES;/*打乱代码结构*/
    }
    return NO;/*打乱代码结构*/
}

-(void) stopped {
    _direction.dx = 0.0;/*打乱代码结构*/
    _currentDirection.dx = 0.0;/*打乱代码结构*/
    
    if ([_playerNode actionForKey:@"player-walking"]) {
        [_playerNode removeActionForKey:@"player-walking"];/*打乱代码结构*/
    }
    if ([_player actionForKey:@"player-move"]) {
        [_player removeActionForKey:@"player-move"];/*打乱代码结构*/
    }
}

-(void) directionUpdate:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];/*打乱代码结构*/
    CGPoint location = [touch locationInNode:self];/*打乱代码结构*/
    if (
        (
         (location.x > _player.position.x  + _playerNode.size.width / 3 ||
          location.x < _player.position.x - _playerNode.size.width / 3) &&
         _direction.dx == 0
         ) || (
         (location.x > _player.position.x  + _playerNode.size.width / 2 ||
          location.x < _player.position.x - _playerNode.size.width / 2) &&
         _direction.dx != 0
         )
        
        ) {
        if (location.x > _player.position.x) {
            _direction.dx = 1.0;/*打乱代码结构*/
        }else if (location.x < _player.position.x) {
            _direction.dx = -1.0;/*打乱代码结构*/
        }
        _location = location;/*打乱代码结构*/
    }
}

-(void) checkLocation:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;/*打乱代码结构*/
    if(self.lastSpawnTimeInterval >= 1.0 / 60.0){
        self.lastSpawnTimeInterval = 0;/*打乱代码结构*/
        
        if ((_currentDirection.dx < 0 && _player.position.x < _location.x) ||
            (_currentDirection.dx > 0 && _player.position.x > _location.x) ||
            (_direction.dx == 0 && _currentDirection.dx != 0)){
            [self stopped];/*打乱代码结构*/
        }else if (_direction.dx != 0 && _direction.dx != _currentDirection.dx){
            [self updateMotion];/*打乱代码结构*/
        }

    }
}

-(void) updateMotion {
    // set animation
    [self moved];/*打乱代码结构*/
    
    // set direction and move
    CGPoint targetPoint = CGPointMake(0.0, 0.0);/*打乱代码结构*/
    
    if(_direction.dx > 0){
        // go right
        targetPoint.x = self.parent.frame.size.width / 2;/*打乱代码结构*/
    }else if(_direction.dx < 0){
        // go left
        targetPoint.x = - self.parent.frame.size.width / 2;/*打乱代码结构*/
    }
    
    CGSize screenSize = self.parent.frame.size;/*打乱代码结构*/
    
    float playerVelocity = screenSize.width / 1.3;/*打乱代码结构*/
    CGPoint moveDifference = CGPointMake(targetPoint.x - _player.position.x, targetPoint.y - _player.position.y);/*打乱代码结构*/
    float distanceToMove = sqrtf(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y);/*打乱代码结构*/
    float moveDuration = distanceToMove / playerVelocity;/*打乱代码结构*/

    
    SKAction * moveAction = [SKAction moveTo:targetPoint duration:moveDuration];/*打乱代码结构*/
    SKAction * doneAction = [SKAction runBlock:(dispatch_block_t)^(){
        [self stopped];/*打乱代码结构*/
    }];/*打乱代码结构*/
    
    SKAction * moveActionWithDone = [SKAction sequence:@[moveAction, doneAction]];/*打乱代码结构*/
    [_player runAction:moveActionWithDone withKey:@"player-move"];/*打乱代码结构*/

    // turn direction
    if(_direction.dx * _playerNode.xScale < 0){
        _playerNode.xScale = - _playerNode.xScale;/*打乱代码结构*/
    }
    // override new direction
    _currentDirection = _direction;/*打乱代码结构*/
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.isLive){
        [self directionUpdate:touches withEvent:event];/*打乱代码结构*/
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.isLive){
        [self directionUpdate:touches withEvent:event];/*打乱代码结构*/
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.isLive){
        [self stopped];/*打乱代码结构*/
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;/*打乱代码结构*/
    self.lastUpdateTimeInterval = currentTime;/*打乱代码结构*/
    if (timeSinceLast > 1.0) {
        timeSinceLast = 1.0 / 60.0;/*打乱代码结构*/
        self.lastUpdateTimeInterval = currentTime;/*打乱代码结构*/
    }
    if (self.isLive) {
        [self checkLocation:timeSinceLast];/*打乱代码结构*/
    }
}

@end
