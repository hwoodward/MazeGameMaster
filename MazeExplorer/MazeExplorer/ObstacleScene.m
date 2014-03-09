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
    label.text = @"Drag the checkmark to dismiss.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    label.fontColor = [SKColor blackColor];
    
    [self addChild:label];
    
    SKSpriteNode *checkMark = [SKSpriteNode spriteNodeWithImageNamed:@"checkButton.png"];
    checkMark.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+200);
    checkMark.name = @"checkMark";
    
    /*SKSpriteNode *blueBox = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:checkMark.size];
    blueBox.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-200);
    blueBox.name = @"blueBox";
    [self addChild:blueBox];
*/
     [self addChild:checkMark];

    return self;
}

//Gesture recognizer code?
- (void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        //Need to set a property so that in later parts can move the node!
        SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];

		if([[touchedNode name] isEqualToString:@"checkMark"]) {
            _selectedNode = touchedNode;
        }
        else {
            _selectedNode = nil;
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self moveSelectedNode:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if(_selectedNode != nil) {
                [_delegate obstacleDidFinish];
        }
    }
}

- (void)moveSelectedNode:(CGPoint)translation {
    if(_selectedNode != nil) {
        CGPoint position = [_selectedNode position];
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

/*
  Removed so taht gesture recognizer could be added.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
 
//    NSLog(@"%@", NSStringFromCGPoint(location));
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"checkMark"]) {
        [_delegate obstacleDidFinish];
    }
}
 */

@end
