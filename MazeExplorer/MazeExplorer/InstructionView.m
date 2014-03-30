//
//  InstructionView.m
//  MazeExplorer
//
//  Created by Helen Woodward on 3/30/14.
//
//

#import "InstructionView.h"

@implementation InstructionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *instructions = [[UILabel alloc] init];
        instructions.numberOfLines =0;
        instructions.text = @"When you select a maze you will see a maze on the top part of the scene and a resource area on the bottom. In the maze there will be a circle-this is you. To move in the maze touch the screen in the direction you want to move (above the player for up, right for right and so on). \n As you move your view of the maze will move as well, and you will see specially colored blocks representing obstacles and resources which disapear after you move over them. \n If you move over on of the orange blocks you will gain a resource, which will be indicated at the bottom of the screen. To use a resource click on it and read about how it works before confirming or cancelling its use. \n If you move over one of the brown obstacles the maze will be replaced with a n obstacle for you to solve. Follow the instructions on the screen and it will dismiss when you succeed.";
        instructions.textColor = [UIColor blackColor];
        [self addChild:instructions];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
