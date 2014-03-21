//
//  MazeScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//

#import "MazeScene.h"
#import "Maze.h"

@interface MazeScene ()
//Gesture recognizer is currently broken
@property (nonatomic) UISwipeGestureRecognizer* swipeGR;
@property float cellWidth;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) Maze* maze;

@property CGPoint playerLoc;
//@property CGPoint startLoc;
@property CGPoint endLoc;
//@property CGPoint obstLoc;

@property (nonatomic) SKView *obstView;

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
        
        [self mazeSetUp];
        [self addPlayer];
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
- (void)mazeSetUp
{
    _maze = [[Maze alloc]
             initMazeWithString:@"*E*********  *     **      *******     **     *  ** O   * *** *  *   ****  *  ***R   *   ***S*******"
             andWidth:10];
    [_maze printMaze];
    
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    for (int i = 0; i < [_maze numCols]; i++)
    {
        for (int j = 0; j < [_maze numRows]; j++)
        {
            CellType cont = [_maze getContentsWithRow:j andColumn:i];
            switch (cont) {
                case Wall: {
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor blackColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    
                    [self addChild:cellNode];
                    break;
                }
                case Obstacle: {
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor brownColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    
                    [self addChild:cellNode];
                    break;
                }
                case Resource: {
                    SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor orangeColor] size:cellSize];
                    cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                    self.frame.size.height - _cellWidth*j - _cellWidth/2);
                    
                    [self addChild:cellNode];
                    break;
                }
                default: {
                    break;
                }
            }
        }
    }
    [self startAndEndInitialization];
}

/*
 * Method: startAndEndInitialization
 *
 * This method specially goes and finds the start and end of the maze, and colors them 
 * differently than the rest of the maze. It then shifts all of the cells so that the
 * start will be centered underneath the player.
 */
