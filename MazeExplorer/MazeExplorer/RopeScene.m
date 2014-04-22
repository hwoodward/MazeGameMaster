//
//  RopeObstacle.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/21/14.
//
//

#import "RopeScene.h"

static const uint32_t ropeCategory     =  0x1 << 0;
static const uint32_t pivotCategory    =  0x1 << 1;
static const uint32_t barCategory      =  0x1 << 2;
static const uint32_t playerCategory   =  0x1 << 3;

@interface RopeScene ()

@property (nonatomic) SKSpriteNode* rope;
@property (nonatomic) SKSpriteNode* player;
@property (nonatomic) SKSpriteNode* speedButton;
@property CGFloat rotation;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property BOOL onRope;

@end

@implementation RopeScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        _onRope = NO;
        self.backgroundColor = [SKColor blackColor];
        [self initRopeAndPivot];
        [self initCliffSides];
        [self initPlayer];
        [self initSpeedButton];
        
        SKLabelNode *label = [[SKLabelNode alloc] init];
        label.text = @"Jump onto and off the rope to swing across.";
        label.fontSize = 27;
        label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
        label.fontColor = [SKColor whiteColor];
        [self addChild:label];
    }
    return self;
}

- (void) initRopeAndPivot
{
    SKSpriteNode* pivot = [[SKSpriteNode alloc]
                           initWithColor:[UIColor blackColor]
                           size:CGSizeMake(CGRectGetWidth(self.frame), 50)];
    
    pivot.position = CGPointMake(CGRectGetMidX(self.frame),
                                 (1.5)*CGRectGetMidY(self.frame));
    pivot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pivot.size];
    pivot.physicsBody.dynamic = NO;
    pivot.physicsBody.categoryBitMask = pivotCategory;
    pivot.physicsBody.allowsRotation = YES;
    pivot.physicsBody.affectedByGravity = YES;
    
    [self addChild:pivot];
    
    _rope = [[SKSpriteNode alloc]
             initWithColor:[UIColor brownColor]
             size:CGSizeMake(10, 400)];
    _rope.anchorPoint = CGPointMake(0.5, 0);
    
    _rope.position = CGPointMake(CGRectGetMidX(self.frame),
                                 (1.5)*CGRectGetMidY(self.frame)- _rope.size.height);
    _rope.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_rope.size];
    _rope.physicsBody.dynamic = YES;
    _rope.physicsBody.categoryBitMask = ropeCategory;
    _rope.physicsBody.allowsRotation = YES;
    _rope.physicsBody.affectedByGravity = YES;
    
    
    [self addChild:_rope];
    
    SKPhysicsJointPin* pin = [SKPhysicsJointPin
                              jointWithBodyA:pivot.physicsBody
                              bodyB:_rope.physicsBody
                              anchor:CGPointMake(CGRectGetMidX(self.frame),
                                                 (1.5)*CGRectGetMidY(self.frame))];
    pin.frictionTorque = 0.0;
    [self.physicsWorld addJoint:pin];
    
    SKAction *rotation = [SKAction rotateByAngle: M_PI/2.0 duration:0];
    [_rope runAction:rotation];
    
    
    
    SKSpriteNode* leftBar = [[SKSpriteNode alloc]
                             initWithColor:[UIColor blackColor]
                             size:CGSizeMake(50, 50)];
    leftBar.position = CGPointMake(0,
                                   (1.5)*CGRectGetMidY(self.frame) - leftBar.size.height);
    leftBar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftBar.size];
    leftBar.physicsBody.dynamic = NO;
    leftBar.physicsBody.categoryBitMask = barCategory;
    leftBar.physicsBody.allowsRotation = NO;
    leftBar.physicsBody.affectedByGravity = NO;
    
    [self addChild:leftBar];
    
    SKSpriteNode* rightBar = [[SKSpriteNode alloc]
                              initWithColor:[UIColor blackColor]
                              size:CGSizeMake(50, 50)];
    rightBar.position = CGPointMake(CGRectGetWidth(self.frame),
                                    (1.5)*CGRectGetMidY(self.frame) - rightBar.size.height);
    rightBar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightBar.size];
    rightBar.physicsBody.dynamic = NO;
    rightBar.physicsBody.categoryBitMask = barCategory;
    rightBar.physicsBody.allowsRotation = NO;
    rightBar.physicsBody.affectedByGravity = NO;
    
    [self addChild:rightBar];
}

