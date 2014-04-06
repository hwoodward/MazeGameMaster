//
//  PitFillScene.m
//  MazeExplorer
//
//  Created by Helen Woodward on 4/6/14.
//
//

#import "PitFillScene.h"

@implementation PitFillScene

static const uint32_t targetCategory     =  0x1 << 0;
static const uint32_t outlineCategory    =  0x1 << 1;
static const uint32_t movableCategory    =  0x1 << 2;
static const uint32_t borderCategory    =  0x1 << 3;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = (id) self;
    
    _inTarget = 0;
    
    self.backgroundColor = [SKColor greenColor];
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Drag the boulders into the blue pit to dismiss.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
    label.fontColor = [SKColor blackColor];
    [self addChild:label];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = borderCategory;
    self.physicsBody.contactTestBitMask = 0;
    
    //add pit
    CGPoint location =CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+151);
    [self addTargetBox:location];
 
    //add boulders
    location = CGPointMake(self.frame.size.width/2, CGRectGetMaxY(self.frame)-100);
    [self addSmallBoulder: location];
    location = CGPointMake(self.frame.size.width/2, CGRectGetMaxY(self.frame)-175 );
    [self addSmallBoulder: location];
    location = CGPointMake(self.frame.size.width/2 - 150, CGRectGetMaxY(self.frame)-200);
    [self addBigBoulder: location];
    location = CGPointMake(self.frame.size.width/2 + 250, CGRectGetMaxY(self.frame)-125);
    [self addlongBoulder: location];
    location = CGPointMake(self.frame.size.width/2 + 250, CGRectGetMaxY(self.frame)-250);
    [self addlongBoulder: location];
    location = CGPointMake(self.frame.size.width/2 - 250, CGRectGetMaxY(self.frame)-200);
    [self addtallBoulder: location];

    return self;
}
-(void) addSmallBoulder: (CGPoint) location {
    
    SKSpriteNode *boulder = [[SKSpriteNode alloc]initWithImageNamed:@"bricktexture.jpg"];
    boulder.position = location;
    boulder.name = @"Boulder";
    boulder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boulder.size];
    boulder.physicsBody.dynamic = YES;
    boulder.physicsBody.categoryBitMask = movableCategory;
    boulder.physicsBody.contactTestBitMask = targetCategory | outlineCategory;
    boulder.physicsBody.collisionBitMask = movableCategory | borderCategory;
    boulder.physicsBody.usesPreciseCollisionDetection = YES;
    boulder.physicsBody.allowsRotation = NO;
    [self addChild:boulder];
}
-(void) addBigBoulder: (CGPoint) location {
    
    SKSpriteNode *boulder = [[SKSpriteNode alloc]initWithImageNamed:@"boulder.png"];
    boulder.position = location;
    boulder.name = @"Boulder";
    boulder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boulder.size];
    boulder.physicsBody.dynamic = YES;
    boulder.physicsBody.categoryBitMask = movableCategory;
    boulder.physicsBody.contactTestBitMask = targetCategory | outlineCategory;
    boulder.physicsBody.collisionBitMask = movableCategory | borderCategory;
    boulder.physicsBody.usesPreciseCollisionDetection = YES;
    boulder.physicsBody.allowsRotation = NO;
    [self addChild:boulder];
}

-(void) addlongBoulder: (CGPoint) location {
    
    SKSpriteNode *boulder = [[SKSpriteNode alloc]initWithImageNamed:@"longBoulder.png"];
    boulder.position = location;
    boulder.name = @"Boulder";
    boulder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boulder.size];
    boulder.physicsBody.dynamic = YES;
    boulder.physicsBody.categoryBitMask = movableCategory;
    boulder.physicsBody.contactTestBitMask = targetCategory | outlineCategory;
    boulder.physicsBody.collisionBitMask = movableCategory | borderCategory;
    boulder.physicsBody.usesPreciseCollisionDetection = YES;
    boulder.physicsBody.allowsRotation = NO;
    [self addChild:boulder];
}

-(void) addtallBoulder: (CGPoint) location {
    
    SKSpriteNode *boulder = [[SKSpriteNode alloc]initWithImageNamed:@"tallBoulder.png"];
    boulder.position = location;
    boulder.name = @"Boulder";
    boulder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boulder.size];
    boulder.physicsBody.dynamic = YES;
    boulder.physicsBody.categoryBitMask = movableCategory;
    boulder.physicsBody.contactTestBitMask = targetCategory | outlineCategory;
    boulder.physicsBody.collisionBitMask = movableCategory | borderCategory;
    boulder.physicsBody.usesPreciseCollisionDetection = YES;
    boulder.physicsBody.allowsRotation = NO;
    [self addChild:boulder];
}

- (void) addTargetBox:(CGPoint) location {
    SKSpriteNode *blueBox = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(self.frame.size.width-2, 300)];
    blueBox.position = location;
    blueBox.name = @"blueBox";
    blueBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:blueBox.size];
    blueBox.physicsBody.dynamic = YES;
    blueBox.physicsBody.categoryBitMask = targetCategory;
    blueBox.physicsBody.contactTestBitMask = movableCategory;
    blueBox.physicsBody.collisionBitMask = 0;
    [self addChild:blueBox];
    
    SKSpriteNode *boxOutline = [[SKSpriteNode alloc] init];
    CGRect rect = CGRectMake(blueBox.position.x-self.frame.size.width/2, blueBox.position.y-150, blueBox.size.width, blueBox.size.height);
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
        
		if([touchedNode.name isEqualToString:@"Boulder"]) {
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
    if ((firstBody.categoryBitMask & targetCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        _inTarget++;
     //   NSLog(@"Overlapping pit");
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
        _inTarget--;
   //     NSLog(@"Not overlapping pit");
    }
    if ((firstBody.categoryBitMask & outlineCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        [self performSelector:@selector(notCrossingLines) withObject:self afterDelay:1.0];
    //    NSLog(@"Not crossing lines");
    }
}


- (void)notCrossingLines {
    if(_inTarget == 6) { //inTarget needs to equal the total number of boulders.
        [_delegate obstacleDidFinish];
    }
}

@end
