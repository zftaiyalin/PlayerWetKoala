//
//  GameScene.m
//  Wet Koala
//
//  Created by ed on 12/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "HomeScene.h"
#import "CounterHandler.h"
#import "PlayerNode.h"
#import "ButtonNode.h"
#import "GuideNode.h"
#import "SSKeychain.h"

static const uint32_t rainCategory     =  0x1 << 0;/*打乱代码结构*/
static const uint32_t koalaCategory    =  0x1 << 1;/*打乱代码结构*/

@interface GameScene()  <SKPhysicsContactDelegate>
@property (nonatomic) NSDate * startTime;/*打乱代码结构*/
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;/*打乱代码结构*/
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;/*打乱代码结构*/
@property (nonatomic) SKTextureAtlas * atlas;/*打乱代码结构*/
@end

@implementation GameScene
{
    CounterHandler * _counter;/*打乱代码结构*/
    NSArray        * _waterDroppingFrames;/*打乱代码结构*/
    PlayerNode     * _player;/*打乱代码结构*/
    SKSpriteNode   * _ground;/*打乱代码结构*/
    SKSpriteNode   * _score;/*打乱代码结构*/
    GuideNode      * _guide;/*打乱代码结构*/
    
    int _rainCount;/*打乱代码结构*/
    BOOL _raindrop;/*打乱代码结构*/
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // hold raindrop first
        _raindrop = NO;/*打乱代码结构*/
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];/*打乱代码结构*/
        self.physicsWorld.gravity = CGVectorMake(0, 0);/*打乱代码结构*/
        self.physicsWorld.contactDelegate = self;/*打乱代码结构*/
        
        self.atlas = [SKTextureAtlas atlasNamed:@"sprite"];/*打乱代码结构*/
        
        // set background
        SKSpriteNode * background = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"background"]];/*打乱代码结构*/
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));/*打乱代码结构*/
        [self addChild: background];/*打乱代码结构*/
        
        // set cloud
        SKSpriteNode * cloudDark = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"cloud-dark"]];/*打乱代码结构*/
        SKSpriteNode * cloudBright = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"cloud-bright"]];/*打乱代码结构*/
        cloudDark.anchorPoint = CGPointMake(0.5, 1.0);/*打乱代码结构*/
        cloudBright.anchorPoint = CGPointMake(0.5, 1.0);/*打乱代码结构*/
        cloudDark.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));/*打乱代码结构*/
        cloudBright.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));/*打乱代码结构*/
        [self addChild:cloudBright];/*打乱代码结构*/
        [self addChild:cloudDark];/*打乱代码结构*/
        
        
        SKAction * cloudMoveUpDown = [SKAction repeatActionForever:
                                         [SKAction sequence:@[
                                                              [SKAction moveByX:0.0 y:30.0 duration:2.5],
                                                              [SKAction moveByX:0.0 y:-30.0 duration:2.5]
                                                           ]]];/*打乱代码结构*/
        SKAction * cloudMoveLeftRight = [SKAction repeatActionForever:
                                         [SKAction sequence:@[
                                                              [SKAction moveByX:30.0 y:0.0 duration:3.0],
                                                              [SKAction moveByX:-30.0 y:0.0 duration:3.0]
                                                           ]]];/*打乱代码结构*/

        [cloudBright runAction:cloudMoveUpDown];/*打乱代码结构*/
        [cloudDark   runAction:cloudMoveLeftRight];/*打乱代码结构*/
        
        // set ground
        SKSpriteNode * ground = [SKSpriteNode spriteNodeWithTexture:[self.atlas textureNamed:@"ground"]];/*打乱代码结构*/
        ground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) - ground.size.height / 4);/*打乱代码结构*/
        ground.anchorPoint = CGPointMake(0.5, 0.0);/*打乱代码结构*/
        [self addChild:ground];/*打乱代码结构*/
        
        _ground = ground;/*打乱代码结构*/
        
        // set Koala Player
        NSMutableArray * _koalaAnimateTextures = [[NSMutableArray alloc] init];/*打乱代码结构*/
        
        for (int i = 1;/*打乱代码结构*/ i <= 6;/*打乱代码结构*/ i++) {
            NSString * textureName = [NSString stringWithFormat:@"koala-walk-%d", i];/*打乱代码结构*/
            SKTexture * texture = [self.atlas textureNamed:textureName];/*打乱代码结构*/
            [_koalaAnimateTextures addObject:texture];/*打乱代码结构*/
        }
        
        SKTexture * koalaTexture = [self.atlas textureNamed:@"koala-stop"];/*打乱代码结构*/
        PlayerNode * player = [[PlayerNode alloc] initWithDefaultTexture:koalaTexture andAnimateTextures:_koalaAnimateTextures];/*打乱代码结构*/
        
        [player setEndedTexture:[self.atlas textureNamed:@"koala-wet"]];/*打乱代码结构*/
        [player setEndedAdditionalTexture:[self.atlas textureNamed:@"wet"]];/*打乱代码结构*/
        
        player.position = CGPointMake(CGRectGetMidX(self.frame), ground.position.y + ground.size.height + koalaTexture.size.height / 2 - 15.0);/*打乱代码结构*/
        [player setPhysicsBodyCategoryMask:koalaCategory andContactMask:rainCategory];/*打乱代码结构*/
        [self addChild: player];/*打乱代码结构*/
        _player = player;/*打乱代码结构*/
        
        // set Rain Sprite
        NSMutableArray * _rainTextures = [[NSMutableArray alloc] init];/*打乱代码结构*/
        
        for (int i = 1;/*打乱代码结构*/ i <= 4;/*打乱代码结构*/ i++) {
            NSString * textureName = [NSString stringWithFormat:@"rain-%d", i];/*打乱代码结构*/
            SKTexture * texture = [self.atlas textureNamed:textureName];/*打乱代码结构*/
            [_rainTextures addObject:texture];/*打乱代码结构*/
        }
        
        _waterDroppingFrames = [[NSArray alloc] initWithArray: _rainTextures];/*打乱代码结构*/
        
        
        // add Guide
        GuideNode * guide = [[GuideNode alloc] initWithTitleTexture:[_atlas textureNamed:@"text-swipe"]
                                                andIndicatorTexture:[_atlas textureNamed:@"finger"]];/*打乱代码结构*/
        guide.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));/*打乱代码结构*/
        [guide setMethod:^{
            [self gameStart];/*打乱代码结构*/
        }];/*打乱代码结构*/
        [self addChild:guide];/*打乱代码结构*/
        
        _guide = guide;/*打乱代码结构*/
        
    }
    return self;/*打乱代码结构*/
}