-(void)startAndEndInitialization
{
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    CGPoint start = [_maze startLoc];
    SKSpriteNode *startNode = [[SKSpriteNode alloc] initWithColor:[SKColor cyanColor] size:cellSize];
    startNode.position = CGPointMake(_cellWidth*start.x + (_cellWidth/2),
                                     self.frame.size.height - _cellWidth*start.y - _cellWidth/2);
    _playerLoc = start;
    [self addChild:startNode];
    
    _endLoc = [_maze endLoc];
    SKSpriteNode *endNode = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:cellSize];
    endNode.position = CGPointMake(_cellWidth*_endLoc.x + (_cellWidth/2),
                                   self.frame.size.height - _cellWidth*_endLoc.y - _cellWidth/2);
    [self addChild:endNode];
    
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
    _player = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(_cellWidth-20, _cellWidth-20)];
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
    
    if (_obstView == Nil) {
    /*
        CGPoint fingerpos = [[touches anyObject] locationInView:self.view];
  
        float xMidpoint = self.view.frame.size.width/2;
        float yMidpoint = self.view.frame.size.height/2;
    

        NSArray *cells = [self children];
        SKAction *moveDown = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
        SKAction *moveUp = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
        SKAction *moveLeft = [SKAction moveByX:-_cellWidth y:0.0 duration:1.0];
        SKAction *moveRight = [SKAction moveByX:_cellWidth y:0.0 duration:1.0];
        NSString *cont;
        NSString *contOfAdjoiningCell;
        BOOL didMove = NO;
        */
        /* Refactoring idea:
         * First call a "get direction" (already made) using fingerpos and SKAction *move to get the cellToMoveTo (it sets the SKAction to the correct thing. It also returns the CGPoint of the new loc.
         * Switch on the contents of the cell: (for start use if statements and string comparing, but I have created typdef.h which defines CellType)
         * If the cell is one that allows movement then call the move action (which moves in the right direction)
         * (Eventually have a seperate type and case for each obstacle)
         */
        
        // Start of the refactored code:
        CGPoint touchPos  =[[touches anyObject] locationInView:self.view];
        
        NSArray *cells = [self children];
        SKAction *move;
        BOOL didMove = NO;

        CGPoint newPos = [self getDirection:touchPos action:move];
        CellType cellContents = [_maze getContentsWithRow:newPos.y andColumn:newPos.y];
        switch (cellContents) {
            case Obstacle: {
                for (int i = 0; i< [cells count]; i++) {
                    SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                    [cell runAction:move];
                }
                didMove = YES;
                NSLog(@"Obstacle!!");
                _obstView = [[SKView alloc] initWithFrame:self.view.frame];
                ObstacleScene *obstScene = [[ObstacleScene alloc] initWithSize:self.frame.size];
                [obstScene setDelegate:self];
                [self.view addSubview:_obstView];
                [_obstView presentScene:obstScene];
                break;
            }
            case Resource: {
                for (int i = 0; i< [cells count]; i++) {
                    SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                    [cell runAction:move];
                }
                didMove = YES;
                [self increaseResourceCounter];
                CGPoint resourcePoint = _player.position;
                NSArray * nodesAtCurrentPos = [self nodesAtPoint: resourcePoint];
                SKSpriteNode * resourceNode = nodesAtCurrentPos[0];
                [resourceNode removeFromParent];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
                break;
            }
            case Wall: {
                NSLog(@"Wall");
                break;
            }
            case End: {
                NSLog(@"End of Maze!");
            }
            default: { //Default is that it is a path (this handles both Path and Start cases
                for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:move];
            }
                didMove = YES;
                break;
            }
        }

        /*
        //Going up:
        //This ridiculously long if statement ensures that the player is touching in the right place, that the destination
        // is not a wall, and that the original position is not the start node.
        // The cont compare part may need to be changed if some of our ends are not at the top of the screen.
        if (fingerpos.y < yMidpoint-100 && fingerpos.x > xMidpoint-100 && fingerpos.x < xMidpoint+100 && ![_maze isWallCellWithRow: _playerLoc.y-1 andColumn: _playerLoc.x]){
        
            _playerLoc.y--;
            cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];

            for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:moveDown];
            }
            
            contOfAdjoiningCell = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
            if (![contOfAdjoiningCell compare:@"R"]){
                CGPoint resourcePoint = _player.position;
                resourcePoint.y += _cellWidth;
                NSArray * nodesAtCurrentPos = [self nodesAtPoint: resourcePoint];
                SKSpriteNode * resourceNode = nodesAtCurrentPos[0];
                [resourceNode removeFromParent];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
            }
        
            [_player runAction: moveUp];
            didMove = YES;
        }
    
        //Going down:
        //This ridiculously long if statement ensures that the player is touching in the right place, that the destination
        // is not a wall, and that the original position is not the start node.
        // The cont compare part may need to be changed if some of our starts are not at the bottom of the screen.
        else if (fingerpos.y > yMidpoint+100 && fingerpos.x > xMidpoint-100 && fingerpos.x < xMidpoint+100 && ![_maze isWallCellWithRow: _playerLoc.y+1 andColumn: _playerLoc.x]){
        
            _playerLoc.y++;
            cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];

            for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:moveUp];
            }
            
            contOfAdjoiningCell = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
            if (![contOfAdjoiningCell compare:@"R"]){
                CGPoint resourcePoint = _player.position;
                resourcePoint.y -= _cellWidth;
                NSArray * nodesAtCurrentPos = [self nodesAtPoint: resourcePoint];
                SKSpriteNode * resourceNode = nodesAtCurrentPos[0];
                [resourceNode removeFromParent];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
            }
            
            [_player runAction: moveDown];
            didMove = YES;
            
       
        }
    
        //Going left:
        //This ridiculously long if statement ensures that the player is touching in the right place, and that the
        // destination is not a wall.
        else if (fingerpos.x < xMidpoint-100 && fingerpos.y > yMidpoint-100 && fingerpos.y < yMidpoint+100 && ![_maze isWallCellWithRow: _playerLoc.y andColumn: _playerLoc.x-1]){
        
            _playerLoc.x--;
            cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
            for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:moveRight];
            }
            
            contOfAdjoiningCell = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
            if (![contOfAdjoiningCell compare:@"R"]){
                CGPoint resourcePoint = _player.position;
                resourcePoint.x -= _cellWidth;
                NSArray * nodesAtCurrentPos = [self nodesAtPoint: resourcePoint];
                SKSpriteNode * resourceNode = nodesAtCurrentPos[0];
                [resourceNode removeFromParent];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
            }
            
            [_player runAction: moveLeft];
            didMove = YES;
        }

        //Going right:
        //This ridiculously long if statement ensures that the player is touching in the right place, and that the
        // destination is not a wall.
        else if (fingerpos.x > xMidpoint+100 && fingerpos.y > yMidpoint-100 && fingerpos.y < yMidpoint+100 && ![_maze isWallCellWithRow: _playerLoc.y andColumn: _playerLoc.x+1]){
        
            _playerLoc.x++;
            cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
        
            for (int i = 0; i< [cells count]; i++) {
                SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
                [cell runAction:moveLeft];
            }
            
            contOfAdjoiningCell = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
            if (![contOfAdjoiningCell compare:@"R"]){
                CGPoint resourcePoint = _player.position;
                resourcePoint.x += _cellWidth;
                NSArray * nodesAtCurrentPos = [self nodesAtPoint: resourcePoint];
                SKSpriteNode * resourceNode = nodesAtCurrentPos[0];
                [resourceNode removeFromParent];
                [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];
            }
            
            [_player runAction: moveRight];
            didMove = YES;
        }
         
        //This should only run if the player actually moves.
        //Opens up the obstacle scene if you run into an obstacle.
        if (![cont compare:@"O"] && didMove) {
            NSLog(@"Obstacle!!");
            _obstView = [[SKView alloc] initWithFrame:self.view.frame];
            ObstacleScene *obstScene = [[ObstacleScene alloc] initWithSize:self.frame.size];
            [obstScene setDelegate:self];
            [self.view addSubview:_obstView];
            [_obstView presentScene:obstScene];
        }
        //This should call the function in MyScene that calls the function in ResourceScene that increases the counter.
        if (![cont compare:@"R"] && didMove) {
            [self tellMySceneToIncreaseResourceCounter];
        }
    */
        didMove = NO; 
    }
    
}

