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
@property SKLabelNode *scoreLabel;
@end

@implementation MyScene

//These are the maze strings and widths.
//BE CAREFUL WITH MAZE STRINGS, see the mazeCell.m to check the translation of characters to cell contents and make sure the maze stays solvable


static const NSString* maze1String = @"*E*********  *    f**  6   *******     **     *  ** 7   * *** *  *   ****  *  ***b   *   ***S*******";
static const int maze1Width = 10;
static const NSString* maze2String = @"*****S***************           *a     **  *******  *****  **b *     *      *  *****  *  ****   *  **     *     *      **     5     ****   ** ********  *  *   **       *   *  *   **   **  *   *  *   **   *c  *          **   ******1******3***       *   *      **!***** *   *  ******     * *** *      **   * * *   ****** **   *****        * **!          *  *** *********** !*      **R          2      *****************E***";
static const int maze2Width = 20;
static const NSString* maze3String = @"**************************   *   *   *          &** * * * * * * * ******* **O* *b*   *   * *       ** * *********** * ******** *             *      1** ********************* ** *                *    **   **** ******* * * ***** * *            * * *  E* * *** * ******** *   *** *   * * *      * ****a** ***5* * * ** *  6   * ** *   * *   ** **** *** ** * *** *   **    * *   ** * *   * ******* * * **** * * * * *   *R* * *   ** *   * * * * * * * *** ** ***** * * * * *     * **      2* * * * * * * * ** ***** * * * * * * * * **     * *   *   * * *   ** * * * ********* * ****** * * *&                ********************S*****";
static const int maze3Width = 25;
static const NSString* maze4String = @"***********************E***************************          O          *      1                   **** ********************************** ************f                              6               a************************* **************************                                                ****************************************2***********    !        !          !       *               ************* ***********^***** ************* ******abcfR*                ^*^      !               b****OO************* *****^************* ************   O         *     &             &*             ******** ****************** ********************O***         *&                       &        O    **&********************** ***************** ********                &          *     &              ********S******************************************";
static const int maze4Width = 50;
static const NSString* maze5String = @"***********************E**     %   %     %   %   **R************************    $    $    $   $    ************************ **      ^  ^     ^    ^  ** ************************   #     #    #      # ************************ **    &    &    &     &  ** ************************  !     !     !    !   ************************ **     ?    ?     ?  ?   **S***********************";

static const int maze5Width = 25;

static const NSString* maze6String = @"************************************************************R*                                            *          E* **************************O******************* ***********                          * *                 * *        *************************** * * ***** ********* * *   RR   **                          * *     * *         * *        **  **  ******************* * ******* *********** ***********  **  *$               R* * *                 *          **  **  * *************** * * * *************** ********** **  **  * *       *$      * * * *R  *                    * **  **  * * ***** * ******* * * *** * ******************** ** **** * * * O * * *       * *     *                    * ** *    * * * * * * * ******* ******* ******************** ** * **** * * * * * * *            *                     * ** *    * * * * * * * * ********** *******O********1****** ** **** * * * * * * * *          * *                     * ** *    * * * * * * * **********O* ********************* * ** * **** * * * * * * *          * *                     * ** *    * * * * * * * ********** * * * * ***************** ** **** * * * * * * *          * * * * * *                5**      * c * * * * * ******** * * * * * * *************** ** ********** * * * *        * * * * * * * *   * O O *   * **            * * * * ****** * * * * * * * * * * * * * * * *************** * *O* *    * * * * * * * * * * * * * * * * **              * * * *  * * * * * * * * * * * * * * * * * **   ****** ***** * *R*  * * * * * *a* * * * * * * * * * * **        *  **** * ****** * * *** *** *** * * * * * * * * ************   ** *     ** * *           * * * * * * * * * **           * *  ***** ** * ************* * * * * * * * * ** ********* * *      * **               * * * * * * * * * **        R* * ****** * ** ************* * * * * * * * * * ** ********* * *      * ** *             * * * * * * * * * **           * * ****** ** ***** ******* * * * * * * * * * ************** *      * **     * *   *   * * * * * * * * * **             **** *** **   * *   *   *R* * *   * *   * * ** *****  ***  *      * **   * *********** ******* ******* ** *R R*  *^*  * ****** **   *                             ** * R *  * *  *      * ** * ***************************** ** *!***  * *  ****** * ** * *                           * ** * # *  * *       * * ** * * *************************** ** ***!*  * **** *  * * ** * * *                          b** *   *  *      *  * * ** *O* * **************************** *#***  * **** *  * * ** *** * 2                         ** *   *  * *    *             * **************************** *** *  * * ****  *** ******** *                         ** *   *  * * *R    *          * * *********************** ** * ***  * * ********** * ***** * *                     * ** *   *  * * *                  * * ******************* * ** *** *  * * ************** ***** * *                 * * ** *   *  * *                    *O* *O*R*O*R*O*R*O*R* * * ** * ***  * *******O************** * ***************** * * ** *   *  * *                    * *                   * * ** *** *  * *******************  * ********************* * ** *   *  *^*f                   *                       * ** *O***  *********  *************************************6** *                                                       **S*********************************************************";

