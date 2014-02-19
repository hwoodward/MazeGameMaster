//
//  MyScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"
#import "Maze.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    
    Maze* maze = [[Maze alloc] init];
    [maze printMaze];
    if ([maze isWallCellWithRow:2 andColumn:1]) {
        NSLog(@"Yay, I haven't got this totally backwards");
    } else {
        NSLog(@"Well, shit");
    }
    if (![maze isWallCellWithRow:0 andColumn:1]) {
        NSLog(@"Yay, I haven't got this totally backwards");
    } else {
        NSLog(@"Well, shit");
    }
    
    Maze* stringMaze = [[Maze alloc] initMazeWithString:@"*****  **  **  *****" andWidth:4];
    [stringMaze printMaze];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