-(CGPoint) getDirection:(CGPoint) touchPos action:(SKAction *)move {
    float xMidpoint = self.view.frame.size.width/2;
    float yMidpoint = self.view.frame.size.height/2;
    
    float xDif = touchPos.x - xMidpoint;
    float yDif = touchPos.y - yMidpoint;
    CGPoint newPos = _playerLoc;

    if (abs(xDif)>abs(yDif)) {
        if(xDif>0) { //move right
            move = [SKAction moveByX:_cellWidth y:0.0 duration:1.0];
            newPos.x++;
        }
        else { //move left
            move = [SKAction moveByX:-_cellWidth y:0.0 duration:1.0];
            newPos.x--;
        }
    }
    else {
        if(yDif>0) { //move up
            move = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
            newPos.y++;
        }
        else { //move down
            move = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
            newPos.y--;
        }
    }
    return newPos;
}

/*
 obstacleDidFinish:
 This is called by an obstacle using this as its delegate when it has been completed.
 It ends the obstacle scene and also removes the obstacle node.
 */

- (void)obstacleDidFinish
{
    [_obstView removeFromSuperview];
    _obstView = Nil;
    NSArray * nodesAtCurrentPos = [self nodesAtPoint: _player.position];
    SKNode * obstacleNode = nodesAtCurrentPos[0];
    [obstacleNode removeFromParent];
    [self emptyMazeCellWithRow:_playerLoc.y andCol: _playerLoc.x];

}

-(void)increaseResourceCounter
{
    [self.delegate increaseResourceCounter];
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

@end
