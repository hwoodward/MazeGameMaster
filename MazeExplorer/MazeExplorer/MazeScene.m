//
//  MazeScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//

#import "MazeScene.h"

@interface MazeScene ()

@property float cellWidth;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) Maze* maze;
@property CGPoint newPos;
@property CGPoint playerLoc;
@property CGPoint endLoc;
@property SKAction *move;
@property ObstacleType obstacleInUse;
@property (nonatomic) SKView *obstView;
@property (nonatomic) SKView *resConfirmView;
@property (nonatomic) NSMutableDictionary* resourceDict;
@property (nonatomic) SKSpriteNode* resToRemove;

@property int score;
@end

/* 
 * Constant: CELLNUM
 * Gives the length of the side of the square of the maze that will be displayed.
 */
static const int CELLNUM = 11;

@implementation MazeScene

/*
 * Method: initWithSize:
 *
 * This initializes itself, sets the background to white,
 * and calls methods to initialize the maze and player.
 */
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _cellWidth = self.frame.size.width/CELLNUM;
        
        [self mazeSetUpwithString:@"*E*********  *     **      *******     **     *  ** O   * *** *  *   ****  *  ***R   *   ***S*******" andWidth:10];
        [self addPlayer];
        _score = 0;
    }
    
    return self;
}

-(id)initWithSize:(CGSize)size String: (NSString *)mazeString andWidth: (int) mazeWidth {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _cellWidth = self.frame.size.width/CELLNUM;
        
        [self mazeSetUpwithString:mazeString andWidth: mazeWidth];
        [self addPlayer];
        _score = 0;
    }
    
    return self;
}


/*
 * Method: update:
 * 
 * Currently an auto-generated stub.
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

/*
 * Method: mazeSetup
 *
 * This method string initializes a maze (currently a hardcoded maze. Should select appropriate,
 * randomish string in the future). It then reads the maze, creating SKSpriteNodes for all of the
 * walls. It then calls startAndEndInitialization to finish setting up the maze.
 */
- (void)mazeSetUpwithString:(NSString *)mazeString andWidth: (int) mazeWidth
{
    _maze = [[Maze alloc]
             initMazeWithString:mazeString
             andWidth:mazeWidth];
    [_maze printMaze];
    
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    for (int i = 0; i < [_maze numCols]; i++)
    {
        for (int j = 0; j < [_maze numRows]; j++)
        {
            CellType cont = [_maze getContentsWithRow:j andColumn:i];
            switch (cont) {
                case Wall: {
                    //bricktexture.jpg's source: http://designm.ag/resources/free-stone-rock-textures/
                    //The image is 70px by 70px
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithImageNamed:@"bricktexture.jpg"];
                    //SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor blackColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    
                    [self addChild:cellNode];
                    break;
                }
                case Obstacle: {
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor brownColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    cellNode.name = @"Obstacle";
                    [self addChild:cellNode];
                    break;
                }
                case Resource: {
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor orangeColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    cellNode.name = @"Resource";
                    [self addChild:cellNode];
                    
                    if (_resourceDict == Nil) {
                        _resourceDict = [[NSMutableDictionary alloc] init];
                    }
                    NSArray* mazeLoc = @[[NSNumber numberWithInt:i], [NSNumber numberWithInt:j]];
                    [_resourceDict setObject:cellNode forKey:mazeLoc];
                    
                    break;

                    
                }
                case End: {
                    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
                    _endLoc = [_maze endLoc];
                    SKSpriteNode *endNode = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:cellSize];
                    endNode.position = CGPointMake(_cellWidth*_endLoc.x + (_cellWidth/2),
                                                   self.frame.size.height - _cellWidth*_endLoc.y - _cellWidth/2);
                    [self addChild:endNode];
                    break;
                    
                }
                case Start:{
                    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
                    CGPoint start = [_maze startLoc];
                    SKSpriteNode *startNode = [[SKSpriteNode alloc] initWithColor:[SKColor cyanColor] size:cellSize];
                    startNode.position = CGPointMake(_cellWidth*start.x + (_cellWidth/2),
                                                     self.frame.size.height - _cellWidth*start.y - _cellWidth/2);
                    _playerLoc = start;
                    [self addChild:startNode];
                    
                    break;
                    
                }
                default: { //Currently handles the maze-shift that puts the player over the start node.
                    break;
                }
            }
        }
    }
    [self shiftMaze];
}

/*
 * Method: startAndEndInitialization
 *
 * This method shifts all of the cells so that the
 * start will be centered underneath the player.
 */

-(void)shiftMaze
{
    //NSLog(@"moving maze to where it belongs");
    CGPoint start = [_maze startLoc];
    
    int xDiff = (CELLNUM/2) - start.x;
    int yDiff = start.y - (CELLNUM/2);
    NSArray *cells = [self children];
    SKAction *move = [SKAction moveByX:_cellWidth*xDiff y:_cellWidth*yDiff duration:0.0];
    for (int i = 0; i < [cells count]; i++) {
        SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
        [cell runAction:move];
    }
}

