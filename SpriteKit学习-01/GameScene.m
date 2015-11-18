//
//  GameScene.m
//  SpriteKit学习-01
//
//  Created by guochaoyang on 15/11/18.
//  Copyright (c) 2015年 guochaoyang. All rights reserved.
//

#import "GameScene.h"
#import "SpaceshipScene.h"

@interface GameScene ()

@property (nonatomic)BOOL contentCreated;
@end

@implementation GameScene

//-(void)didMoveToView:(SKView *)view {
//    /* Setup your scene here */
//    self.backgroundColor = [UIColor blueColor];
//    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    myLabel.name = @"Hello";
//    myLabel.text = @"Hello World!";
//    myLabel.fontSize = 45;
//    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame));
//    [self addChild:myLabel];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    SKNode *helloNode = [self childNodeWithName:@"Hello"];
//    if (helloNode) {
//        SKAction *moveUp = [SKAction moveByX:0 y:100 duration:0.5];
//        SKAction *zoom = [SKAction scaleTo:2 duration:0.25];
//        SKAction *pause = [SKAction waitForDuration:0.5];
//        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
//        SKAction *remove = [SKAction removeFromParent];
//        SKAction *moveSequence = [SKAction sequence:@[moveUp,zoom,pause,fadeAway,remove]];
//        [helloNode runAction:moveSequence];
//    }
//}

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor blueColor];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.name = @"Hello";
    myLabel.text = @"Hello World!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SKNode *helloNode = [self childNodeWithName:@"Hello"];
    if (helloNode) {
        SKAction *moveUp = [SKAction moveByX:0 y:100 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp,zoom,pause,fadeAway,remove]];
        [helloNode runAction:moveSequence completion:^{
            SpaceshipScene *spaceScene = [SpaceshipScene sceneWithSize:self.size];
            SKTransition *doors = [SKTransition doorsCloseVerticalWithDuration:0.5];
            [self.view presentScene:spaceScene transition:doors];
        }];
    }

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
