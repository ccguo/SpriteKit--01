//
//  SpaceshipScene.m
//  SpriteKit学习-01
//
//  Created by guochaoyang on 15/11/18.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "SpaceshipScene.h"
#import "UIColor+Random.h"

static inline CGFloat skRandf(){
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high){
    return skRandf() * (high - low) + low;
}

@interface SpaceshipScene ()
@property (nonatomic)BOOL contentCreated;
@end
@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor grayColor];
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8, 8)];
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]
                                           ]];
    SKAction *blinkForver = [SKAction repeatActionForever:blink];
    [light runAction:blinkForver];
    return light;
}


- (SKSpriteNode *)newSpaceship
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(33, 24)];
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100 y:-50 duration:1]
                                           ]];
    [hull runAction:[SKAction repeatActionForever:hover]];
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28, 6);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28, 6);
    [hull addChild:light2];
    
    return hull;
}

- (void)createSceneContents
{
    self.backgroundColor = [UIColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence:@[
                                               [SKAction performSelector:@selector(addRock) onTarget:self],
                                               [SKAction waitForDuration:0.8 withRange:0.15]
                                               ]];
    [self runAction:[SKAction repeatActionForever:makeRocks]];
}

- (void)addRock
{
    CGFloat reactAngle = skRand(30,70);

    
//    SKPhysicsWorld *physicsWorld = [[SKPhysicsWorld alloc] init];
//    physicsWorld.gravity = CGVectorMake(0, 3.0);
//    physicsWorld.speed = 5;
//    SKPhysicsBody *physicsBody = [physicsWorld bodyInRect:self.frame];
    
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[UIColor randomColor] size:CGSizeMake(reactAngle,reactAngle)];
    rock.position = CGPointMake(skRand(rock.size.width/2,self.size.width-rock.size.width/2), self.size.height);
    rock.name = @"rock";
//    rock.physicsBody = physicsBody;
//    rock.physicsBody.usesPreciseCollisionDetection = YES;

    [self addChild:rock];
    
    
    SKAction *speed = [SKAction speedBy:15 duration:20];
    speed.speed = 10;
    
    SKAction *sequence = [SKAction sequence:@[speed,
                                              [SKAction moveTo:CGPointMake(0, 0) duration:15]
                                              ]];
    [rock runAction:sequence];

}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
}


@end
