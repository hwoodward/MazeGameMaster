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
    
    //Need to make an object node that so I can see it
    SKSpriteNode *clickHere = [SKSpriteNode spriteNodeWithImageNamed:@"checkButton.png"];
    clickHere.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-200);
    clickHere.name = @"exitNode";
    clickHere.zPosition = 1.0;
    
    [self addChild:clickHere];
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
 
//    NSLog(@"%@", NSStringFromCGPoint(location));
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"exitNode"]) {
        [_delegate obstacleDidFinish];
    }

}

@end
