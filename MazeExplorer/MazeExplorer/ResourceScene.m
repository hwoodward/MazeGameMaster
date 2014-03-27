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
            [self decreaseCounterByOne];
            [self useResource]; 
            NSLog(@"You used a resource!");
        }
        else {
            NSLog(@"You can't use a resource, you mad fool! There aren't any left!");
        }
    }
    
    
}

@end
