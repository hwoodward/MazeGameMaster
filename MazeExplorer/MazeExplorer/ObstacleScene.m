//
//  ObstacleScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/2/14.
//
//

#import "ObstacleScene.h"

@implementation ObstacleScene

static const uint32_t targetCategory     =  0x1 << 0;
static const uint32_t outlineCategory    =  0x1 << 1;
static const uint32_t movableCategory    =  0x1 << 2;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = (id) self;

    self.backgroundColor = [SKColor greenColor];
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Drag the red box into the blue box to dismiss.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    label.fontColor = [SKColor blackColor];
    
    [self addChild:label];
    SKSpriteNode *checkMark = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(100, 100)];
    checkMark.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+200);
    checkMark.name = @"checkMark";
    checkMark.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:checkMark.size];
    checkMark.physicsBody.dynamic = YES;
    checkMark.physicsBody.categoryBitMask = movableCategory;
    checkMark.physicsBody.contactTestBitMask = targetCategory | outlineCategory;
    checkMark.physicsBody.collisionBitMask = 0;
    checkMark.physicsBody.usesPreciseCollisionDetection = YES;
    CGPoint targetLoc =CGPointMake(self.frame.size.width/2, self.frame.size.height/2-200);
    _checkNode = checkMark;
    
    [self addTargetBox:targetLoc];

    [self addChild:checkMark];
    return self;
}

- (void) addTargetBox:(CGPoint) location {
    SKSpriteNode *blueBox = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(200, 200)];
    blueBox.position = location;
    blueBox.name = @"blueBox";
    blueBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:blueBox.size];
    blueBox.physicsBody.dynamic = YES;
    blueBox.physicsBody.categoryBitMask = targetCategory;
    blueBox.physicsBody.contactTestBitMask = movableCategory;
    blueBox.physicsBody.collisionBitMask = 0;
    [self addChild:blueBox];
   
    SKNode *boxOutline = [[SKNode alloc] init];
    CGRect rect = CGRectMake(blueBox.position.x-100, blueBox.position.y-100, blueBox.size.width, blueBox.size.height);
    boxOutline.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:rect];
    boxOutline.physicsBody.categoryBitMask = outlineCategory;
    boxOutline.physicsBody.contactTestBitMask = movableCategory;
    boxOutline.physicsBody.collisionBitMask = 0;
    [self addChild:boxOutline];
}

//Gesture recognizer code
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

		if(touchedNode == _checkNode) {
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
//        if(_selectedNode != nil) {
//                [_delegate obstacleDidFinish];
//        }
    }
}

- (void)moveSelectedNode:(CGPoint)translation {
    if(_selectedNode != nil) {
        CGPoint position = [_selectedNode position];
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if ((firstBody.categoryBitMask & targetCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        _inTarget = YES;
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact {
  
    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & targetCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        _inTarget = NO;
    }
    if ((firstBody.categoryBitMask & outlineCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        [self notCrossingLines];
    }
}


- (void)notCrossingLines {
    if(_inTarget == YES) {
        [_delegate obstacleDidFinish];
    }
}

@end