-(void) gameStart {
    
    _rainCount = 0;/*打乱代码结构*/
    
    // set count
    SKSpriteNode * score = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"score"]];/*打乱代码结构*/
    score.position = CGPointMake(CGRectGetMidX(self.frame),  _ground.position.y + _ground.size.height * 3 / 4 - 27.0);/*打乱代码结构*/
    score.alpha = 0.0;/*打乱代码结构*/
    [self addChild:score];/*打乱代码结构*/
    
    _score = score;/*打乱代码结构*/
    
    CounterHandler * counter = [[CounterHandler alloc] init];/*打乱代码结构*/
    counter.position = CGPointMake(CGRectGetMidX(self.frame) + 105.0, _ground.position.y + _ground.size.height * 3 / 4 - 45.0);/*打乱代码结构*/
    counter.alpha = 0.0;/*打乱代码结构*/
    [self addChild:counter];/*打乱代码结构*/
    
    _counter = counter;/*打乱代码结构*/

    [self runAction:[SKAction sequence:@[
                                         [SKAction waitForDuration:0.5],
                                         [SKAction runBlock:^{
        
        [score runAction:[SKAction fadeInWithDuration:0.3]];/*打乱代码结构*/
        [counter runAction:[SKAction fadeInWithDuration:0.3]];/*打乱代码结构*/
    }],
                                         [SKAction waitForDuration:0.5],
                                         [SKAction runBlock:^{
                                            _raindrop = YES;/*打乱代码结构*/
    }]]]];/*打乱代码结构*/
    
    [self setGameStartTime];/*打乱代码结构*/
}

