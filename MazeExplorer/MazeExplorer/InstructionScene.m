//
//  InstructionScene.m
//  MazeExplorer
//
//  Created by Helen Woodward on 3/30/14.
//
//

#import "InstructionScene.h"

@implementation InstructionScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor lightGrayColor];
        SKLabelNode *title = [[SKLabelNode alloc] init];
        title.text = @"Instructions";
        title.fontSize = 40;
        title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
        title.fontColor = [SKColor blackColor];
        [self addChild:title];
        
        SKLabelNode *instructions = [[SKLabelNode alloc] init];
        instructions.text = @"When you select a maze you will see a maze on the top part of the scene and a resource area on the bottom. In the maze there will be a circle-this is you. To move in the maze touch the screen in the direction you want to move (above the player for up, right for right and so on). \n As you move your view of the maze will move as well, and you will see specially colored blocks representing obstacles and resources which disapear after you move over them. \n If you move over on of the orange blocks you will gain a resource, which will be indicated at the bottom of the screen. To use a resource click on it and read about how it works before confirming or cancelling its use. \n If you move over one of the brown obstacles the maze will be replaced with a n obstacle for you to solve. Follow the instructions on the screen and it will dismiss when you succeed.";
        instructions.fontSize = 25;
        instructions.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-300);
        instructions.fontColor = [SKColor blackColor];
        [self addChild:instructions];
    }
    SKSpriteNode *checkButton = [[SKSpriteNode alloc] initWithImageNamed:@"checkButton.png"];
    checkButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+200);
    checkButton.name = @"checkButton";
    [self addChild:checkButton];
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"checkButton"]) {
        [_delegate instructionsDone];
    }
}


@end
