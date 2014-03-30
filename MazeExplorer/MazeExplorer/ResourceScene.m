//
//  ResourceScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/1/14.
//
//

#import "ResourceScene.h"

@implementation ResourceScene


-(id) initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    self.resourceCounter = 0;
    
    self.backgroundColor = [SKColor purpleColor];
    
    _label = [[SKLabelNode alloc] init];
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", 0];
    _label.fontSize = 42;
    _label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_label];
    
    _instr1 = [[SKLabelNode alloc] init];
    _instr1.text = @"The orange boxes are resources. Collect them!";
    _instr1.fontSize = 30;
    _instr1.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+75);
    
    [self addChild:_instr1];
    
    _instr2 = [[SKLabelNode alloc] init];
    _instr2.text = @"The green button uses your resources.";
    _instr2.fontSize = 30;
    _instr2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-75);
    
    [self addChild:_instr2];
    
    
    // Adding a button that uses a resource.
    SKSpriteNode *useButton = [[SKSpriteNode alloc] initWithImageNamed:@"resbutton.png"];
    useButton.position = CGPointMake(CGRectGetMidX(self.frame)+300,CGRectGetMidY(self.frame));
    useButton.name = @"useButton";
    [self addChild:useButton];
    
    
    return self;
}

-(void) increaseCounterByOne
{
    ++self.resourceCounter;
    NSLog(@"The resource counter is now: %i", self.resourceCounter);
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", self.resourceCounter];
}

-(void) decreaseCounterByOne
{
    --self.resourceCounter;
    NSLog(@"The resource counter is now: %i", self.resourceCounter);
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", self.resourceCounter];
}

-(void) useResource
{
    [self.delegate useResource];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"useButton"]) {
        if (self.resourceCounter > 0){
            [self useResource]; 
            NSLog(@"You tried to use a resource!");
        }
        else {
            NSLog(@"You can't use a resource, you mad fool! There aren't any left!");
        }
    }
    
    
}

-(void)useResourceConfirmed
{
    [self decreaseCounterByOne];
    NSLog(@"You successfully used a resource!"); 
}

@end