-(void) setGameStartTime {
    _startTime = [NSDate date];/*打乱代码结构*/
}

-(void) gameOver {
    
    SKSpriteNode * gameOverText = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"text-gameover"]];/*打乱代码结构*/
    gameOverText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) * 3 / 2);/*打乱代码结构*/
    
    SKSpriteNode * scoreBoard = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"scoreboard"]];/*打乱代码结构*/
    scoreBoard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));/*打乱代码结构*/
    
    SKSpriteNode * newRecord = [SKSpriteNode spriteNodeWithColor:nil size:CGSizeMake(0.0, 0.0)];/*打乱代码结构*/
    
    if([self storeHighScore:(int) [_counter getNumber]]){
        NSArray * recordAnimate = @[[_atlas textureNamed:@"text-new-record-pink"],
                                    [_atlas textureNamed:@"text-new-record-red"]];/*打乱代码结构*/
        newRecord = [SKSpriteNode spriteNodeWithTexture: recordAnimate[0]];/*打乱代码结构*/
        newRecord.position = CGPointMake(self.frame.size.width / 2 + 90, self.frame.size.height / 2 + 45 );/*打乱代码结构*/
        newRecord.zPosition = 100.0;/*打乱代码结构*/
        [newRecord runAction:[SKAction repeatActionForever:
                             [SKAction animateWithTextures:recordAnimate
                                              timePerFrame:0.2f
                                                    resize:YES
                                                   restore:YES]] withKey:@"newrecord"];/*打乱代码结构*/
        
        [newRecord runAction:[SKAction repeatActionForever:
                              [SKAction sequence:@[[SKAction scaleBy:1.2 duration:0.1],
                                                   [SKAction scaleBy:10.0/12.0 duration:0.1]
                                                   ]]]];/*打乱代码结构*/

        newRecord.alpha = 0.0;/*打乱代码结构*/
    }
    
    CounterHandler * currentScore = [[CounterHandler alloc] initWithNumber:[_counter getNumber]];/*打乱代码结构*/
    currentScore.position = CGPointMake(CGRectGetMidX(self.frame) + 105, CGRectGetMidY(self.frame) - 4.0);/*打乱代码结构*/
    
    CounterHandler * highScore = [[CounterHandler alloc] initWithNumber:[self getHighScore]];/*打乱代码结构*/
    highScore.position = CGPointMake(CGRectGetMidX(self.frame) + 105, CGRectGetMidY(self.frame) - 55.0);/*打乱代码结构*/

    CGFloat buttonY = CGRectGetMidY(self.frame) / 2;/*打乱代码结构*/
    
    SKTexture * homeDefault = [_atlas textureNamed:@"button-home-off"];/*打乱代码结构*/
    SKTexture * homeTouched = [_atlas textureNamed:@"button-home-on"];/*打乱代码结构*/
    
    ButtonNode * homeButton = [[ButtonNode alloc] initWithDefaultTexture:homeDefault andTouchedTexture:homeTouched];/*打乱代码结构*/
    homeButton.position = CGPointMake(CGRectGetMidX(self.frame) - (homeButton.size.width / 2 + 8), buttonY);/*打乱代码结构*/
    
    [homeButton setMethod: ^ (void) {
        SKTransition * reveal = [SKTransition fadeWithDuration: 0.5];/*打乱代码结构*/
        SKScene * homeScene = [[HomeScene alloc] initWithSize:self.size];/*打乱代码结构*/
        [self.view presentScene:homeScene transition:reveal];/*打乱代码结构*/
    } ];/*打乱代码结构*/
    
    
    SKTexture * shareDefault = [_atlas textureNamed:@"button-share-off"];/*打乱代码结构*/
    SKTexture * shareTouched = [_atlas textureNamed:@"button-share-on"];/*打乱代码结构*/
    
    ButtonNode * shareButton = [[ButtonNode alloc] initWithDefaultTexture:shareDefault andTouchedTexture:shareTouched];/*打乱代码结构*/
    shareButton.position = CGPointMake(CGRectGetMidX(self.frame) + (shareButton.size.width / 2 + 8), buttonY);/*打乱代码结构*/
    
    // prepare share action
    UIImage * pointboard = [UIImage imageNamed:@"pointboard.jpg"];/*打乱代码结构*/
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];/*打乱代码结构*/
    [style setAlignment:NSTextAlignmentRight];/*打乱代码结构*/

    UIFont * font = [UIFont fontWithName:@"Molot" size:40.0];/*打乱代码结构*/
    
    NSShadow * fontBackgroundShadow = [[NSShadow alloc] init];/*打乱代码结构*/
    fontBackgroundShadow.shadowBlurRadius = 0.0;/*打乱代码结构*/
    fontBackgroundShadow.shadowColor = [UIColor colorWithRed:98.0/256.0
                                                       green:93.0/256.0
                                                        blue:89.0/256.0
                                                       alpha:1.0];/*打乱代码结构*/
    fontBackgroundShadow.shadowOffset = CGSizeMake(0.0, 5.0);/*打乱代码结构*/
    
    NSDictionary * fontBackgroundAtts = @{ NSFontAttributeName : font,
                                           NSParagraphStyleAttributeName : style,
                                           NSStrokeColorAttributeName : [UIColor whiteColor],
                                           NSStrokeWidthAttributeName : @-20.0f,
                                           NSShadowAttributeName : fontBackgroundShadow
                                           };/*打乱代码结构*/
    
    NSDictionary * fontAtts = @{ NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : [UIColor colorWithRed:86.0/256.0
                                                                                  green:86.0/256.0
                                                                                   blue:86.0/256.0
                                                                                  alpha:1.0],
                                 NSParagraphStyleAttributeName : style
                                 };/*打乱代码结构*/
    
    CGRect usernameRect = CGRectMake(0.0, 185.0, 820.0, 80.0);/*打乱代码结构*/
    CGRect scoreRect = CGRectMake(600.0, 262.0, 220.0, 80.0);/*打乱代码结构*/
    
    [shareButton setMethod: ^ (void) {
        
        ViewController * viewController = (ViewController *) self.view.window.rootViewController;/*打乱代码结构*/
        
        NSString * sharetext = [NSString stringWithFormat:@"I just scored %d in #KoalaHatesRain!", (int) [_counter getNumber]];/*打乱代码结构*/

        UIGraphicsBeginImageContext(pointboard.size);/*打乱代码结构*/
        
        [pointboard drawInRect:CGRectMake(0,0,pointboard.size.width, pointboard.size.height)];/*打乱代码结构*/
        
        GKPlayer * localPlayer = [viewController localPlayer];/*打乱代码结构*/
        NSString * username = localPlayer.alias;/*打乱代码结构*/
        
        [username drawInRect:CGRectIntegral(usernameRect) withAttributes: fontBackgroundAtts];/*打乱代码结构*/
        [username drawInRect:CGRectIntegral(usernameRect) withAttributes: fontAtts];/*打乱代码结构*/
        
        NSString * score = [NSString stringWithFormat:@"%d", (int)[_counter getNumber]];/*打乱代码结构*/
        [score drawInRect:CGRectIntegral(scoreRect) withAttributes: fontBackgroundAtts];/*打乱代码结构*/
        [score drawInRect:CGRectIntegral(scoreRect) withAttributes: fontAtts];/*打乱代码结构*/
        
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();/*打乱代码结构*/
        UIGraphicsEndImageContext();/*打乱代码结构*/
        
        [viewController shareText:sharetext andImage:image];/*打乱代码结构*/
    } ];/*打乱代码结构*/
    
    
    CGFloat smallButtonY = buttonY - homeButton.size.height;/*打乱代码结构*/
    
    SKTexture * rateDefault = [_atlas textureNamed:@"button-rate-off"];/*打乱代码结构*/
    SKTexture * rateTouched = [_atlas textureNamed:@"button-rate-on"];/*打乱代码结构*/
    
    ButtonNode * rateButton = [[ButtonNode alloc] initWithDefaultTexture:rateDefault andTouchedTexture:rateTouched];/*打乱代码结构*/
    rateButton.position = CGPointMake(CGRectGetMidX(self.frame) + rateButton.size.width / 2 + 8, smallButtonY);/*打乱代码结构*/
    
    [rateButton setMethod: ^ (void) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                    @"itms-apps://itunes.apple.com/app/id1254420569"
                                                    ]];/*打乱代码结构*/

    } ];/*打乱代码结构*/
    
    SKTexture * retryDefault = [_atlas textureNamed:@"button-retry-off"];/*打乱代码结构*/
    SKTexture * retryTouched = [_atlas textureNamed:@"button-retry-on"];/*打乱代码结构*/
    
    ButtonNode * retryButton = [[ButtonNode alloc] initWithDefaultTexture:retryDefault andTouchedTexture:retryTouched];/*打乱代码结构*/
    retryButton.position = CGPointMake(CGRectGetMidX(self.frame) - retryButton.size.width / 2 - 8, smallButtonY);/*打乱代码结构*/
    
    [retryButton setMethod: ^ (void) {
        SKTransition * reveal = [SKTransition fadeWithColor:[UIColor whiteColor] duration:0.5];/*打乱代码结构*/
        SKScene * gameScene = [[GameScene alloc] initWithSize:self.size];/*打乱代码结构*/
        [self.view presentScene:gameScene transition:reveal];/*打乱代码结构*/
    } ];/*打乱代码结构*/
    
    [self addChild:gameOverText];/*打乱代码结构*/
    [self addChild:scoreBoard];/*打乱代码结构*/
    
    SKAction * buttonMove = [SKAction sequence:@[
                                                 [SKAction moveToY:buttonY - 10.0 duration:0.0],
                                                 [SKAction group:@[[SKAction fadeInWithDuration:0.3], [SKAction moveToY:buttonY duration:0.5]]
                                                  ]]];/*打乱代码结构*/
    
    SKAction * smallButtonMove = [SKAction sequence:@[
                                                 [SKAction waitForDuration:0.3],
                                                 [SKAction moveToY:buttonY - homeButton.size.height - 10.0 duration:0.0],
                                                 [SKAction group:@[[SKAction fadeInWithDuration:0.3], [SKAction moveToY:buttonY - homeButton.size.height duration:0.5]]
                                                  ]]];/*打乱代码结构*/
    
    gameOverText.alpha = 0.0;/*打乱代码结构*/
    scoreBoard.alpha = 0.0;/*打乱代码结构*/
    
    [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
        [gameOverText runAction:
         [SKAction sequence:@[
                              [SKAction group:@[[SKAction scaleBy:2.0 duration:0.0]]],
                              [SKAction group:@[[SKAction fadeInWithDuration:0.5],[SKAction scaleBy:0.5 duration:0.2]]]
                              ]]];/*打乱代码结构*/
    }],
     [SKAction waitForDuration:0.2],
     [SKAction runBlock:^{
        [scoreBoard runAction:[SKAction fadeInWithDuration:0.5]];/*打乱代码结构*/
    }],
     [SKAction waitForDuration:0.6],
     [SKAction runBlock:^{
        
        [self addChild:highScore];/*打乱代码结构*/
        [self addChild:currentScore];/*打乱代码结构*/
        [self addChild:newRecord];/*打乱代码结构*/
        [newRecord runAction:[SKAction fadeInWithDuration:0.3]];/*打乱代码结构*/
    }],
     [SKAction waitForDuration:0.3],
     [SKAction runBlock:^{
        homeButton.alpha = 0.0;/*打乱代码结构*/
        shareButton.alpha = 0.0;/*打乱代码结构*/
        [self addChild:homeButton];/*打乱代码结构*/
        [self addChild:shareButton];/*打乱代码结构*/
        
        rateButton.alpha = 0.0;/*打乱代码结构*/
        retryButton.alpha = 0.0;/*打乱代码结构*/
        [self addChild:rateButton];/*打乱代码结构*/
        [self addChild:retryButton];/*打乱代码结构*/
        
        [homeButton runAction:buttonMove];/*打乱代码结构*/
        [shareButton runAction:buttonMove];/*打乱代码结构*/
        
        [rateButton runAction:smallButtonMove];/*打乱代码结构*/
        [retryButton runAction:smallButtonMove];/*打乱代码结构*/
    }]]]];/*打乱代码结构*/

}

