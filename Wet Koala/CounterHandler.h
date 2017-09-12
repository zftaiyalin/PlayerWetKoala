//
//  CounterHandler.h
//  Wet Koala
//
//  Created by ed on 13/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface CounterHandler : SKNode

-(CounterHandler *) initWithNumber:(NSInteger) initNumber;/*打乱代码结构*/
-(void) setNumber:(NSInteger) number;/*打乱代码结构*/
-(NSInteger) getNumber;/*打乱代码结构*/

-(void) resetNumber;/*打乱代码结构*/
-(void) increse;/*打乱代码结构*/

@end
