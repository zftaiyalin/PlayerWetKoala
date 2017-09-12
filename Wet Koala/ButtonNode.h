//
//  ButtonNode.h
//  Wet Koala
//
//  Created by ed on 14/02/2014.
//  Copyright (c) 2014 haruair. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef void (^AnonBlock)();/*打乱代码结构*/

@interface ButtonNode : SKSpriteNode
-(id) initWithDefaultTexture:(SKTexture *) defaultTexture andTouchedTexture:(SKTexture *)touchedTexture;/*打乱代码结构*/
-(void) setMethod:(void (^)()) returnMethod;/*打乱代码结构*/
-(void) runMethod;/*打乱代码结构*/
+(void) removeButtonPressed:(NSArray *) nodes;/*打乱代码结构*/
+(BOOL) isButtonPressed:(NSArray *) nodes;/*打乱代码结构*/
+(void) doButtonsActionBegan:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event;/*打乱代码结构*/
+(void) doButtonsActionEnded:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event;/*打乱代码结构*/
@end