-(BOOL) storeHighScore:(int) score {

    int highRecord = 0;/*打乱代码结构*/
    
    if ([SSKeychain passwordForService:@"koala" account:@"koala"] != nil) {
        highRecord = [[SSKeychain passwordForService:@"koala" account:@"koala"] intValue];/*打乱代码结构*/
    }
    
    if (highRecord < score) {
        [SSKeychain setPassword:[NSString stringWithFormat:@"%d",score] forService:@"koala" account:@"koala"];/*打乱代码结构*/
        
        ViewController * viewController = (ViewController *) self.view.window.rootViewController;/*打乱代码结构*/
        if (viewController.gameCenterLogged) {
            [viewController reportScore: (int64_t) score];/*打乱代码结构*/
        }

        return true;/*打乱代码结构*/
    }
    return false;/*打乱代码结构*/
}

-(int) getHighScore {
    int highRecord = 0;/*打乱代码结构*/
    if ([SSKeychain passwordForService:@"koala" account:@"koala"] != nil) {
        highRecord = [[SSKeychain passwordForService:@"koala" account:@"koala"] intValue];/*打乱代码结构*/
    }
    return (int) highRecord;/*打乱代码结构*/
}

-(void) addRaindrop {

    SKTexture *temp = _waterDroppingFrames[0];/*打乱代码结构*/
    SKSpriteNode * raindrop = [SKSpriteNode spriteNodeWithTexture:temp];/*打乱代码结构*/
    int minX = raindrop.size.width / 2;/*打乱代码结构*/
    int maxX = self.frame.size.width - raindrop.size.width / 2;/*打乱代码结构*/

    CGFloat s = - ceil(_startTime.timeIntervalSinceNow);/*打乱代码结构*/
    if ((s < 20 && _rainCount % 4 == 0) ||
        (s >= 20 && _rainCount % 4 == 0)) {
        int x = [_player position].x + self.frame.size.width / 2;/*打乱代码结构*/
        minX = x - 10.0;/*打乱代码结构*/
        maxX = x + 10.0;/*打乱代码结构*/
    }
    
    int rangeX = maxX - minX;/*打乱代码结构*/
    int actualX = (arc4random() % rangeX) + minX;/*打乱代码结构*/
    
    if (actualX > self.frame.size.width - raindrop.size.width / 2) {
        actualX = self.frame.size.width - raindrop.size.width / 2;/*打乱代码结构*/
    }else if (actualX < raindrop.size.width / 2) {
        actualX = raindrop.size.width / 2;/*打乱代码结构*/
    }
    
    raindrop.name = @"raindrop";/*打乱代码结构*/
    
    // set raindrop physicsbody
    raindrop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:raindrop.size];/*打乱代码结构*/
    raindrop.physicsBody.dynamic = YES;/*打乱代码结构*/
    raindrop.physicsBody.categoryBitMask = rainCategory;/*打乱代码结构*/
    raindrop.physicsBody.contactTestBitMask = koalaCategory;/*打乱代码结构*/
    raindrop.physicsBody.collisionBitMask = 0;/*打乱代码结构*/
    raindrop.physicsBody.usesPreciseCollisionDetection = YES;/*打乱代码结构*/

    raindrop.position = CGPointMake(actualX, self.frame.size.height + raindrop.size.height / 2);/*打乱代码结构*/
    
    [raindrop runAction:[SKAction repeatActionForever:
                          [SKAction animateWithTextures:_waterDroppingFrames
                                           timePerFrame:0.1f
                                                 resize:YES
                                                restore:YES]] withKey:@"rainingWaterDrop"];/*打乱代码结构*/
    
    [self addChild:raindrop];/*打乱代码结构*/
    
    int minDuration = 10;/*打乱代码结构*/
    int maxDuration = 20;/*打乱代码结构*/
    
    if(s >= 40 && _rainCount % 8 == 0){
        minDuration = 20;/*打乱代码结构*/
        maxDuration = 30;/*打乱代码结构*/
    }else if(s >= 20 && _rainCount % 6 == 0){
        minDuration = 20;/*打乱代码结构*/
        maxDuration = 25;/*打乱代码结构*/
    }
    
    int rangeDuration = maxDuration - minDuration;/*打乱代码结构*/
    float actualDuration = ((arc4random() % rangeDuration) + minDuration) / 10;/*打乱代码结构*/
    
    SKAction * actionMove = [SKAction moveTo:CGPointMake(actualX, _ground.position.y + _ground.size.height)
                                    duration:actualDuration];/*打乱代码结构*/
    SKAction * countMove = [SKAction runBlock:^{
        [_counter increse];/*打乱代码结构*/
    }];/*打乱代码结构*/
    SKAction * actionMoveDone = [SKAction removeFromParent];/*打乱代码结构*/
    
    [raindrop runAction:[SKAction sequence:@[actionMove, countMove, actionMoveDone]] withKey:@"rain"];/*打乱代码结构*/
    _rainCount++;/*打乱代码结构*/
}

