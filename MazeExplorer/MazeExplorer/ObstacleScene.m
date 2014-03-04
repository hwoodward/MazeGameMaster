//
//  ObstacleScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/2/14.
//
//

#import "ObstacleScene.h"

@implementation ObstacleScene

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    self.backgroundColor = [SKColor greenColor];
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"This is an obstacle. Touch to dismiss";
    label.fontSize = 42;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    label.fontColor = [SKColor blackColor];
    
    [self addChild:label];
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate obstacleDidFinish];
}


@end