static const int maze6Width = 59;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor lightGrayColor];
        
        SKColor *teal = [SKColor colorWithRed:0.004 green:0.82 blue:0.906 alpha:1.0];
        
        SKLabelNode *title = [[SKLabelNode alloc] init];
        title.text = @"Maze Explorer";
        title.fontSize = 40;
        title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
        title.fontColor = [SKColor blackColor];
        [self addChild:title];
        
        _scoreLabel = [[SKLabelNode alloc] init];
        _scoreLabel.text = @"";
        _scoreLabel.fontSize = 30;
        _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-100);
        _scoreLabel.fontColor = [SKColor blackColor];
        [self addChild:_scoreLabel];

        SKLabelNode *instructions = [[SKLabelNode alloc] init];
        instructions.text = @"Select a maze to play or click below for details on how to play.";
        instructions.fontSize = 25;
        instructions.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+300);
        instructions.fontColor = [SKColor blackColor];
        [self addChild:instructions];
        
        SKSpriteNode *maze1 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze1.position =  CGPointMake(CGRectGetMidX(self.frame)-200,CGRectGetMaxY(self.frame)-200);
        maze1.name = @"maze1";
        [self addChild:maze1];
        
        SKLabelNode *maze1num = [[SKLabelNode alloc] init];
        maze1num.position = CGPointMake(CGRectGetMidX(self.frame)-200,CGRectGetMaxY(self.frame)-225);
        maze1num.name = @"maze1";
        maze1num.text = @"1";
        maze1num.fontColor = [SKColor blackColor];
        maze1num.fontSize = 70;
        [self addChild:maze1num];
        
        SKSpriteNode *maze2 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-200);
        maze2.name = @"maze2";
        [self addChild:maze2];
        
        SKLabelNode *maze2num = [[SKLabelNode alloc] init];
        maze2num.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-225);
        maze2num.name = @"maze2";
        maze2num.text = @"2";
        maze2num.fontColor = [SKColor blackColor];
        maze2num.fontSize = 70;
        [self addChild:maze2num];
        
        SKSpriteNode *maze3 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze3.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMaxY(self.frame)-200);
        maze3.name = @"maze3";
        [self addChild:maze3];
        
        SKLabelNode *maze3num = [[SKLabelNode alloc] init];
        maze3num.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMaxY(self.frame)-225);
        maze3num.name = @"maze3";
        maze3num.text = @"3";
        maze3num.fontColor = [SKColor blackColor];
        maze3num.fontSize = 70;
        [self addChild:maze3num];
        
        SKSpriteNode *maze4 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze4.position = CGPointMake(CGRectGetMidX(self.frame)-200,CGRectGetMaxY(self.frame)-350);
        maze4.name = @"maze4";
        [self addChild:maze4];
        
        SKLabelNode *maze4num = [[SKLabelNode alloc] init];
        maze4num.position = CGPointMake(CGRectGetMidX(self.frame)-200 ,CGRectGetMaxY(self.frame)-375);
        maze4num.name = @"maze4";
        maze4num.text = @"4";
        maze4num.fontColor = [SKColor blackColor];
        maze4num.fontSize = 70;
        [self addChild:maze4num];
        
        SKSpriteNode *maze5 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze5.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-350);
        maze5.name = @"maze5";
        [self addChild:maze5];
        
        SKLabelNode *maze5num = [[SKLabelNode alloc] init];
        maze5num.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-375);
        maze5num.name = @"maze5";
        maze5num.text = @"5";
        maze5num.fontColor = [SKColor blackColor];
        maze5num.fontSize = 70;
        [self addChild:maze5num];
        
        SKSpriteNode *maze6 = [[SKSpriteNode alloc] initWithColor:teal size:CGSizeMake(100, 100)];
        maze6.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMaxY(self.frame)-350);
        maze6.name = @"maze6";
        [self addChild:maze6];
        
        SKLabelNode *maze6num = [[SKLabelNode alloc] init];
        maze6num.position = CGPointMake(CGRectGetMidX(self.frame)+200,CGRectGetMaxY(self.frame)-375);
        maze6num.name = @"maze6";
        maze6num.text = @"6";
        maze6num.fontColor = [SKColor blackColor];
        maze6num.fontSize = 70;
        [self addChild:maze6num];
        
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
    if(_didPresentGameViews == NO) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        //what node am I in?
        SKNode *clickedNode = [self nodeAtPoint:location];
       // NSLog(clickedNode.name);
        
        if ([clickedNode.name isEqualToString:@"maze1"]) {
            [self launchMazewithString:maze1String andWidth:maze1Width];
        }
        if ([clickedNode.name isEqualToString:@"maze2"]) {
            [self launchMazewithString:maze2String andWidth:maze2Width];
        }
        if ([clickedNode.name isEqualToString:@"maze3"]) {
            [self launchMazewithString:maze3String andWidth:maze3Width];
        }
        if ([clickedNode.name isEqualToString:@"maze4"]) {
            [self launchMazewithString:maze4String andWidth:maze4Width];
        }
        if ([clickedNode.name isEqualToString:@"maze5"]) {
            [self launchMazewithString:maze5String andWidth:maze5Width];
        }
        if ([clickedNode.name isEqualToString:@"maze6"]) {
            [self launchMazewithString:maze6String andWidth:maze6Width];
        }
        if ([clickedNode.name isEqualToString:@"help"]) {
            [self displayInstructions];
        }
    }
}