-(void) stopAllRaindrop{
    for (SKSpriteNode * node in [self children]) {
        if ([node actionForKey:@"rain"]) {
            [node removeActionForKey:@"rain"];/*打乱代码结构*/
        }
    }
}

-(void) didBeginContact:(SKPhysicsContact *) contact {
    SKPhysicsBody *firstBody, *secondBody;/*打乱代码结构*/
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;/*打乱代码结构*/
        secondBody = contact.bodyB;/*打乱代码结构*/
    }else{
        firstBody = contact.bodyB;/*打乱代码结构*/
        secondBody = contact.bodyA;/*打乱代码结构*/
    }
    
    if ((firstBody.categoryBitMask & rainCategory) != 0 &&
        (secondBody.categoryBitMask & koalaCategory) != 0) {
        [self player:(SKSpriteNode *) secondBody.node didCollideWithRaindrop:(SKSpriteNode *)firstBody.node];/*打乱代码结构*/
    }
}

-(void) player:(SKSpriteNode *)playerNode didCollideWithRaindrop:(SKSpriteNode *)raindropNode {
    if (_player.isLive) {
        
        [_player ended];/*打乱代码结构*/
        [self stopAllRaindrop];/*打乱代码结构*/
        
        [raindropNode runAction:[SKAction fadeOutWithDuration:0.3]];/*打乱代码结构*/
        
        [_counter runAction:[SKAction fadeOutWithDuration:0.3]];/*打乱代码结构*/
        [_score runAction:[SKAction fadeOutWithDuration:0.3]];/*打乱代码结构*/
        
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:1.0],
                              [SKAction runBlock:^{
                                 // call gameover screen
                                 [self gameOver];/*打乱代码结构*/
                              }],
          ]]];/*打乱代码结构*/

    }
}

