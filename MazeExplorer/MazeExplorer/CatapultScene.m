//
//  CatapultScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/28/14.
//
//

#import "CatapultScene.h"

static const uint32_t playerCategory     =  0x1 << 0;
static const uint32_t borderCategory     =  0x1 << 1;
static const uint32_t rightCliffCategory =  0x1 << 2;
static const uint32_t leftCliffCategory  =  0x1 << 3;

@interface CatapultScene ()

@property (nonatomic) SKSpriteNode* player;
@property BOOL didStartLaunchSequence;
@property (nonatomic) SKShapeNode* launchIndicator;

@end

@implementation CatapultScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor blackColor];
        _launchIndicator = [[SKShapeNode alloc] init];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = borderCategory;
        self.physicsBody.contactTestBitMask = playerCategory;
        
        [self initCliffSides];
        [self initPlayer];
        
        SKLabelNode *label1 = [[SKLabelNode alloc] init];
        label1.text = @"Drag from the blue circle and release to launch yourself across.";
        label1.fontSize = 27;
        label1.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-50);
        label1.fontColor = [SKColor whiteColor];
        [self addChild:label1];
        SKLabelNode *label2 = [[SKLabelNode alloc] init];
        label2.text = @"(Don't overshoot or fall short)";
        label2.fontSize = 27;
        label2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
        label2.fontColor = [SKColor whiteColor];
        [self addChild:label2];
    }
    return self;
}


- (void) initCliffSides
{
    
    SKTexture* masonry = [SKTexture textureWithImageNamed:@"bricktexture.jpg"];
    SKSpriteNode* leftCliff = [[SKSpriteNode alloc]
                               initWithTexture:masonry
                               color:[SKColor grayColor]
                               size:CGSizeMake(CGRectGetWidth(self.frame)*.35, CGRectGetMidY(self.frame)/2)];
    leftCliff.position = CGPointMake(0+ leftCliff.size.width/2,0+ leftCliff.size.height/2);
    leftCliff.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftCliff.size];
    leftCliff.physicsBody.categoryBitMask = leftCliffCategory;
    leftCliff.physicsBody.dynamic = YES;
    leftCliff.physicsBody.affectedByGravity = NO;
    [self addChild:leftCliff];
    
    
    SKSpriteNode* rightCliffTop = [[SKSpriteNode alloc]
                                   initWithColor:[SKColor grayColor]
                                   size:CGSizeMake(CGRectGetWidth(self.frame)*.35, 20)];
    rightCliffTop.position = CGPointMake(CGRectGetWidth(self.frame)- rightCliffTop.size.width/2,
                                         CGRectGetMidY(self.frame)/2 - rightCliffTop.size.height/2);
    rightCliffTop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightCliffTop.size];
    rightCliffTop.physicsBody.categoryBitMask = rightCliffCategory;
    rightCliffTop.physicsBody.contactTestBitMask = playerCategory;
    rightCliffTop.physicsBody.dynamic = YES;
    rightCliffTop.physicsBody.affectedByGravity = NO;
    [self addChild:rightCliffTop];
    
    SKSpriteNode* rightCliff = [[SKSpriteNode alloc]
                                initWithTexture:masonry
                                color:[SKColor grayColor]
                                size:CGSizeMake(CGRectGetWidth(self.frame)*.35, CGRectGetMidY(self.frame)/2)];
    rightCliff.position = CGPointMake(CGRectGetWidth(self.frame)- rightCliff.size.width/2,
                                    rightCliff.size.height/2);
    rightCliff.physicsBody = [SKPhysicsBody
                              bodyWithRectangleOfSize:CGSizeMake(rightCliff.size.width,
                                                                  rightCliff.size.height - 20)];
    rightCliff.physicsBody.categoryBitMask = leftCliffCategory;
    rightCliff.physicsBody.contactTestBitMask = playerCategory;
    rightCliff.physicsBody.dynamic = YES;
    rightCliff.physicsBody.affectedByGravity = NO;
    
    [self addChild:rightCliff];
}

- (void) initPlayer
{
    //Player image source: http://findicons.com/icon/69390/circle_blue
    
    _player = [[SKSpriteNode alloc] initWithImageNamed:@"bluecircle.png"];
    _player.position = CGPointMake(CGRectGetWidth(self.frame)*(.35/2),
                                   CGRectGetMidY(self.frame)/2+(_player.size.height/2));
    
    _player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_player.size];
    _player.physicsBody.categoryBitMask = playerCategory;
    _player.physicsBody.contactTestBitMask = borderCategory|rightCliffCategory|leftCliffCategory;
    _player.physicsBody.dynamic = YES;
    _player.physicsBody.affectedByGravity = YES;
    
    [self addChild:_player];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInNode:self.scene];
    _didStartLaunchSequence = NO;
    
    // I know this loop is weird. Here's what's going on:
    // It's checking a box outline that is 41 points on a side around the touch.
    // This means that it's easier to actually "touch" the player, rather than hoping
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
        if (node1 == _player || node2 == _player) {
            _didStartLaunchSequence = YES;
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInNode:self.scene];
    [_launchIndicator removeFromParent];

    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:_player.position];
    [path addLineToPoint:touchLoc];
    
    
    _launchIndicator.path = [path CGPath];
    [self addChild:_launchIndicator];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_launchIndicator removeFromParent];
    
    UITouch* touch = [touches anyObject];
    CGPoint touchLoc = [touch locationInNode:self.scene];
    
    CGVector vector = CGVectorMake((_player.position.x - touchLoc.x)* 5,
                                 (_player.position.y - touchLoc.y)*5);
    _player.physicsBody.velocity = vector ;
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
    
    if (firstBody.categoryBitMask == playerCategory &&
        secondBody.categoryBitMask == rightCliffCategory) {
        [_delegate obstacleDidFinish];
    } else if(firstBody.categoryBitMask == playerCategory &&
              secondBody.categoryBitMask == borderCategory) {
        [_delegate obstacleDidFail];
    }
    
}

@end