/*
 * Method: addPlayer
 *
 * This adds the player as an SKSpriteNode to the middle of the area designated for the maze.
 * It should end up right over the start of the maze.
 */
-(void)addPlayer
{
    //_player = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(_cellWidth-20, _cellWidth-20)];
    
    //Player image source: http://findicons.com/icon/69390/circle_blue
    
    _player = [[SKSpriteNode alloc] initWithImageNamed:@"bluecircle.png"];
    
    float playerX = (CELLNUM*_cellWidth)/2;
    float playerY = self.frame.size.height - ((CELLNUM*_cellWidth)/2);
    _player.position = CGPointMake(playerX, playerY); //Will change later
    [self addChild:_player];
}

/*
 Method: touchesBegan: Allows the player to move up, down, left, and right 
 in the maze. Shifts the maze appropriately. Makes sure that the player can't
 go through walls. Moves to the obstacle scene if the player hits an obstacle.
 */

//Attempting to make a version of this that responds to up, down, left, right touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_obstView == Nil && _resConfirmView == Nil) {
  
        CGPoint touchPos  =[[touches anyObject] locationInView:self.view];
        
        NSArray *cells = [self children];

        //Get the players new position and the movement to shift the maze by
        [self setMoveandnewPosfromTouch:touchPos];

        //Now we take action based on the new position we intend to move to
        CellType cellContents = [_maze getContentsWithRow:_newPos.y andColumn:_newPos.x];
        if (_resToRemove != Nil) {
            [_resToRemove removeFromParent];
        }
        switch (cellContents) {
            case Obstacle: {
                [self launchObstacle:[_maze getSecondaryTypeWithRow:_newPos.y andColumn:_newPos.x].Obstacle];
                break;
            }
            case Resource: {
                
                for (int i = 0; i< [cells count]; i++) {
                    SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                    [cell runAction:_move];
                }
                _resToRemove = [_resourceDict
                                objectForKey:@[[NSNumber numberWithFloat:_newPos.x],
                                               [NSNumber numberWithFloat:_newPos.y]]];
                [_player runAction:_move.reversedAction completion:^{
                    [_resToRemove removeFromParent];
                    _resToRemove = Nil;
                }];
                _playerLoc = _newPos;
                [self obtainResource: [_maze getSecondaryTypeWithRow:_newPos.y andColumn:_newPos.x].Resource];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
                break;
            }
            case Wall: {
            case Start:  //After we leave the start we want to make it a wall so we don't leave the maze and error.
                break;
            }
            case End: {
                [_delegate mazeSolved:_score];
            }
            default: { //Default is that it is a path (this handles Path)
                [self runAction:[SKAction playSoundFileNamed:@"Mario_Jumping.mp3" waitForCompletion:NO]];
                for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:_move];
                }
                [_player runAction:_move.reversedAction];
                _playerLoc = _newPos;
                break;
            }
        }

    }
    
}


-(void) setMoveandnewPosfromTouch: (CGPoint) touchPos
{
    //Here we get the direction we intend to move and set the actions and new position
    float xMidpoint = self.view.frame.size.width/2;
    float yMidpoint = self.view.frame.size.height/2;
    
    float xDif = touchPos.x - xMidpoint;
    float yDif = touchPos.y - yMidpoint;
    _newPos = _playerLoc;
    
    if (abs(xDif)>abs(yDif)) {
        if(xDif>0) { //move right                NSLog(@"Try to move right");
            _move = [SKAction moveByX:-_cellWidth y:0.0 duration:1.0];
            _newPos.x++;
        }
        else { //move left                NSLog(@"Try to move left");
            _move = [SKAction moveByX:_cellWidth y:0.0 duration:1.0];
            _newPos.x--;
        }
    }
    else {
        if(yDif<0) { //move up            NSLog(@"Try to move up");
            _move = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
            _newPos.y--;
        }
        else { //move down            NSLog(@"Try to move down");
            _move = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
            _newPos.y++;
        }
    }
}

