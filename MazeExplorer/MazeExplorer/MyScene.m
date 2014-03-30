//
//  MyScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"


@interface MyScene ()

@property BOOL didPresentGameViews;
@property (nonatomic) SKView *mazeView;
@property (nonatomic) SKView *resourceView;

@end

@implementation MyScene

//These are the maze strings and widths.
static const NSString* maze1String = @"*E*********  *     **      *******     **     *  ** O   * *** *  *   ****  *  ***R   *   ***S*******";
static const int maze1Width = 10;
static const NSString* maze2String = @"*****S***************           *R     **  *******  *****  **R *     *      *  *****  *  ****   *  **     *     *      **     O     ****   ** ********  *  *   **       *   *  *   **   **  *   *  *   **   *R  *          **   ******O******O***       *   *      ** ***** *   *  ******     * *** *      **   * * *   ****** **   *****        * **           *  *** ***********  *      **R          O      *****************E***";
static const int maze2Width = 20;
static const NSString* maze3String = @"**************************   *   *   *           ** * * * * * * * ******* **O* *R*   *   * *       ** * *********** * ******** *             *      O** ********************* ** *                *    **   **** ******* * * ***** * *            * * *  E* * *** * ******** *   *** *   * * *      * ****R** ***O* * * ** *  O   * ** *   * *   ** **** *** ** * *** *   **    * *   ** * *   * ******* * * **** * * * * *   *R* * *   ** *   * * * * * * * *** ** ***** * * * * *     * **      O* * * * * * * * ** ***** * * * * * * * * **     * *   *   * * *   ** * * * ********* * ****** * * *                 ********************S*****";
static const int maze3Width = 25;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor lightGrayColor];
        SKLabelNode *title = [[SKLabelNode alloc] init];
        title.text = @"Maze Explorer";
        title.fontSize = 40;
        title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
        title.fontColor = [SKColor blackColor];
        [self addChild:title];

        SKLabelNode *instructions = [[SKLabelNode alloc] init];
        instructions.text = @"Select a maze to play or click below for details on how to play.";
        instructions.fontSize = 25;
        instructions.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+300);
        instructions.fontColor = [SKColor blackColor];
        [self addChild:instructions];
        
        SKSpriteNode *maze1 = [[SKSpriteNode alloc] initWithImageNamed:@"button1.png"];
        maze1.position = CGPointMake(CGRectGetMidX(self.frame)-200,CGRectGetMaxY(self.frame)-220);
        maze1.name = @"maze1";
        [self addChild:maze1];
        
        SKSpriteNode *maze2 = [[SKSpriteNode alloc] initWithImageNamed:@"button2.png"];
        maze2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-220);
        maze2.name = @"maze2";
        [self addChild:maze2];
        
        SKSpriteNode *maze3 = [[SKSpriteNode alloc] initWithImageNamed:@"button3.png"];
        maze3.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMaxY(self.frame)-220);
        maze3.name = @"maze3";
        [self addChild:maze3];
        
        
        SKSpriteNode *help = [[SKSpriteNode alloc] initWithImageNamed:@"help.png"];
        help.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+150);
        help.name = @"help";
        [self addChild:help];
        
        _didPresentGameViews = NO;
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"maze1"]) {
        [self launchMazewithString:maze1String andWidth:maze1Width];
    }
    if ([clickedNode.name isEqualToString:@"maze2"]) {
        [self launchMazewithString:maze2String andWidth:maze2Width];
    }
    if ([clickedNode.name isEqualToString:@"maze3"]) {
        [self launchMazewithString:maze3String andWidth:maze3Width];
    }
    
    if ([clickedNode.name isEqualToString:@"help"]) {
        [self displayInstructions];
    }
    
}

-(void) launchMazewithString: (NSString *) mazeString andWidth:(int) mazeWidth {
    if (!_didPresentGameViews) {
        
        _mazeView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        MazeScene *mazeScene = [[MazeScene alloc] initWithSize:CGSizeMake(self.frame.size.width, self.frame.size.width) String:mazeString andWidth:mazeWidth];
        [mazeScene setDelegate:self];
        
        [self.view addSubview:_mazeView];
        [_mazeView presentScene:mazeScene];
        
        _resourceView = [[SKView alloc] initWithFrame:CGRectMake(0, self.frame.size.width,
                                                                 self.frame.size.width,
                                                                 self.frame.size.height-self.frame.size.width)];
        ResourceScene *resourceScene = [[ResourceScene alloc]
                                        initWithSize:CGSizeMake(self.frame.size.width,
                                                                self.frame.size.height-self.frame.size.width)];
        [resourceScene setDelegate:self];
        [self.view addSubview:_resourceView];
        [_resourceView presentScene:resourceScene];
        
        
        _didPresentGameViews = YES;
    }

}

-(void) displayInstructions {
    if(!_didPresentGameViews) {
        
        NSLog(@"Pretend I just showed you instructions");
        _mazeView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width)];
        InstructionScene *instructions = [[InstructionScene alloc] initWithSize:CGSizeMake(self.frame.size.height, self.frame.size.width)];
        [instructions setDelegate:self];
        [self.view addSubview:_mazeView];
        [_mazeView presentScene:instructions];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)increaseResourceCounter {
    [(ResourceScene*)_resourceView.scene increaseCounterByOne];
}

-(void)useResource
{
    [(MazeScene*)_mazeView.scene resourceUsed];
}

-(void)useResourceConfirmed
{
    [(ResourceScene*)_resourceView.scene useResourceConfirmed];
}



@end