-(void) launchMazewithString: (NSString *) mazeString andWidth:(int) mazeWidth {
    if (!_didPresentGameViews) {
        _didPresentGameViews = YES;
        [self runAction:[SKAction playSoundFileNamed:@"Mac_Start.mp3" waitForCompletion:NO]];

        
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
    }

}

-(void) mazeSolved:(int) score {
    [self runAction:[SKAction playSoundFileNamed:@"TaDa.mp3" waitForCompletion:NO]];
    _scoreLabel.text = [NSString stringWithFormat:@"You scored %d on the last maze", score];
    [_mazeView removeFromSuperview];
    _mazeView = Nil;
    [_resourceView removeFromSuperview];
    _resourceView = Nil;
    _didPresentGameViews = NO;
}

-(void) displayInstructions {
    if(!_didPresentGameViews) {
        _didPresentGameViews = YES;
        _mazeView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        InstructionScene *instructions = [[InstructionScene alloc] initWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        [instructions setDelegate:self];
        [self.view addSubview:_mazeView];
        [_mazeView presentScene:instructions];
    }
}

-(void) instructionsDone {
    [_mazeView removeFromSuperview];
    _mazeView = Nil;
    _didPresentGameViews = NO;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)increaseResourceCounter:(ResourceType) type {
    [(ResourceScene*)_resourceView.scene increaseCounterByOne:type];
}

-(void)useResource:(ResourceType) type
{
    [(MazeScene*)_mazeView.scene resourceUsed:type];
}

-(void)useResourceConfirmed:(ResourceType) type
{
    [(ResourceScene*)_resourceView.scene useResourceConfirmed:type];
}



@end
