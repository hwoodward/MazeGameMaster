//
//  TraceScene.m
//  MazeExplorer
//
//  Created by CS121 on 4/17/14.
//
//

#import "TraceScene.h"

@implementation TraceScene

static const uint32_t targetCategory     =  0x1 << 0;
static const uint32_t lineCategory    =  0x1 << 1;
static const uint32_t movableCategory    =  0x1 << 2;
static const uint32_t borderCategory    =  0x1 << 3;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = (id) self;
    
    self.backgroundColor = [SKColor colorWithRed:0.0 green:.7 blue:0.05 alpha:1.0];
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Drag the blue circle along the path to the end to dismiss.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
    label.fontColor = [SKColor blackColor];
    [self addChild:label];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = borderCategory;
    self.physicsBody.contactTestBitMask = 0;
    
    //make path
    [self makePath];
    
    //make target (At last point in path)
    CGPoint location =CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMinY(self.frame)+100);
    [self addTargetBox:location];
    
    //add movable item (at first point in path)
    location = CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMaxY(self.frame)-150);
    [self addMovable: location];
    
    return self;
}

- (void) makePath {
    CGPathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,0,0);
    CGPoint points[] = {CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMaxY(self.frame)-150),
                        CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMaxY(self.frame)-150),
                        CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMaxY(self.frame)-250),
                        CGPointMake(CGRectGetMidX(self.frame)+75, CGRectGetMaxY(self.frame)-150),
                        CGPointMake(CGRectGetMaxX(self.frame)-75, CGRectGetMaxY(self.frame)-150),
                        CGPointMake(CGRectGetMaxX(self.frame)-75, CGRectGetMidY(self.frame)+75),
                        CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMidY(self.frame)+75),
                        CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMidY(self.frame)-100),
                        CGPointMake(CGRectGetMinX(self.frame)+200, CGRectGetMidY(self.frame)+25),
                        CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame)-100),
                        CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMidY(self.frame)+25),
                        CGPointMake(CGRectGetMaxX(self.frame)-150, CGRectGetMidY(self.frame)-100),
                        CGPointMake(CGRectGetMaxX(self.frame)-75, CGRectGetMidY(self.frame)-25),
                        CGPointMake(CGRectGetMaxX(self.frame)-75, CGRectGetMinY(self.frame)+100),
                        CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMinY(self.frame)+100),
                        CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMinY(self.frame)+225),
                        CGPointMake(CGRectGetMidX(self.frame)-75, CGRectGetMinY(self.frame)+100),
                        CGPointMake(CGRectGetMinX(self.frame)+75, CGRectGetMinY(self.frame)+100)};
    CGPathAddLines(path, NULL, points, 18);
    
    SKShapeNode *line = [[SKShapeNode alloc] init];
    line.path = path;
    line.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path];
    line.physicsBody.categoryBitMask = lineCategory;
    line.physicsBody.contactTestBitMask = movableCategory;
    line.physicsBody.collisionBitMask = 0;
    [self addChild:line];
    
}

-(void) addMovable: (CGPoint) location {
    
    SKSpriteNode *movable = [[SKSpriteNode alloc]initWithImageNamed:@"bluecircle.png"];
    movable.position = location;
    movable.name = @"Movable";
    movable.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:25];
    movable.physicsBody.dynamic = YES;
    movable.physicsBody.categoryBitMask = movableCategory;
    movable.physicsBody.contactTestBitMask = targetCategory | lineCategory;
    movable.physicsBody.collisionBitMask = movableCategory | borderCategory;
    movable.physicsBody.usesPreciseCollisionDetection = YES;
    movable.physicsBody.allowsRotation = NO;
    [self addChild:movable];
}

- (void) addTargetBox:(CGPoint) location {
    SKSpriteNode *blueBox = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(75,75)];
    blueBox.position = location;
    blueBox.name = @"blueBox";
    blueBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:blueBox.size];
    blueBox.physicsBody.dynamic = YES;
    blueBox.physicsBody.categoryBitMask = targetCategory;
    blueBox.physicsBody.contactTestBitMask = movableCategory;
    blueBox.physicsBody.collisionBitMask = 0;
    [self addChild:blueBox];
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
        
		if([touchedNode.name isEqualToString:@"Movable"]) {
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
    if ((firstBody.categoryBitMask & lineCategory) != 0 &&
         (secondBody.categoryBitMask & movableCategory) != 0) {
        _onPath++;
    }
    if ((firstBody.categoryBitMask & targetCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        [_delegate obstacleDidFinish];
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
    
    if ((firstBody.categoryBitMask & lineCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        _onPath--;
        [self performSelector:@selector(notOnPath) withObject:self afterDelay:0.2];
    }
}

- (void)notOnPath {
    if(_onPath == 0) {
        [_delegate obstacleDidFail];
    }
}


@end