- (void) initCliffSides
{
    
    SKTexture* masonry = [SKTexture textureWithImageNamed:@"bricktexture.jpg"];
    SKSpriteNode* leftCliff = [[SKSpriteNode alloc]
                               initWithTexture:masonry
                               color:[SKColor grayColor]
                               size:CGSizeMake(CGRectGetWidth(self.frame)*.35, CGRectGetMidY(self.frame)/2)];
    leftCliff.anchorPoint = CGPointMake(0,0);
    leftCliff.position = CGPointMake(0,0);
    [self addChild:leftCliff];
    
    SKSpriteNode* rightCliff = [[SKSpriteNode alloc]
                                initWithTexture:masonry
                                color:[SKColor grayColor]
                                size:CGSizeMake(CGRectGetWidth(self.frame)*.35, CGRectGetMidY(self.frame)/2)];
    rightCliff.anchorPoint = CGPointMake(1,0);
    rightCliff.position = CGPointMake(CGRectGetWidth(self.frame),0);
    [self addChild:rightCliff];
}

- (void) initPlayer
{
    //Player image source: http://findicons.com/icon/69390/circle_blue
    
    _player = [[SKSpriteNode alloc] initWithImageNamed:@"bluecircle.png"];
    _player.position = CGPointMake(CGRectGetWidth(self.frame)*(.35/2),
                                   CGRectGetMidY(self.frame)/2+(_player.size.height/2));
    [self addChild:_player];
}

- (void) initSpeedButton
{
    _speedButton = [[SKSpriteNode alloc]
                    initWithColor:[SKColor blueColor]
                    size:CGSizeMake(160, 70)];
    _speedButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                        (1.57)*CGRectGetMidY(self.frame));
    [self addChild:_speedButton];
    
    SKLabelNode* speedLabel = [[SKLabelNode alloc] init];
    speedLabel.text = @"Rope Speed Button";
    speedLabel.fontSize = 27;
    speedLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                      _speedButton.position.y + _speedButton.size.height/2);
    speedLabel.fontColor = [SKColor whiteColor];
    [self addChild:speedLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInNode:self.scene];
    
    if (_speedButton == [self.scene nodeAtPoint:touchLoc]){
        NSLog(@"reset");
        _rope.physicsBody.angularVelocity *= 5;
    } else {
        BOOL didTouchRope = NO;
        
        // I know this loop is weird. Here's what's going on:
        // It's checking a box outline that is 41 points on a side around the touch.
        // This means that it's easier to actually "touch" the rope, rather than hoping
        // to some deity that you actually manage to mash the right pixel with your sausage
        // fingers.
        int boxRange = 20; // This is just my guess for the range we should check.
        for (int i = touchLoc.x - boxRange; i <= touchLoc.x + boxRange; i++) {
            SKSpriteNode* node1;
            SKSpriteNode* node2;
            if (i == touchLoc.x - boxRange || i == touchLoc.x + boxRange) {
                for (int j = touchLoc.y - boxRange; j <= touchLoc.y + boxRange; j++) {
                    node1 = (SKSpriteNode*)[self.scene nodeAtPoint: CGPointMake(i, j)];
                }
            } else {
                node1 = (SKSpriteNode*)[self.scene nodeAtPoint: CGPointMake(i, touchLoc.y - boxRange)];
                node2 = (SKSpriteNode*)[self.scene nodeAtPoint: CGPointMake(i, touchLoc.y + boxRange)];
            }
            if (node1 == _rope || node2 == _rope) {
                didTouchRope = YES;
                break;
            }
        }
        if (didTouchRope) {
            NSLog(@"did touch rope");
            if (_rope.physicsBody.angularVelocity <= .4 && _rope.physicsBody.angularVelocity >= -.4) {
                NSLog(@"at edge");
                if (_onRope) {
                    if (touchLoc.x >= CGRectGetWidth(self.frame)*.65){
                        [self finish];
                    }
                } else {
                    if (touchLoc.x <= CGRectGetWidth(self.frame)*.35){
                        _onRope = YES;
                        _player.position = _rope.position;
                        NSLog(@"On rope");
                    }
                }
            }
        }
    }
}

- (void) finish
{
    _onRope = NO;
    SKAction* jump = [SKAction moveTo:CGPointMake(CGRectGetWidth(self.frame)*(.65 + .35/2),
                                                   CGRectGetMidY(self.frame)/2+(_player.size.height/2))
                             duration:.5];
    
    [_player runAction:jump  completion:^{
        [_delegate obstacleDidFinish];
    }];
}

-(void)update:(CFTimeInterval)currentTime {
    if (_onRope) {
        _player.position = _rope.position;
    }
}



- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == pivotCategory &&
               secondBody.categoryBitMask == barCategory) {
        firstBody.velocity = CGVectorMake(0, 0);
    }
    
}

@end
