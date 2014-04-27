//
//  AvalancheScene.m
//  MazeExplorer
//
//  Created by CS121 on 4/12/14.
//
//

#import "AvalancheScene.h"

@interface AvalancheScene ()

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property int inTarget;

- (void) moveSelectedNode:(CGPoint)translation;
- (void) addTargetBox:(CGPoint) location;
- (void) notCrossingLines;

@end

@implementation AvalancheScene

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
    
    self.backgroundColor = [SKColor colorWithRed:0.0 green:.7 blue:0.05 alpha:1.0];
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Drag the boulders to off the blue box to clear a path.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
    label.fontColor = [SKColor blackColor];
    [self addChild:label];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = borderCategory;
    self.physicsBody.contactTestBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    
    //Add quit button
    SKSpriteNode *quit = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(100, 50)];
    quit.position = CGPointMake(CGRectGetMinX(self.frame)+75,CGRectGetMinY(self.frame)+30);
    quit.name = @"quit";
    [self addChild:quit];
    
    SKLabelNode *quitLabel = [[SKLabelNode alloc] init];
    quitLabel.position = CGPointMake(CGRectGetMinX(self.frame)+75,CGRectGetMinY(self.frame)+20);
    quitLabel.name = @"quit";
    quitLabel.text = @"Quit";
    quitLabel.fontColor = [SKColor blackColor];
    quitLabel.fontSize = 27;
    [self addChild:quitLabel];
    
    //add pit
    CGPoint location =CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMidY(self.frame)-125);
    [self addTargetBox:location];
    
    //add boulders
    location = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMinY(self.frame) + 75);
    [self addSmallBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMinY(self.frame) + 150);
    [self addSmallBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) + 100, CGRectGetMinY(self.frame) + 225);
    [self addSmallBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMinY(self.frame) + 150);
    [self addBigBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) + 200, CGRectGetMinY(self.frame) + 375);
    [self addlongBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMinY(self.frame) + 375);
    [self addlongBoulder: location];
    location = CGPointMake(CGRectGetMidX(self.frame) + 250, CGRectGetMinY(self.frame) + 150);
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
    SKSpriteNode *blueBox = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(self.frame.size.width-202, self.frame.size.height-277)];
    blueBox.position = location;
    blueBox.name = @"blueBox";
    blueBox.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:blueBox.size];
    blueBox.physicsBody.dynamic = YES;
    blueBox.physicsBody.categoryBitMask = targetCategory;
    blueBox.physicsBody.contactTestBitMask = movableCategory;
    blueBox.physicsBody.collisionBitMask = 0;
    [self addChild:blueBox];
    
    SKSpriteNode *boxOutline = [[SKSpriteNode alloc] init];
    CGRect rect = CGRectMake(blueBox.position.x-blueBox.size.width/2, blueBox.position.y-blueBox.size.height/2, blueBox.size.width, blueBox.size.height);
    boxOutline.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:rect];
    boxOutline.physicsBody.categoryBitMask = outlineCategory;
    boxOutline.physicsBody.contactTestBitMask = movableCategory;
    boxOutline.physicsBody.collisionBitMask = 0;
    [self addChild:boxOutline];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *clickedNode = [self nodeAtPoint:location];
    if(clickedNode.name == @"quit") {
        [_delegate obstacleDidFail];
    }
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
        //NSLog([NSString stringWithFormat:@"%i",_inTarget]);
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
        //NSLog([NSString stringWithFormat:@"%i",_inTarget]);
    }
    if ((firstBody.categoryBitMask & outlineCategory) != 0 &&
        (secondBody.categoryBitMask & movableCategory) != 0) {
        [self performSelector:@selector(notCrossingLines) withObject:self afterDelay:1.0];
        //NSLog(@"Not crossing lines");
    }
}


- (void)notCrossingLines {
    if(_inTarget == 0) { //inTarget needs to equal the total number of boulders.
        [_delegate obstacleDidFinish];
    }
}

@end
