//
//  ResourceConfirm.m
//  MazeExplorer
//
//  Created by CS121 on 3/27/14.
//
//

#import "ResourceConfirm.h"

@implementation ResourceConfirm

-(id) initWithSize:(CGSize)size andResource:(ResourceType)resourceType
{
    self = [super initWithSize:size];
    
    _resourceBeingConfirmed = resourceType;
    self.backgroundColor = [SKColor blueColor];
    
    DSMultilineLabelNode *label = [[DSMultilineLabelNode alloc] init];
    label.fontSize = 30;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    label.paragraphWidth = self.frame.size.width - 100;
    
    switch(_resourceBeingConfirmed) {
        case Notepad: {
            label.text = @"You are going to use a notepad resource. Using a resource cannot be undone. \n \n A notepad resource dismisses the Simon obstacle. However if used when not in a Simon obstacle the resource is used to no effect. \n \n Click the green check to confirm this action, the red x to cancel.";
            break;
        }
        case Potion: {
            label.text = @"You are going to use a potion of super strength. Once used a potion is irretrivably consumed. \n \n A potion of super strength allows you to easily complete the pit fill and avalanche clearing obstacles. However if used when not in those situations there is no effect. \n \n Click the green check to confirm this action, the red x to cancel.";
            break;
        }
        case Wing: {
            label.text = @"You are going to use a wing resource. Using the wings of Icarus cannot be undone. \n \n A wing resource dismisses the Rope obstacle. However, if used when not in a Rope obstacle, the resource is used to no effect. \n \n Click the green check to confirm this action, the red x to cancel.";
            break;
        }
        default: {//Default is Magic and also handles that case
            label.text = @"You are going to use a magic resource. Using a resource cannot be undone. \n \n A magic resource dismisses the drag and drop and trace obstacles. However if used when not in these obstacles the resource is used to no effect. \n \n Click the green check to confirm this action, the red x to cancel.";
            break;
        }
    }
    
    
    [self addChild:label];
    
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
        //NSLog(@"Yes, I want to use that resource!");
        [_delegate useResourceConfirmed:_resourceBeingConfirmed];
    }
    //Did you click the no button?
    else if ([clickedNode.name isEqualToString:@"noButton"]) {
        [_delegate resourceConfirmDidFinish];
        //NSLog(@"No, I don't want to use that resource.");
    }
    
    
}


@end
