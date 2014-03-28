//
//  ResourceConfirm.m
//  MazeExplorer
//
//  Created by CS121 on 3/27/14.
//
//

#import "ResourceConfirm.h"

@implementation ResourceConfirm

-(id) initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    self.backgroundColor = [SKColor blueColor];
    
    _label = [[SKLabelNode alloc] init];
    _label.text = @"Are you sure you want to use this resource?";
    _label.fontSize = 35;
    _label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_label];
    
    // Adding a button that confirms that you want to use a resource.
    SKSpriteNode *yesButton = [[SKSpriteNode alloc] initWithImageNamed:@"yesbutton.png"];
    yesButton.position = CGPointMake(CGRectGetMidX(self.frame)-200,CGRectGetMidY(self.frame)-200);
    yesButton.name = @"yesButton";
    [self addChild:yesButton];
    
    // Adding a button that confirms that you do NOT want to use a resource.
    SKSpriteNode *noButton = [[SKSpriteNode alloc] initWithImageNamed:@"stopbutton.png"];
    noButton.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMidY(self.frame)-200);
    noButton.name = @"noButton";
    [self addChild:noButton];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    //Did you click the yes button?
    if ([clickedNode.name isEqualToString:@"yesButton"]) {
        [_delegate resourceConfirmDidFinish];
        NSLog(@"Yes, I want to use that resource!");
        [_delegate useResourceConfirmed];
    }
    //Did you click the no button?
    else if ([clickedNode.name isEqualToString:@"noButton"]) {
        [_delegate resourceConfirmDidFinish];
        NSLog(@"No, I don't want to use that resource.");
    }
    
    
}


@end