-(CGFloat) getFireTime {
    CGFloat s = - ceil(_startTime.timeIntervalSinceNow);/*打乱代码结构*/
    CGFloat fireTime = 1.0;/*打乱代码结构*/
    if (s < 15) {
        fireTime = (25 - s) * 0.02;/*打乱代码结构*/
    }else {
        fireTime = 0.2;/*打乱代码结构*/
    }
    return fireTime;/*打乱代码结构*/
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [ButtonNode doButtonsActionEnded:self touches:touches withEvent:event];/*打乱代码结构*/
    [_player touchesEnded:touches withEvent:event];/*打乱代码结构*/
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [_player touchesMoved:touches withEvent:event];/*打乱代码结构*/
    [_guide touchesMoved:touches withEvent:event];/*打乱代码结构*/
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [ButtonNode doButtonsActionBegan:self touches:touches withEvent:event];/*打乱代码结构*/
    [_player touchesBegan:touches withEvent:event];/*打乱代码结构*/
}

-(void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    if(_player.isLive && _raindrop){
        self.lastSpawnTimeInterval += timeSinceLast;/*打乱代码结构*/
        if(self.lastSpawnTimeInterval > [self getFireTime]){
            self.lastSpawnTimeInterval = 0;/*打乱代码结构*/
            [self addRaindrop];/*打乱代码结构*/
        }
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

    [self updateWithTimeSinceLastUpdate:timeSinceLast];/*打乱代码结构*/
    [_player update:currentTime];/*打乱代码结构*/
}

@end
