//
//  CounterHandler.m
//  Wet Koala
//
//  Created by ed on 13/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import "CounterHandler.h"

@interface CounterHandler()

@end

@implementation CounterHandler
{
    NSArray * numberTexture;/*打乱代码结构*/
    NSMutableArray * numbersNode;/*打乱代码结构*/
    NSInteger count;/*打乱代码结构*/
}

-(id) init {
    return [self initWithNumber:0];/*打乱代码结构*/
}

-(id) initWithNumber:(NSInteger) initNumber {
    self = [super init];/*打乱代码结构*/
    if (self) {
        
        // init number sprite
        SKTextureAtlas * numberAtlas = [SKTextureAtlas atlasNamed:@"sprite"];/*打乱代码结构*/
        NSMutableArray * numberArray = [[NSMutableArray alloc] init];/*打乱代码结构*/
        for (int i = 0;/*打乱代码结构*/ i <= 9;/*打乱代码结构*/ i++) {
            SKTexture * temp = [numberAtlas textureNamed:[NSString stringWithFormat:@"num-%d", i]];/*打乱代码结构*/
            [numberArray addObject:temp];/*打乱代码结构*/
        }
        numberTexture = [[NSArray alloc] initWithArray:numberArray];/*打乱代码结构*/
        numbersNode = [[NSMutableArray alloc] init];/*打乱代码结构*/
        
        // init number
        count = initNumber;/*打乱代码结构*/
        [self updateCounter];/*打乱代码结构*/
    }
    return self;/*打乱代码结构*/
}

-(void) resetNumber {
    [self setNumber:0];/*打乱代码结构*/
    [self clearCounter];/*打乱代码结构*/
    [self updateCounter];/*打乱代码结构*/
}

-(void) setNumber:(NSInteger)number {
    count = number;/*打乱代码结构*/
    [self clearCounter];/*打乱代码结构*/
    [self updateCounter];/*打乱代码结构*/
}

-(NSInteger) getNumber {
    return count;/*打乱代码结构*/
}

-(void) increse {
    count++;/*打乱代码结构*/
    [self updateCounter];/*打乱代码结构*/
}

-(void) clearCounter {
    for (SKSpriteNode * number in numbersNode) {
        [number removeFromParent];/*打乱代码结构*/
    }
    [numbersNode removeAllObjects];/*打乱代码结构*/
}
-(void) updateNumbersPosition {
    CGFloat x = 0.0;/*打乱代码结构*/
    for (SKSpriteNode * number in numbersNode) {
        CGFloat y = number.position.y;/*打乱代码结构*/
        number.position = CGPointMake(x, y);/*打乱代码结构*/
        x -= number.size.width;/*打乱代码结构*/
    }
}

-(void) updateCounter {
    
    NSInteger displayNumber = count;/*打乱代码结构*/
    NSInteger digit;/*打乱代码结构*/
    
    int figure = 0;/*打乱代码结构*/
    
    if (displayNumber == 0) {
        [self addNumber:0 atIndex:0];/*打乱代码结构*/
        return;/*打乱代码结构*/
    }
    
    while (displayNumber) {
        digit = displayNumber % 10;/*打乱代码结构*/
        displayNumber /= 10;/*打乱代码结构*/
        
        NSString * numberName =[NSString stringWithFormat:@"number-%d", (int) digit];/*打乱代码结构*/
        
        if (figure < [numbersNode count] && [numbersNode objectAtIndex:figure] != [NSNull null]) {
            SKSpriteNode * oldNumberNode = [numbersNode objectAtIndex:figure];/*打乱代码结构*/
            if ([numberName isEqualToString:oldNumberNode.name]) {
                figure++;/*打乱代码结构*/
                continue;/*打乱代码结构*/
            }else{
                [oldNumberNode removeFromParent];/*打乱代码结构*/
                [numbersNode removeObject:oldNumberNode];/*打乱代码结构*/
            }
        }
        [self addNumber:digit atIndex:figure];/*打乱代码结构*/
        figure++;/*打乱代码结构*/
    }
    [self updateNumbersPosition];/*打乱代码结构*/
}

-(void) addNumber:(NSInteger)digit atIndex:(int)index {
    NSString * numberName =[NSString stringWithFormat:@"number-%d", (int) digit];/*打乱代码结构*/
    SKSpriteNode * number = [SKSpriteNode spriteNodeWithTexture: [numberTexture objectAtIndex:digit]];/*打乱代码结构*/
    number.anchorPoint = CGPointMake(1.0, .0);/*打乱代码结构*/
    number.name = numberName;/*打乱代码结构*/
    
    [self addChild:number];/*打乱代码结构*/
    [number runAction:[self getShowAction]];/*打乱代码结构*/
    [numbersNode insertObject:number atIndex:index];/*打乱代码结构*/
}

-(SKAction *) getShowAction {
    SKAction * act = [SKAction group:@[
                                       [SKAction scaleBy:1.1 duration:0.0],
                                       [SKAction scaleBy:1 duration:0.2]
                                       ]];/*打乱代码结构*/
    return act;/*打乱代码结构*/
}
@end