/*
 launchObstacle: (ObstacleType) type
 creates and launches an obstacle of the type given by the input (it defaults to the default obstacle DragDrop.
*/
-(void) launchObstacle: (ObstacleType) type {
    _obstView = [[SKView alloc] initWithFrame:self.view.frame];
    
    id <Obstacle> obstScene;
    
    switch (type) {
        case RandomO: {
            [self launchObstacle:(ObstacleType) (arc4random() % (int) RandomO)]; //This randomly picks an obstacle before RandomO in the list
            return;
        }
        case Simon: {
            obstScene = [[SimonScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = Simon;
            break;
        }
        case Pit: {
            obstScene = [[PitFillScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = Pit;
            break;
        }
        case Avalanche: {
            obstScene = [[AvalancheScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = Avalanche;
            break;
        }
        case Trace: {
            obstScene = [[TraceScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = Trace;
            break;
        }
        case Rope: {
            obstScene = [[RopeScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = Rope;
            break;
        }
        default: { //Default is DragDrop and also handles that case
            obstScene = [[ObstacleScene alloc] initWithSize:self.frame.size];
            _obstacleInUse = DragDrop;
            break;
        }
    }
    [obstScene setDelegate:self];
    [self.view addSubview:_obstView];
    [_obstView presentScene:(SKScene*)obstScene];
}

/*
 obtainResource: (ResourceType) type
 tells the resourceScene (via myScene) that the player has obtained a resource of the given type
 */
-(void) obtainResource:(ResourceType) type {
    switch (type) {
        case RandomR: {
            [self obtainResource: (ResourceType) (arc4random() % (int) RandomR)]; //Randomly select a resource before RandomR
            return;
        }
        case Notepad: {
            [self.delegate increaseResourceCounter:Notepad];
            break;
        }
        case Potion: {
            [self.delegate increaseResourceCounter:Potion];
            break;
        }
        case Wing: {
            [self.delegate increaseResourceCounter:Wing];
            break;
        }
        default: { //Default is a Magic resource and also handles that case
            [self.delegate increaseResourceCounter:Magic];
            break;
        }
    }
    _score++; //Do this here so we don't gain twice for randomR case
}

/*
 obstacleDidFinish:
 This is called by an obstacle using this as its delegate when it has been completed.
 It ends the obstacle scene and also removes the obstacle node.
 */

- (void)obstacleDidFinish
{
    if(_obstView != nil) {
        NSArray *cells = [self children];
        for (int i = 0; i< [cells count]; i++) {
            SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
            [cell runAction:_move];
        }
        [_player runAction:_move.reversedAction completion:^{
            CGPoint obstaclePoint = _player.position;
            NSArray * nodesAtCurrentPos = [self nodesAtPoint: obstaclePoint];
            for (int i = 0; i<[nodesAtCurrentPos count]; i++) {
                SKSpriteNode * node = nodesAtCurrentPos[i];
                if([node.name  isEqual: @"Obstacle"]) {
                    [node removeFromParent];
                }
            }
        }];        _playerLoc = _newPos;
        [_obstView removeFromSuperview];
        _obstView = Nil;
        [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
        _score += 3;
    }
   }

/*
 obstacleDidFail:
 This is called by an obstacle using this as its delegate when the user did something wrong
 and the obstacle wants to kick the user out without removing the node.
 
 I need to improve this code so that it puts the player back where they were before starting the obstacle
 */

- (void)obstacleDidFail
{
    if(_obstView != nil) {
        [_obstView removeFromSuperview];
        _obstView = Nil;
        _score--;
    }
}

/*
 resourceConfirmDidFinish
 This is called by the ResourceConfirm scene when you answer "yes" or "no".
 It gets rid of the ResourceConfirm screen.
 */
-(void)resourceConfirmDidFinish
{
    [_resConfirmView removeFromSuperview];
    _resConfirmView = Nil;
}

/*
 useResourceConfirmed
 This tells MyScene that a resource was used, so that it can tell ResourceScene.
 Then closes the confirmation screen and any obstacles in use
 */
-(void)useResourceConfirmed:(ResourceType) type
{
    _score--;
    [self.delegate useResourceConfirmed:type];
    [self resourceConfirmDidFinish];
    
    if (_obstView != nil) {
        switch (type){
            case Notepad: {
                if (_obstacleInUse == Simon) {
                    [self obstacleDidFinish];
                }
                break;
            }
            case Potion: {
                if (_obstacleInUse == Pit || _obstacleInUse == Avalanche) {
                    [self obstacleDidFinish];
                }
                break;
            }
            default: { //Default is Magic and handles that case
                if (_obstacleInUse == DragDrop ||  _obstacleInUse == Trace ||
                    _obstacleInUse == Rope) {
                    [self obstacleDidFinish];
                }
                break;
            }
        }
    }
}

/*
 emptyMazeCellWithRow: 
 input: The row and column of a MazeCell.
 result: Changes the MazeCell's contents to be an empty space.
*/
-(void)emptyMazeCellWithRow:(int) row andCol:(int) col
{
    [_maze emptyContentsWithRow: row andColumn: col];
}

/*
 resourceUsed:
 result: Uses a resource. (Responds to user interaction with resourceScene.)
 */
-(void)resourceUsed:(ResourceType) type
{
    _resConfirmView = [[SKView alloc] initWithFrame:self.view.frame];
    ResourceConfirm *resConfirm;
    resConfirm = [[ResourceConfirm alloc] initWithSize:self.frame.size andResource:type];
    [resConfirm setDelegate: self];
    [self.view addSubview:_resConfirmView];
    [_resConfirmView presentScene:resConfirm];
}

@end