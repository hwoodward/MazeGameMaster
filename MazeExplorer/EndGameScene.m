//
//  EndGameScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/28/14.
//
//

#import "EndGameScene.h"

@implementation EndGameScene


-(id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor whiteColor];
        
        SKLabelNode* label = [[SKLabelNode alloc] init];
        label.text = @"Good Job! Maze Completed.";
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(size.width/2, size.height * (2.0/3));
        [self addChild:label];
    }
    return self;
}

-(void)displayScore
{
    int score = [_delegate getScore];
    
    SKLabelNode* scoreLabel = [[SKLabelNode alloc] init];
    scoreLabel.text = [NSString stringWithFormat: @"Score: %d", score];
    scoreLabel.fontSize = 30;
    scoreLabel.fontColor = [SKColor blackColor];
    scoreLabel.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:scoreLabel];
    
    [self runAction: [SKAction waitForDuration:3.0] completion:^{
        [_delegate endGameSceneDidFinish];
    }];
}

@end
